"use strict";

const fp = require("fastify-plugin");

// the use of fastify-plugin is required to be able
// to export the decorators to the outer scope

module.exports = fp(async function (fastify, opts) {

    fastify.decorate("sendMail", async function(message){
        const nodemailer = require("nodemailer");

        const mailerAccount = {
            host: process.env.MAIL_HOST,
            port: process.env.MAIL_PORT,
            secure: false,// process.env.MAIL_TLS, // TLS
            auth: {
                user: process.env.MAIL_USER,
                pass: process.env.MAIL_PASS,
            },
            tls: {
                ciphers: "SSLv3",
                rejectUnauthorized: false,
            },
            from: process.env.MAIL_FROM,
        };

        // transporter
        let transporter = nodemailer.createTransport(
            {
                host: mailerAccount.host,
                port: mailerAccount.port,
                secure: mailerAccount.secure,
                auth: mailerAccount.auth,
                tls: mailerAccount.tls,
                logger: true,
                transactionLog: true, // include SMTP traffic in the logs
            },
            {
                // sender info
                from: mailerAccount.from,
                headers: {
                    "X-Laziness-level": 1000, // just an example header, no need to use this
                },
            }
        );

        return await transporter.sendMail(message);

    })
});
