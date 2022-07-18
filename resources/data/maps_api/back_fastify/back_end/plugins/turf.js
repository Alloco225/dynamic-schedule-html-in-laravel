'use strict'

const fp = require('fastify-plugin')
const turf = require("@turf/turf");

// the use of fastify-plugin is required to be able
// to export the decorators to the outer scope

module.exports = fp(async function (fastify, opts) {
  fastify.decorate('turf', function () {

    return turf();
  })
})
