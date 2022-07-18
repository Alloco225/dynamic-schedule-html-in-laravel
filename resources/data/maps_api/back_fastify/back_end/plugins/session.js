"use strict";

const cookie = require('fastify-cookie')
// const session = require('fastify-session')
const fp = require("fastify-plugin");

/**
 * @param {import('fastify').FastifyInstance} fastify
 */
const plugin = async (fastify) => {

    // fastify.register(cookie)
    // fastify.register(session, {
    //     secret: SESSION_SECRET,
    // })
};
module.exports = fp(plugin);
