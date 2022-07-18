"use strict";

const jwt = require('jsonwebtoken');

// req validation
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
const { Database, aql } = require("arangojs");

/**
 * 
 * @param {import('fastify').FastifyInstance} fastify 
//  * @param {*} opts 
 */
module.exports = async function (fastify, opts) {
    // const { Database, aql } = arangojs

    
    const db = new Database({
        url: process.env.ARANGO_HOST,
        databaseName: process.env.ARANGO_DB,
        auth: { username: process.env.ARANGO_AUTH, password: process.env.ARANGO_PASSWORD },
    });

    console.log("\n** users **");
    
    // const Users = db.collection("users");

    // Read
    fastify.get("/", async function (req, res) {
        // res.status(200).send(collection)
        // return Users.all();
        const cookie = req.cookies.jwt;
        if (!cookie) {
            return this.error(401, "Authentification requise");
        }

        const verified = jwt.verify(cookie, "secret");
        if(!verified){
            return this.error(401, "Authentification requise")
        }

        var result = [];

        const users = await db.query(aql`
            FOR user IN users
            FILTER user._id == ${verified._id}
            LIMIT 1
            RETURN user
        `);

        for await (const user of users) {
            result.push(user);
        }
        const [{password, ...data}, ...others] = result;
        return data;
    });
    // Read
    fastify.get("/:id", async function (req, res) {
        try {
            const post = posts.find((p) => p.id === +req.params.id);
            //
            if (!post) {
                // res.callNotFound
                // return fastify.httpErrors.notFound('Post not found')
                return this.error(404, "Post does not exist");
            }
            //
            // res.status(200).send(post)
            post.support = fastify.someSupport();

            return post;
        } catch (err) {
            throw new Error("Something went wrong");
        }
    });

    // Create
    // fastify.post("/", async function (req, res) {
    //     const { title, user } = req.body;

    //     const newPost = { id: posts.length + 1, title, user };

    //     posts.push(newPost);

    //     res.code(201);

    //     return newPost;
    // });
    //
};
