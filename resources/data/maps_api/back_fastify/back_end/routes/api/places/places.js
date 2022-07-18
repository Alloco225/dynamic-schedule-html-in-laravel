"use strict";

// var arangojs = require("arangojs");
const { Database, aql } = require("arangojs");
const turf = require("@turf/turf");

const fs = require("fs");
const path = require("path");
var slugify = require("slugify");

const multer = require("fastify-multer");

/**
 * 
 * @param {import('fastify').FastifyInstance} fastify 
 //  * @param {*} opts 
 */
module.exports = async function (fastify, opts) {
    const db = new Database({
        url: process.env.ARANGO_HOST,
        databaseName: process.env.ARANGO_DB,
        auth: { username: process.env.ARANGO_AUTH, password: process.env.ARANGO_PASSWORD },
    });

    console.log("\n ** place **");
    // const Addresses = db.collection("addresses");
    // const Users = db.collection("users");

    fastify.register(require("fastify-axios"));

    // Read
    fastify.get("/populate", async function (request, reply) {
        const coordinates = [
            [5.4023858, -3.9615816],
            [5.40262, -3.96139],
            [5.40246, -3.96157],
            [5.40212, -3.96144],
            [5.40193, -3.96118],
            [5.40238, -3.96176],
            [5.40231, -3.96184],
            [5.40271, -3.96153],
            [5.40235, -3.96107],
            [5.40225, -3.96191],
            [5.40182, -3.96237],
            [5.40173, -3.96245],
            [5.40148, -3.96265],
            [5.40203, -3.96282],
            [5.40131, -3.9607],
            [5.40129, -3.96018],
            [5.40048, -3.95956],
            [5.40037, -3.95931],
            [5.39975, -3.95701],
            [5.39963, -3.95651],
            [5.40098, -3.95743],
            [5.39967, -3.96498],
        ];

        // check if address is set
        var result = {};

        for (var coords of coordinates) {
            var lat = coords[0].toString();
            var lon = coords[1].toString();

            console.log("<< coords", lat, lon);

            var query = await db.query(aql`
                
                FOR place IN nominatim_places 
                FILTER 
                    place.lat == ${lat} AND
                    place.lon == ${lon} 
                LIMIT 1
                RETURN {"empty": LENGTH(place) == 0}
            `);

            console.log("<< query", query.all());

            var res = {};
            for await (var item of query) {
                console.log("<< items", item);
                res = item;
            }
            //
            console.log("<< res", res);

            // if(res.empty == true){

            // do reverse search and populate
            const { data, status } = fastify.axios.get(`https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lon}&format=jsonv2`);
            console.log("<<data");
            console.log(data);

            if (!data.error) {
                // insert
                var query = await db.query(aql`
                        // Check if data doesn't already exist
                        LET existing_data = (
                            FOR p IN nominatim_places
                            FILTER p.lat == ${data.lat}
                            AND p.lon == ${data.lon}
                            AND p.osm_id == ${data.osm_id}
                            LIMIT 1
                            RETURN p
                        )

                        FILTER LENGTH(existing_data) == 0
                        // Then insert
                        INSERT ${data}
                        INTO nominatim_places

                        RETURN {'success': LENGTH(existing_data) == 0 }
                    `);

                var res = {};
                for await (var item of query) {
                    console.log("<< items", item);
                    res = item;
                }

                result = res;

                // return res;

                // result.push(data);
            }
            // save errything in the database
            // }
        }

        if (!result.success) {
            result = { success: false };
        }

        return result;
    });
    fastify.get("/", async function (request, reply) {
        const lat = request.query.lat;
        const lon = request.query.lon;
        const country_code = request.query.country_code ?? "ci";
        const type = request.query.type ?? "nominatim";
        // const state = request.query.state;
        // const city = request.query.city;
        const radius = request.query.radius;
        var input = {
            lat,
            lon,
            radius,
            country_code,
            // city,
        };

        // get places in the country or state or city

        var result = [];
        // for ici
        if (type === "ici_place") {
            var query = await db.query(aql`
            FOR place IN ici_places 
            FILTER place.country_code == ${input.country_code}
            RETURN place
        `);

            // calculate distance or not
            // geodesy calculations
            for await (var item of query) {
                console.log("<< items", item);

                // if(item.address.country_code == input.country_code){
                result.push(item);
                // }
            }
            //

            return result;
        }
        var query = await db.query(aql`
        
            FOR place IN nominatim_places 
            FILTER place.address.country_code == ${input.country_code}
            RETURN place
        `);

        // calculate distance or not
        // geodesy calculations
        for await (var item of query) {
            console.log("<< items", item);

            // if(item.address.country_code == input.country_code){
            result.push(item);
            // }
        }
        //

        return result;
    });

    // Fetches all the places from the specified user
    fastify.post("/fetch", async function (request, reply) {
        var { user_id } = request.body;

        var places = [];
        try {
            var cat_query = await db.query(aql`
            FOR p IN ici_places
                FOR c IN place_categories
                    FOR u IN users
                        FILTER p.place_category == c._id AND p.user == u._id
                        RETURN merge(p, {place_category: c}, {user: {name: u.name,}})
        `);
            if (user_id) {
                cat_query = await db.query(aql`
                    FOR p IN ici_places
                        FOR c IN place_categories
                            FOR u IN users
                                FILTER p.place_category == c._id AND p.user == u._id AND u._id != ${user_id}
                                RETURN merge(p, {place_category: c}, {user: {name: u.name,}})
                `);
            }

            for await (var item of cat_query) {
                places.push(item);
            }
        } catch (e) {
            console.log("xx error getting all places", e);
            // TODO save log
        }
        return this.response(places);
    });
    // Fetches all the user places from the specified user
    fastify.post("/fetch/user", async function (request, reply) {
        var { user_id } = request.body;

        console.log(request.body);

        if (!user_id) {
            return this.error("MISSING_USER_ID", "Données manquantes");
        }
        // find user
        var user;
        try {
            const query = await db.query(aql`
                FOR user IN users
                FILTER user._id == ${user_id}
                RETURN user
            `);

            for await (var item of query) {
                user = item;
            }
        } catch (e) {
            console.log("xx error getting user", e);
            // TODO save log
        }
        if (!user) {
            return {
                data: {
                    error: "USER_NOT_FOUND",
                    message: "Utilisateur introuvable",
                },
                success: false,
            };
        }
        console.log("<<< user");

        var places = [];
        try {
            const cat_query = await db.query(aql`
                FOR p IN ici_places
                    FOR c IN place_categories
                        FOR u IN users
                            FILTER p.place_category == c._id AND p.user == u._id  AND u._id == ${user_id}
                            RETURN merge(p, {place_category: c}, {user: {name: u.name,}})
            `);

            for await (var item of cat_query) {
                places.push(item);
            }
        } catch (e) {
            console.log("xx error fetching user places", e);
            // TODO save log
        }
        console.log("<<< places");

        return this.response(places);
    });
    // Deletes one place
    fastify.post("/delete", async function (request, reply) {
        var { user_id, place_id } = request.body;

        console.log(request.body);

        // find user
        var user;
        try {
            var query = await db.query(aql`
                FOR user IN users
                FILTER user._id == ${user_id}
                RETURN user
            `);

            for await (var item of query) {
                user = item;
            }
        } catch (e) {
            console.log("xx arango error", e);
            // TODO save log
        }
        if (!user) {
            return this.error("USER_NOT_FOUND", "Utilisateur introuvable");
        }
        console.log("<<< user");

        var deletedPlace = {};
        try {
            query = await db.query(aql`
                FOR p IN ici_places
                    FILTER p._id == ${place_id} AND p.user == ${user_id}
                    REMOVE p IN ici_places
                    RETURN OLD
            `);

            for await (var item of query) {
                deletedPlace = item;
            }
        } catch (e) {
            console.log("xx arango error", e);
            // TODO save log
            return this.error("DB_DELETE_ERROR", "Nous n'avons pas pu supprimer le lieu\n Veuillez réessayer plus tard");
        }
        // delete images
        console.log("<<< places");
        var images = deletedPlace.images;
        try {
            console.log("== images", images);
            if (images) {
                for (var img of images) {
                    // var base = path.join("public", img);
                    var imgFile = path.join("public", img);
                    console.log(">>> imgFile", imgFile);

                    filePath = fs.unlink(imgFile, (err) => {
                        if (err) {
                            console.error("xxxx could not delete image", err);
                            return;
                        }

                        console.error("<<< deleted image");
                    });
                }
            }
        } catch (imgDelError) {
            // TODO log error to server
            console.log("xx<<< delete exc", imgDelError);
        }
        return this.response(true);
    });
    // Add 1 new place to db
    fastify.post("/", async function (request, reply) {
        var { user_id, points, input } = request.body;
        // var { name, category, phone, schedule } = JSON.parse(input);
        console.log(">>> newPlace", user_id, points, input);
        input = JSON.parse(input);
        user_id = JSON.parse(user_id);
        points = JSON.parse(points);
        const files = request.raw.files;

        // find user
        var user;
        try {
            var query = await db.query(aql`
                FOR user IN users
                FILTER user._id == ${user_id}
                RETURN user
            `);

            for await (var item of query) {
                user = item;
            }
        } catch (e) {
            console.log("xx arango error", e);
            // TODO save log
        }
        if (!user) {
            return this.error("USER_NOT_FOUND", "Utilisateur introuvable, assurez-vous d'être connecté");
        }
        console.log("<<< user");

        // / Category management
        var place_category;
        var category_slug = slugify(input.category, { replacement: "_", strict: true, lower: true });
        try {
            query = await db.query(aql`
                FOR p IN place_categories
                FILTER p.slug == ${category_slug}
                RETURN p
            `);

            for await (var item of query) {
                place_category = item;
            }
            // Create category if doesn't exist
            if (!place_category) {
                // create category
                var newCategory = {
                    name: input.category,
                    slug: category_slug,
                    is_validated: false,
                    fields: [],
                };
                // insert newCategory
                query = await db.query(aql`
                INSERT ${newCategory} INTO place_categories
                RETURN NEW
            `);

                for await (var item of query) {
                    place_category = item;
                }

                // return {
                //     data: {
                //         error: "PLACE_CATEGORY_NOT_FOUND",
                //         message: "Utilisateur introuvable",
                //     },
                //     success: false,
                // };
            }
        } catch (e) {
            console.log("xx arango error", e);
            // TODO save log
        }

        console.log("<<< category");
        // return fastify.turf;
        console.log(">>", points);
        var ppoints = [];
        ppoints = [...points, points[0]];
        // Save single points as polygons
        if (points.length == 1) {
            ppoints = [];
            for (var i in 4) {
                ppoints.push(points[0]);
            }
        }
        console.log("<<", ppoints);
        // return ppoints;
        var polygon = turf.polygon([ppoints]);

        // find centroid
        var centroid = turf.centroid(polygon);

        // find bbox
        var bbox = turf.bbox(polygon);

        var datetime = new Date().toISOString();

        var newPlace = {
            geojson: polygon,
            bbox,
            centroid,
            is_verified: false,
            user: user_id,
            display_name: input.name,
            phone: input.phone,
            place_category: place_category._id,
            created_at: datetime,
            updated_at: datetime,
        };

        // / Images management

        let imageLinks = [];
        try {
            if (files) {
                console.log("\n\n>> files", files);
                console.log("\n>> files Images", files.images);
                // non iterable
                if (!this.isIterable(files.images)) {
                    var now = Date.now();
                    var key = files.images;
                    var fileName = now + "__" + key.name;
                    var filePath = path.join("public", "images", fileName);
                    imageLinks.push("/images/" + fileName);
                    // Save images to disk
                    fs.writeFile(filePath, Buffer.from(key.data), (err) => {
                        if (err) {
                            console.log("xxx err creating", key.name);
                            return;
                        }
                        console.log(">>> image created");
                    });
                } else {
                    // iterable images
                    for (let key of files.images) {
                        var now = Date.now();
                        var fileName = now + "__" + key.name;
                        var filePath = path.join("public", "images", fileName);
                        imageLinks.push("/images/" + fileName);
                        // Save images to disk
                        fs.writeFile(filePath, Buffer.from(key.data), (err) => {
                            if (err) {
                                console.log("xxx err creating", key.name);
                                return;
                            }
                            console.log(">>> image created");
                        });
                    }
                }
            }
        } catch (imgErr) {
            console.log("xx imgErr", imgErr);
            // TODO save log
        }

        // Save links to data
        newPlace["images"] = imageLinks;

        // / Fetch nominatim place data for streetname

        // save newPlace;
        const insert = await db.query(aql`
            INSERT ${newPlace} INTO ici_places
            RETURN NEW
        `);

        return this.response(newPlace);
    });
};
