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
// var arangojs = require("arangojs/web");

var {OpenLocationCode} = require("open-location-code");

/**
 * 
 * @param {import('fastify').FastifyInstance} fastify 
//  * @param {*} opts 
 */
module.exports = async function (fastify, opts) {
    // const { Database, aql } = require("arangojs");

    console.log("\n ** search root **");

    fastify.register(require('fastify-axios'))

    // Read
    fastify.get("/:search_term", async function (request, reply) {

        const search_term = request.params.search_term;
        var result = {};
        // 
        
        // var return_data = {
        //     'address_code': '',
        //     'place_id': '',
        //     'name': '',
        //     'address': {
        //         'road': '',
        //         'neighbourhood': '',
        //         'suburb': '',
        //         'village': '',
        //         'city': '',
        //         'state': '',
        //         'postcode': '',
        //         'country': '',
        //         'country_code': '',
        //         'display_name': '',
        //     },
        //     'coordinates': [lat, lon],
        //     'bbox': [
        //         latLo,
        //         lonLo,
        //         latHi,
        //         lonHi,
        //     ]
        // }

        /**
         * First Check if research term is not a plus_code
        */

        
        if(OpenLocationCode.isValid(search_term)){

            // 
            console.log(">> validPlusCode");
        }
        
        // 
        console.log(">> not validPlusCode");
        

        // const { data, status } = await fastify.axios.get("https://nodejs.org/en/");
        // console.log("body size: %d", data.length);
        // console.log("status: %d", status);
            // 
        return search_term;
    });
    
};
