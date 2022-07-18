"use strict";

const fp = require("fastify-plugin");

// the use of fastify-plugin is required to be able
// to export the decorators to the outer scope

module.exports = fp(async function (fastify, opts) {
    fastify.decorate("response", function (data, message = "Succes") {
        return { success: true, data, message };
    });
    fastify.decorate("error", function (error, message = "Une erreur s'est produite") {
        return { sucess: false, error, message };
    });

    fastify.decorate("isIterable", function (input) {
        if (input === null || input === undefined) {
            return false;
        }
        return typeof input[Symbol.iterator] === "function";
    });
});
