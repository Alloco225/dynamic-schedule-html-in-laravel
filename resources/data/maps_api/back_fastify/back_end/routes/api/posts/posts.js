"use strict";

const posts = [
    {
        id: 1,
        user: "John Doe",
        title: "Hello Word",
    },
];

// request validation
const postOptions = {
    schema: {
        body: {
            type: "object",
            required: ["user", "title"],
            properties: {
                user: { type: "string" },
                title: { type: "string" },
            },
        },
        response: {
            201: {
                type: "object",
                properties: {
                    title: { type: "string" },
                    user: { type: "string" },
                },
            },
        },
    },
};

/**
 * 
 * @param {import('fastify').FastifyInstance} fastify 
//  * @param {*} opts 
 */
module.exports = async function (fastify, opts) {
    // const { Database, aql } = require("arangojs");

    console.log("\n ** posts **");

    // Read
    fastify.get("/", async function (request, reply) {
        reply.status(200).send(posts);
        // return posts;
    });
    // Read
    fastify.get("/:id", async function (request, reply) {
        try {
            const post = posts.find((p) => p.id === +request.params.id);
            //
            if (!post) {
                // reply.callNotFound
                // return fastify.httpErrors.notFound('Post not found')
                return this.error(404, "Post does not exist");
            }
            //
            // reply.status(200).send(post)
            post.support = fastify.someSupport();

            return post;
        } catch (err) {
            throw new Error("Something went wrong");
        }
    });

    // Create
    fastify.post("/", postOptions, async function (request, reply) {
        const { title, user } = request.body;

        const newPost = { id: posts.length + 1, title, user };

        posts.push(newPost);

        reply.code(201);

        return newPost;
    });
    //
};
