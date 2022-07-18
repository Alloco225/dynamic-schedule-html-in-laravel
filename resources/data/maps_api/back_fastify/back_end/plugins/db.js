"use strict";

const fp = require("fastify-plugin");

// the use of fastify-plugin is required to be able
// to export the decorators to the outer scope

module.exports = fp(async function (fastify, opts) {
    fastify.decorate("db", function () {
        const { Database, aql } = require("arangojs");

        const db = new Database({
            url: process.env.ARANGO_HOST,
            databaseName: process.env.ARANGO_DB,
            auth: { username: process.env.ARANGO_AUTH, password: process.env.ARANGO_PASSWORD },
        });
        return db;
    });
});
