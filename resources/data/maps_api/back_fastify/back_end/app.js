"use strict";

const path = require("path");
const AutoLoad = require("fastify-autoload");

const nodemailer = require("nodemailer");
const fileUpload = require("fastify-file-upload");

const fs = require("fs");

module.exports = async function (fastify, opts) {
    // Place here your custom code!

    // favicon
    fastify.register(require("fastify-favicon"));
    // fastify.register(require("fastify-favicon"), { path: "./", name: "favicon.ico" });
    // forms
    fastify.register(require("fastify-formbody"));

    fastify.register(require("fastify-secure-session"), {
        // the name of the session cookie, defaults to 'session'
        // cookieName: "my-session-cookie",
        // adapt this to point to the directory where secret-key is located
        key: fs.readFileSync(path.join(__dirname, "secret-key")),
        cookie: {
            path: "/",
            // options for setCookie, see https://github.com/fastify/fastify-cookie
        },
    });

    // template engine
    fastify.register(require("point-of-view"), {
        engine: {
            ejs: require("ejs"),
        },
    });

    fastify.register(fileUpload);
    // fastify.register(transporter);
    //
    fastify.register(require("fastify-cors"), {
        // put your options here
        credentials: true,
        origin: "*",
        // origin: [
        //   "http://localhost:3000",
        //   "http://localhost:8080",

        //   'http://localhost:4200',
        //   "http://192.168.1.48:3000",
        //   "http://192.168.1.48:3000/#/",
        // ],
    });
    //
    // fastify.register(require('fastify-cookie'), {
    //   secret: "cookie-secret",
    //   parseOptions: {}
    // });
    // sessionSecret:

    // Static file server
    fastify.register(require("fastify-static"), {
        root: path.join(__dirname, "public"),
        prefix: "/public/", // optional: default '/'
    });

    // Fastify arangodb
    // fastify.register(require("fastify-arangodb"), {
    //     // url: "http://root:root@localhost:8529",
    //     // url: process.env.ARANGO_HOST,
    //     auth: {
    //         username: process.env.ARANGO_AUTH,
    //         password: process.env.ARANGO_PASSWORD,
    //     },
    //     options: {
    //         url: process.env.ARANGO_HOST,
    //     },
    //     database: process.env.ARANGO_DB,
    // });

    // Do not touch the following lines
    // server {
    //      server_name api.ici.jool-international.com;
    //      client_max_body_size 5M;
    //      location / {
    //          proxy_pass http://172.25.0.2:8008;
    //          proxy_http_version 1.1;
    //          proxy_set_header Host $http_host;
    //          proxy_set_header X-NginX-Proxy true;
    //          proxy_set_header Upgrade $http_upgrade;
    //          proxy_set_header Connection "upgrade";
    //          proxy_max_temp_file_size 0;
    //      }
    // }
    // This loads all plugins defined in plugins
    // those should be support plugins that are reused
    // through your application
    fastify.register(AutoLoad, {
        dir: path.join(__dirname, "plugins"),
        options: Object.assign({}, opts),
    });

    // This loads all plugins defined in routes
    // define your routes in one of these
    fastify.register(AutoLoad, {
        dir: path.join(__dirname, "routes"),
        options: Object.assign({}, opts),
    });
};
