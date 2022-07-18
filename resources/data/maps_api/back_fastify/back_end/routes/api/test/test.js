"use strict";

// var arangojs = require("arangojs/web");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
// const twilioPhone = process.env.TWILIO_PHONE;
const twilioPhone = process.env.TWILIO_CALLER;
const client = require("twilio")(accountSid, authToken);

const nodemailer = require("nodemailer");

// const mailerAccount = {
//     host: "mail.weflyagri.com",
//     port: 587,
//     secure: false, // TLS
//     auth: {
//         user: "weflygeo@weflyagri.com",
//         pass: "HBVLvrYA",
//     },
//     tls: {
//         ciphers: "SSLv3",
//         rejectUnauthorized: false,
//     },
//     from: "JooL <weflygeo@weflyagri.com>",
// };

// // transporter
// let transporter = nodemailer.createTransport(
//     {
//         host: mailerAccount.host,
//         port: mailerAccount.port,
//         secure: mailerAccount.secure,
//         auth: mailerAccount.auth,
//         tls: mailerAccount.tls,
//         logger: true,
//         transactionLog: true, // include SMTP traffic in the logs
//     },
//     {
//         // sender info
//         from: mailerAccount.from,
//         headers: {
//             "X-Laziness-level": 1000, // just an example header, no need to use this
//         },
//     }
// );

/**
 * Api Root Routes
 *
 * Main api route
 * Register
 * Login
 * Logout
 *
 * Search
 */

/**
 * Requests validation
 */
const registerValidation = {
    schema: {
        body: {
            type: "object",
            required: ["name", "phone", "password"],
            properties: {
                name: { type: "string" },
                phone: { type: "string" },
                password: { type: "string", minLength: 6 },
            },
        },
        response: {
            201: {
                type: "object",
                properties: {
                    name: { type: "string" },
                    phone: { type: "string" },
                },
            },
        },
    },
};
const loginValidation = {
    schema: {
        body: {
            type: "object",
            required: ["phone", "password"],
            properties: {
                phone: { type: "string" },
                password: { type: "string", minLength: 6 },
            },
        },
        response: {
            201: {
                type: "object",
                properties: {
                    name: { type: "string" },
                    phone: { type: "string" },
                },
            },
        },
    },
};

function generateToken(length) {
    var result = "";
    var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

const { Database, aql } = require("arangojs");

/**
 * @param {import('fastify').FastifyInstance} fastify 
//  * @param {*} opts 
 */
module.exports = async function (fastify, opts) {

    const db = new Database({
        url: process.env.ARANGO_HOST,
        databaseName: process.env.ARANGO_DB,
        auth: { username: process.env.ARANGO_AUTH, password: process.env.ARANGO_PASSWORD },
    });

    console.log("\n ** api root **");

    /**
     * Main api route
     * Only for authenticated user
     */

    fastify.get("/", async function (req, res) {
        // res.status(200).send(collection)
        console.log("<<test>>");
        res.send("**Test**");
    });

    // test email
    // fastify.get("/email/:name/:email", async function (req, res) {
    //     console.log(">> email test");
    //     const email = req.params.email;
    //     const name = req.params.name;

    //     const code = generateToken(4).toUpperCase();

    //     const mailTo = `${name} <${email}>`;

    //     let message = {
    //         from: "ICI <hello@ici.com>",

    //         // Comma separated list of recipients
    //         to: mailTo,
    //         // bcc: "esdras.koya@jool-international.com",
    //         // Subject of the message
    //         subject: `ICI : Code de validation`,
    //         // HTML body
    //         html: "<p>Votre code de validation ICI est <b>" + code + "</b></p>",
    //     };

    //     let data = await transporter.sendMail(message);

    //     res.send(data);
    // });

    fastify.get("/mail/:name/:email", async function (req, res) {
        console.log(">> email test");
        const email = req.params.email;
        const name = req.params.name;

        const code = generateToken(4).toUpperCase();

        const mailTo = `${name} <${email}>`;

        let message = {
            from: "ICI <hello@ici.com>",
            // Comma separated list of recipients
            to: mailTo,
            // bcc: "esdras.koya@jool-international.com",
            // Subject of the message
            subject: `ICI : Code de validation`,
            // HTML body
            html: "<p>Votre code de validation ICI est <b>" + code + "</b></p>",
        };

        let data = await fastify.sendMail(message);

        res.send(data);
    });
};
