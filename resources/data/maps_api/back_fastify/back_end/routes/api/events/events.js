"use strict";

// var arangojs = require("arangojs/web");
const { Database, aql } = require("arangojs");

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

    console.log("\n** events **")
    // const Addresses = db.collection("addresses");
    // const Users = db.collection("users");

    fastify.register(require("fastify-axios"));

    // read
    fastify.get("/", async function (request, reply) {
        var country_code = "ci";

        if (request.query.country_code) {
            country_code = request.query.country_code;
        }

        // get events in the country or state or city
        var query = await db.query(aql`
            FOR event IN events 
            FILTER event.country_code == ${country_code}
            RETURN event
        `);

        var result = [];
        for await (var item of query) {
            console.log("<< items", item);
            result.push(item);
        }

        return result;
    });

    // Post
    fastify.post("/", async function (request, reply) {
        const data = request.body;

        // check if no duplicates
        var query = await db.query(aql`
            
            // Then insert
            LET existing_data = (
                FOR event in events
                FILTER event.user._id == ${data.user_id}
                AND event.name == ${data.name}
                RETURN event
            )

            RETURN {'success': LENGTH(existing_data) == 0 }
        `);

        var res = {};
        for await (var item of query) {
            console.log("<< items", item);
            res = item;
        }

        if (!res.success) {
            return {
                error: "Ce event existe déjà",
            };
        }

        // get user
        var query = await db.query(aql`
            // Then insert
            FOR user in users
            FILTER user._id == ${data.user_id}
            LIMIT 1
            RETURN user
        `);
        var user_data = {};
        for await (var item of query) {
            console.log("<< user", item);
            user_data = item;
        }

        
        data.status = "waiting_confirmation";
        data.is_waiting = true;
        
        // timestamps
        data.created_at = Date.toString();
        data.updated_at = Date.toString();

        // insert into user events
        var query = await db.query(aql`
            FOR u IN users
            FILTER u._id == ${data.user_id}
            UPDATE u._id WITH { events: ${data} } IN users
        `);
        // now add user data to event data
        data.user = user_data;
        // then insert into global events
        var query = await db.query(aql`
            INSERT ${data}
            INTO events
        `);

        // send async mail notification to admin

        // 
        return { success: "Event enregistré" };
    });

    // Cancel
    fastify.post("/:id/cancel", async function (request, reply) {
        const data = request.params;

        // authenticate

        // find event
        const res = await db.query(aql`
            FOR event IN events
            FILTER event.id == ${data.event_id}
            RETURN location
            `);
        //
        if (!res) {
            return this.error(404, "Location does not exist");
        }

        console.log("<< fetched");
        var result = [];

        return result;
    });
};
