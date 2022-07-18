'use strict'

module.exports = async function (fastify, opts) {
  console.log("\n ** routes root **");
  fastify.get('/', async function (request, reply) {
    return { root: true }
  })

  fastify.get("/resetPassword", function (req, reply) {
      return reply.sendFile("change_password.html"); // serving path.join(__dirname, 'public', 'myHtml.html') directly
  });
}
