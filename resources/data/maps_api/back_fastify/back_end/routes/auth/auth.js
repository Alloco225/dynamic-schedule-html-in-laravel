"use strict";

module.exports = async function (fastify, opts) {
    console.log("\n ** auth **");
    //
    fastify.get("/register", async function (request, reply) {
        return { root: true };
    });
};
