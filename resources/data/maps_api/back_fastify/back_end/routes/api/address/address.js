"use strict";


// const cols = "ZYXWVUTR"
// const cols = "ABCDEFGH"
// const rows = "23456789"
// const alphabet = cols+rows
const alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
// database init

// address data validation
const addressOptions = {
    schema: {
        body: {
            type: 'object',
            required: [
                'label', 
                'plus_code', 
                'location', 
                'user',
                'is_ephemere',
                'is_private',
                'position',
            ],  
            properties: {
                label: {type: 'string'},
                plus_code: {type: 'string'},
                location: {type: 'object'},
            
                user: {type: 'object'},
                is_ephemere: {type: 'boolean'},
                position: {type: 'object'},
            }
        },
    }
}

/*
function addressGenerator(data){
    // separate into cols and row 
    const alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const integers="0123456789";
    // 
    var user_phone = data.user.phone;
    // find user
    var {location, plus_code } = data;
    // get country
    var {country_code} = location.address;
    // 
    var prefix = country_code.toUpperCase();
    // code final 6 random number
    var code_final = Math.floor(Math.random() * 10000);

    // get random int from
        // var col, row = ''
        // col = cols[randomInt(1, cols.length-1)];
        // col += cols[randomInt(1, cols.length-1)];
        // row = rows[randomInt(1, rows.length-1)];
        // row += rows[randomInt(1, rows.length-1)];

        // var alphabet_part = col+row;
        var alphabet_part = '';
        alphabet_part += alphabet[randomInt(1, alphabet.length-1)];
        alphabet_part += alphabet[randomInt(1, alphabet.length-1)];

        var address_code = prefix + alphabet_part+ code_final;
        if(!data.is_ephemere){
            address_code = prefix + alphabet_part+ code_final;
        }

        // Check if address_code doesn't exist

        const records = await db.query(aql`
            FOR address IN addresses
            FILTER address.address_code == ${address_code}
        `);
        var existing_records = [];
        
        if(!rec){
            // ok,
            data.address_code = address_code;
        }

        const res = await db.query(aql`
            INSERT ${data} INTO addresses
        `);
        
        if (!res) {
            return this.error(404, "Adresse does not exist");
        }
        return data;
}

*/
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

    console.log("\n ** address **");

    // Read
    fastify.get("/", async function (request, reply) {
        // reply.status(200).send(collection)
        // return Addresses.all();
        var result = [];

        const addresses = await db.query(aql`
                FOR addresse IN addresses
                RETURN addresse
            `);

        for await (const addresse of addresses) {
            result.push(addresse);
        }
        return result;
    });
    // Read
    fastify.get("/find/:code", async function (request, reply) {
        try {
            console.log(">> code : ")
            console.log(request.params);

            const res = await db.query(aql`
                FOR addresse IN addresses
                FILTER addresse.code == ${request.params.code}
                RETURN addresse
            `)
            //
            if (!res) {
                return this.error("ADDRESS_NOT_FOUND", "Adresse does not exist");
            }

            console.log("<< fetched")
            var result = [];

            for await (const item of res) {
                // result.push(item);
                result = item;
            }
            console.log(result)
            // 
            if (result.length < 1) {
                return this.error("ADDRESS_NOT_FOUND", "Adresse does not exist");
            }
            return result;
            
        } catch (err) {
            console.log(err);
            throw new Error("Something went wrong");
        }
    });

    // Create
    // fastify.post("/", addressOptions, async function (request, reply) {

    //     var data = request.body;
    //     // const plus_code = data.plus_code
    //     console.log(data)
    //     var user_phone = data.user.phone;
    //     // find user
    //     var {location, plus_code, is_ephemere, is_private } = data;

    //     // get country
    //     var {country_code} = location.address;
    //     // 
    //     var prefix = country_code.toUpperCase();
    //     // var code_prefix = plus_code.substring(4,6)
    //     var code_final = plus_code.substring(plus_code.length-2, plus_code.length);

    //     // code final 6 random number
    //     var code_final = Math.floor(Math.random() * 10000);

    //     // get random int from
    //     // var col, row = ''
    //     // col = cols[randomInt(1, cols.length-1)];
    //     // col += cols[randomInt(1, cols.length-1)];
    //     // row = rows[randomInt(1, rows.length-1)];
    //     // row += rows[randomInt(1, rows.length-1)];

    //     // var alphabet_part = col+row;
    //     var alphabet_part = '';
    //     alphabet_part += alphabet[randomInt(1, alphabet.length-1)];
    //     alphabet_part += alphabet[randomInt(1, alphabet.length-1)];

    //     var address_code = prefix + alphabet_part+ code_final;
    //     if(!is_ephemere){
    //         address_code = prefix + alphabet_part+ code_final;
    //     }

    //     // get user
    //     var user = null;
    //     var records = await db.query(aql`
    //         FOR user IN users
    //         FILTER user.phone == ${user_phone}
    //         LIMIT 1
    //         RETURN user
    //     `);
    //     for await (const rec of records) {
    //         user = rec;
    //     }
    //     console.log(":: user", user);

    //     if(!user){
    //         return this.error(403, "Unauthenticated");
    //     }
    //     // get plus_code
    //     var db_address = null;
    //     var records = await db.query(aql`
    //         FOR address IN addresses
    //         FILTER address.plus_code == ${plus_code}
    //         LIMIT 1
    //         RETURN address
    //     `);
    //     for await (const rec of records) {
    //         db_address = rec;
    //     }

    //     console.log("::plus_code", db_address);
    //     // If plus_code already exists
    //     if(db_address){
    //         // Check if same user
    //         if(db_address.user.phone == user_phone){
    //             console.log("::same user")
    //             // check if address is private and not ephemere
    //             if(is_private){
    //                 console.log("::private");
    //                 if(is_ephemere){
    //                     console.log("::ephemere")
    //                     // create another
    //                 }else{
    //                     console.log("!ephemere")
    //                     return db_address;
    //                 }
    //             }else{
    //                 console.log("!private")
    //             }
    //         }
    //     }

    //     if (!user) {
    //         return this.error(403, "Unauthenticated");
    //     }
    //     // check if plus_code doesn't exist

    //     // check if user is owner of plus_code

    //     // Check if address_code doesn't exist

    //     var records = await db.query(aql`
    //         FOR address IN addresses
    //         FILTER address.address_code == ${address_code}
    //         RETURN address
    //     `);
    //     var existing_records = [];
    //     for await(const rec of records){
    //         existing_records.push(rec);
    //     }

    //     if (!existing_records.length) {
    //         // ok,
    //         data.address_code = address_code;
    //     }

    //     // const res = await db.query(aql`
    //     //     INSERT ${data} INTO addresses
    //     // `);
        
    //     // if (!res) {
    //     //     return this.error(404, "Adresse does not exist");
    //     // }
    //     console.log(">> data", data);
    //     return data;
    // });
    fastify.post("/", async function (request, reply) {

        var data = request.body;
        // const plus_code = data.plus_code
        console.log(data)
        data = JSON.parse(data);
        var user_phone = data.user.phone;
        // find user
        var {location, plus_code, is_ephemere, is_private } = data;

        // get country
        var {country_code} = location.address;
        // 
        var prefix = country_code.toUpperCase();
        
        var code_final = plus_code.substring(plus_code.length-2, plus_code.length);

        // code final 6 random number
        var code_final = Math.floor(Math.random() * 10000);
        // var alphabet_part = col+row;
        var alphabet_part = '';
        alphabet_part += alphabet[randomInt(1, alphabet.length-1)];
        alphabet_part += alphabet[randomInt(1, alphabet.length-1)];

        var address_code = prefix + alphabet_part+ code_final;
        if(!is_ephemere){
            address_code = prefix + alphabet_part+ code_final;
        }

        // 
        var query = await db.query(aql`
            LET user = (
                FOR u IN users 
                FILTER u.phone == ${user_phone} 
                LIMIT 1
                RETURN u)

            FILTER LENGTH(user) > 0

            LET address = (
                FOR a IN addresses 
                FILTER a.plus_code == ${plus_code}
                AND a.user.phone == user[0].phone
                AND a.is_ephemere == ${is_ephemere}
                AND a.is_private == ${is_private}
                LIMIT 1 
                RETURN a)
            return {"address": address[0], "success": LENGTH(address) == 0}
        `);

        var result = {};
        for await (const item of query) {
            result = item;
        }

        console.log("<< query result ", result);

        if(!result.success){
            // If address already exists
            console.log("<< address exists already");
            
            // addresse, success
            return result;
        } else{
            // Save new address
            
            data.address_code = address_code;
            
            const res = await db.query(aql`
                INSERT ${data} INTO addresses
            `);
            // Update user adresses
            // Add new address to user's addresses
            query = await db.query(aql`
                FOR u IN users
                    FILTER u.phone == ${user_phone}
                    
                    UPDATE u WITH {
                        addresses: PUSH(u.addresses, ${data})
                    } IN users
            `);
            
            result = {address: data, success: true};
        }

        console.log(">> data", result);
        return result;
    });
    // Search
    fastify.get("/search/terms", async function (request, reply) {
        console.log(request.params)
        var data = request.params;
        // Determine if terms type
        // Plus Code

        // Coordinates
        // IciAddress
        // Location
        // Place

        return data;
    });
    // 
    fastify.post("/search/:address_code", async function (request, reply) {
        console.log(request.params)
        var {address_code} = request.params;
        console.log(address_code)

        // Search for data
        // 
        const query = await db.query(aql`
            FOR address IN addresses
            FILTER address.address_code == ${address_code}
            LIMIT 1
            RETURN address
        `);

        var address = {};
        for await (const item of query) {
            address = item;
        }
        
        // if (!address) {
        //     return this.error(404, "Adresse does not exist");
        // }
        return address;
    });
    //

    function randomInt(min, max) {
        return Math.floor(Math.random() * (max - min)) + min;
    }
};
