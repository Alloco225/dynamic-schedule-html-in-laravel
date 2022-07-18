"use strict";

// address data validation
const addressOptions = {
    schema: {
        body: {
            type: "object",
            required: ["user", "contact"],
            properties: {
                user: { type: "object" },
                contact: { type: "object" },
            },
        },
    },
};
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
    
    console.log("\n** contacts **");

    // Create
    fastify.post("/", addressOptions, async function (request, reply) {
        var data = request.body;
        // const plus_code = data.plus_code
        console.log(">> new contact");
        console.log(data);
        var user_phone = data.user.phone;
        var contact = data.contact;

        //
        var query = await db.query(aql`
            LET user = (
                FOR u IN users 
                FILTER u.phone == ${user_phone} 
                LIMIT 1
                RETURN u)

            FILTER LENGTH(user) > 0

            FOR u IN users
                    FILTER u.phone == ${user_phone}
                    
                    UPDATE u WITH {
                        phonebook: PUSH(u.phonebook, ${contact})
                    } IN users

            RETURN {"success": LENGTH(user) != 0}
        `);
        var result = [];
        for await (const rec of query){
            result.push(rec);
        }
        console.log("<< result", result);
        
        if(!result.length){
            return this.error(403, "Unauthentified");
        }

        return {contact, success: true};
    });
    
};
