"use strict";

// request validation
// const postOptions = {
//     schema: {
//         body: {
//             type: 'object',
//             required: ['user', 'title'],
//             properties: {
//                 user: {type: 'string'},
//                 title: {type: 'string'},
//             }
//         },
//         response: {
//             201: {
//                 type: 'object',
//                 properties: {
//                     title: {type: 'string'},
//                     user: {type: 'string'},
//                 }
//             }
//         }
//     }
// }
const { Database, aql } = require("arangojs");

/**
 * 
 * @param {import('fastify').FastifyInstance} fastify 
//  * @param {*} opts 
 */
module.exports = async function (fastify, opts) {
    // const this.error = fastify.httpErrors.this.error;

    const db = new Database({
        url: process.env.ARANGO_HOST,
        databaseName: process.env.ARANGO_DB,
        auth: { username: process.env.ARANGO_AUTH, password: process.env.ARANGO_PASSWORD },
    });

    console.log("\n** locations **");

    // Read
    fastify.get("/", async function (request, reply) {
        // reply.status(200).send(collection)
        // return Locations.all();
        var result = [];

        const locations = await db.query(aql`
            FOR location IN locations
            RETURN location
        `);

        for await (const location of locations) {
            result.push(location);
        }
        return result;
    });
    // Read
    fastify.get("/find/:code", async function (request, reply) {
        try {
            console.log(">> code : ");
            console.log(request.params);

            const res = await db.query(aql`
            FOR location IN locations
            FILTER location.code == ${request.params.code}
            RETURN location
            `);
            //
            if (!res) {
                return this.error(404, "Location does not exist");
            }

            console.log("<< fetched");
            var result = [];

            for await (const item of res) {
                // result.push(item);
                result = item;
            }
            console.log(result);
            //
            if (result.length < 1) {
                return this.error(404, "Location does not exist");
            }
            return result;
        } catch (err) {
            console.log(err);
            throw new Error("Something went wrong");
        }
    });

    // Create
    fastify.post("/", async function (request, reply) {
        const { title, user } = request.body;

        //
        posts.push(newPost);

        reply.code(201);

        return newPost;
    });
    //

    /**
     * store user positions in time
     * 
     *  */
    fastify.post("/store", async function (request, reply) {
        const { user_id, positions } = request.body;
        // position = {time, coordinates}
        //
        var user;
        try {
            const cursor = await db.query(aql`
                FOR user IN users
                FILTER user._id == ${user_id}
                RETURN user
            `);
            // console.log(cursor);

            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error", e);
        }

        if (!user) {
            console.log("xx code not found");
            return this.error(400, "USER_NOT_FOUND");
        }
        if (!user.positions) {
            user.positions = [];
        }

        var positionsData = { positions: [...user.positions, ...positions] };
        console.log(positionsData, user._id);

        try {
            const cursor = await db.query(aql`
                UPDATE ${user._key} WITH ${positionsData} IN users
            `);
            // console.log(cursor);
        } catch (e) {
            console.log(">> error", e);
            return false;
        }

        reply.code(201);

        return true;
    });

    
};
