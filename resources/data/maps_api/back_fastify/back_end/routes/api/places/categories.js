"use strict";

// var arangojs = require("arangojs");
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

    console.log("\n ** place categories **");
    // const Addresses = db.collection("addresses");
    // const Users = db.collection("users");

    fastify.register(require("fastify-axios"));

    // Read
    fastify.get("/categories", async function (request, reply) {
        // check if address is set
        var result = [];
        // get place categories
        try {
            const query = await db.query(aql`        
                FOR cat IN place_categories 
                SORT cat.name
                RETURN cat
            `);

            for await (var item of query) {
                // console.log(">>", item);
                result.push(item);
            }
        } catch (e) {
            console.log("xx exception");
            console.log(e);
        }

        return { success: true, data: result };
    });
};
