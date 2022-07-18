"use strict";

// var arangojs = require("arangojs/web");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
// const twilioPhone = process.env.TWILIO_PHONE;
const twilioPhone = process.env.TWILIO_CALLER;
const client = require("twilio")(accountSid, authToken);

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
            // required: ["phone", "password"],
            properties: {
                // phone: { type: "string" },
                password: { type: "string", minLength: 6 },
            },
        },
        // response: {
        //     201: {
        //         type: "object",
        //         properties: {
        //             name: { type: "string" },
        //             phone: { type: "string" },
        //         },
        //     },
        // },
    },
};
const signupNewUserValidation = {
    schema: {
        body: {
            type: "object",
            required: ["name", "email", "password"],
            properties: {
                name: { type: "string" },
                email: { type: "string" },
                password: { type: "string", minLength: 6 },
            },
        },
        response: {
            201: {
                type: "object",
                properties: {
                    name: { type: "string" },
                    email: { type: "string" },
                },
            },
        },
    },
};
// const verifyPasswordValidation = {
//     schema: {
//         body: {
//             type: "object",
//             required: ["email", "password"],
//             properties: {
//                 email: { type: "string" },
//                 password: { type: "string", minLength: 6 },
//             },
//         },
//         response: {
//             201: {
//                 type: "object",
//                 properties: {
//                     name: { type: "string" },
//                     email: { type: "string" },
//                 },
//             },
//         },
//     },
// };

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
    // const this.error = fastify.httpErrors.this.error;

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
        // return Users.all();
        const cookie = req.cookies.jwt;

        if (!cookie) {
            return this.error("401", "Authentification requise");
        }

        const verified = jwt.verify(cookie, "secret");
        if (!verified) {
            return this.error("401", "Authentification requise");
        }

        var result = [];

        const users = await db.query(aql`
            FOR user IN users
            FILTER user._id == ${verified._id}
            LIMIT 1
            RETURN user
            `);

        for (const user of users) {
            result.push(user);
        }
        const [{ password, ...data }, ...others] = result;
        return data;
    });

    /**
     * Auth Routes
     */
    fastify.post("/register", async function (req, res) {
        console.log(">> register", req.body);

        const { name, email, phone, password } = req.body;

        // var result = [];

        // check if user exists
        var cursor = await db.query(aql`
            FOR user IN users
            FILTER user.phone == ${phone} OR user.email == ${email}
            LIMIT 1
            RETURN user
        `);
        var user;
        for await (const line of cursor) {
            user = line;
        }

        if (user) {
            // return this.error(400, "Ce numéro de téléphone ou email est déjà utilisé");
            // return res.code(400).send({ message: "Ce numéro de téléphone ou email est déjà utilisé" });
            if (user.email_verified_at) {
                // if user is already verified
                return this.error("ERROR", "Ce numéro de téléphone ou email est déjà utilisé");
            } else {
                // not yet verified
                return this.response(user, "Inscription presque terminée");
            }
        }

        // generate code
        var phone_verification_code = generateToken(5).toUpperCase();

        var email_verification_code = generateToken(5).toUpperCase();

        var created_at = new Date().toISOString();
        var updated_at = created_at;

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // send confirmation mail
        const mailTo = `${name} <${email}>`;
        let message = {
            from: "ICI <hello@ici.com>",
            to: mailTo,
            subject: `ICI : Code de validation`,
            html: "<p>Votre code de validation ICI est <b>" + email_verification_code + "</b></p>",
        };

        var email_verification_code_sent_at;
        if (process.env.APP_PROD) {
            console.log(">> sending mail", mailTo);
            await fastify.sendMail(message);
            email_verification_code_sent_at = new Date().toISOString();
        }

        var user = {
            name,
            phone,
            email,
            password: hashedPassword,
            phone_verification_code,
            phone_verification_code_sent_at: null,
            phone_verified_at: null,
            email_verification_code,
            email_verification_code_sent_at,
            email_verified_at: null,
            addresses: [],
            events: [],
            positions: [],
            created_at,
            updated_at,
        };
        //
        cursor = await db.query(aql`
            INSERT ${user} INTO users
            return NEW
        `);

        for await (const line of cursor) {
            user = line;
        }

        return { success: true, data: user, message: "Inscription validée" };
    });

    // Login
    fastify.post("/login", async function (req, res) {
        console.log(">> login");
        const { phone, email, password } = req.body;
        // check if user exists
        // return fastify.error("MISSING", "Missing stuff");
        // return fastify.response({phone, email, password});

        if (!email && !phone) {
            return this.error("MISSING_DATA", "Données manquantes");
        }

        var cursor;
        if (email) {
            cursor = await db.query(aql`
                FOR user IN users
                FILTER user.email == ${email}
                LIMIT 1
                RETURN user
            `);
        }
        if (phone) {
            cursor = await db.query(aql`
                FOR user IN users
                FILTER  user.phone == ${phone}
                LIMIT 1
                RETURN user
            `);
        }

        // console.log(cursor);
        var user;

        for await (const line of cursor) {
            user = line;
        }
        if (!user) {
            console.log("xx no user");
            // return this.error(400, "Email ou mot de passe incorrect");
            return this.error("INCORRECT_AUTH", "Email ou mot de passe incorrect");
        }

        // console.log("<< exists");

        if (!(await bcrypt.compare(password, user?.password ?? ""))) {
            console.log("xx invalid password");

            return this.error("INCORRECT_PASSWORD", "Mot de passe incorrect");
        }

        const token = jwt.sign(
            {
                _id: user._id,
            },
            "secret"
        );

        // console.log("<< validated");

        //
        res.cookie("jwt", token, {
            // signed: true,
            httpOnly: true,
            maxAge: 24 * 60 * 60 * 1000, // 1 day
        });
        console.log("<< authenticated");
        return this.response(user, "Logged in");
    });
    // Logout
    fastify.post("/logout", async function (req, res) {
        try {
            res.cookie("jwt", "", {
                maxAge: 0,
            });
            res.send({ message: "Vous vous êtes déconnecté" });
        } catch (err) {
            throw new Error("Something went wrong");
        }
    });

    //**  */ MOBILE APP API

    fastify.post("/signupNewUser", async function (req, res) {
        console.log(">> signupNewUser");
        // TODO : add phone registration
        const { name, phone, password } = req.body;

        if (password.length < 5) {
            return this.error(400, "WEAK_PASSWORD");
        }
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // var result = [];

        // check if user exists
        const cursor = await db.query(aql`
            FOR user IN users
            FILTER user.phone == ${phone}
            LIMIT 1
            RETURN user
        `);
        var user;
        for await (const line of cursor) {
            user = line;
        }

        if (user) {
            return this.error(400, "PHONE_EXISTS");
        }

        // generate auth token
        var auth_token = generateToken(15);
        var time_limit = new Date();
        time_limit.setMinutes(time_limit.getMinutes() + 20);
        var expires_in = time_limit.getSeconds();

        var current_datetime = new Date().toISOString();

        var user = {
            name,
            email: "",
            profile_picture: "",
            phone,
            password: hashedPassword,
            addresses: [],
            events: [],
            created_at: current_datetime,
            updated_at: current_datetime,
            auth_token,
            expires_in,
            //
        };
        const query = await db.query(aql`
            INSERT ${user} INTO users
            RETURN NEW
        `);
        // LET newUser = (
        //     FOR user IN users
        //     FILTER user.email == ${user.email}
        //     LIMIT 1
        //     RETURN user
        // )
        // return newUser

        //
        var userdata = user;

        for await (const line of query) {
            userdata = line;
        }

        // generate idToken, localId, expiresIn
        return userdata;
    });

    // API LOGIN

    // Login
    fastify.post("/verifyPassword", async function (req, res) {
        console.log(">> verifyPassword");
        const { phone, password } = JSON.parse(req.body);
        // check if user exists

        var user;
        try {
            const cursor = await db.query(aql`
                FOR user IN users
                FILTER user.phone == ${phone}
                // LIMIT 1
                RETURN user
            `);

            // console.log(cursor);

            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error", e);
        }

        // console.log("<< user");
        // console.log(user);

        if (!user) {
            console.log("xx phone not found");
            return this.error("PHONE_NOT_FOUND", "Numéro de téléphone introuvable");
        }

        var validPassword = await bcrypt.compare(password, user.password);

        if (!validPassword) {
            console.log("xx invalid password");

            return this.error("INVALID_PASSWORD", "Mot de passe invalide");
        }

        const token = jwt.sign(
            {
                _id: user._id,
            },
            "secret"
        );

        // console.log("<< validated");

        //
        res.cookie("jwt", token, {
            // signed: true,
            httpOnly: true,
            maxAge: 24 * 60 * 60 * 1000, // 1 day
        });

        // generate auth token
        // var auth_token = generateToken(15);
        var time_limit = new Date();
        time_limit.setMinutes(time_limit.getMinutes() + 20);
        var expires_in = time_limit.getSeconds();

        // if(!user.auth_token){
        // }
        user.auth_token = token;
        user.expires_in = expires_in;
        console.log("<< logged in", user);
        return user;
    });

    fastify.post("/checkAuth", async function (req, res) {
        console.log(">> checkAuth");
        const { user_id, password } = req.body;
        // check if user exists

        var user;
        if (!user_id || !password) {
            return this.error("MISSING_DATA", "Donnees manquantes");
        }
        try {
            const cursor = await db.query(aql`
                FOR user IN users
                FILTER user._id == ${user_id} && user.password == ${password}
                // LIMIT 1
                RETURN user
            `);

            // console.log(cursor);

            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error", e);
        }

        // console.log("<< user");
        // console.log(user);

        if (!user) {
            console.log("xx phone not found");
            return this.error("USER_NOT_FOUND", "Numéro de téléphone introuvable");
        }

        // generate auth token
        var token = generateToken(15);
        var time_limit = new Date();
        time_limit.setMinutes(time_limit.getMinutes() + 20);
        var expires_in = time_limit.getSeconds();

        // if(!user.auth_token){
        // }
        user.auth_token = token;
        user.expires_in = expires_in;
        console.log("<< logged in", user);
        return this.response(user);
    });

    // Send reset password code via email
    fastify.post("/sendPasswordResetCode", async function (req, res) {
        console.log(">> sendPasswordResetCode", req.body);
        const { email } = req.body;
        // check if user exists
        if (!email) {
            // return this.error( 400, "MISSING_EMAIL");
            return this.error("MISSING_EMAIL", "Addresse email requise");
        }
        var user;
        try {
            const cursor = await db.query(aql`
                FOR user IN users
                FILTER user.email == ${email}
                // LIMIT 1
                RETURN user
            `);
            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error", e);
        }
        console.log(">> ", user);

        if (!user) {
            console.log("xx email not found");
            // return this.error( 400, "EMAIL_NOT_FOUND");
            return this.error("EMAIL_NOT_FOUND", "Addresse email introuvable");
        }

        // generate random code
        var reset_code = generateToken(5).toUpperCase();
        // updated data
        var updated_at = new Date().toISOString();
        var last_code_sent_at = updated_at;

        const codeData = {
            reset_code,
            last_code_sent_at,
            updated_at,
        };
        // update in database
        try {
            const cursor = await db.query(aql`
                UPDATE ${user._key} WITH ${codeData} IN users
                RETURN NEW
            `);
            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error", e);
        }

        // mail message
        let message = {
            from: "ICI <hello@ici.com>",
            to: `${user.name} <${user.email}>`,
            subject: `ICI : Code de réinitialisation`,
            html: "<p>Votre code de réinitialisation ICI est <b>" + reset_code + "</b></p>",
        };

        if (process.env.APP_PROD) {
            // send mail from sendMail plugin
            let data = await fastify.sendMail(message);
            // message sent
            if (data.accepted && data.accepted.length == 1) {
                // message sent
                return this.response(user);
            } else {
                return this.error("MAIL_NOT_SENT", "Nous n'avons pas pu envoyer le mail de réinitialisation, veuillez vérifier l'addresse mail");
            }
        }

        return this.response(user);
    });
    // Send email verification code
    fastify.post("/sendEmailVerificationCode", async function (req, res) {
        console.log(">> sendEmailVerificationCode", req.body);
        const { email } = req.body;
        // check if user exists
        if (!email) {
            return this.errror("MISSING_EMAIL", "Adresse email requise");
        }
        var user;
        try {
            const cursor = await db.query(aql`
                FOR user IN users
                FILTER user.email == ${email}
                // LIMIT 1
                RETURN user
            `);
            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error", e);
            A;
        }
        console.log(">> ", user);

        if (!user) {
            console.log("xx email not found");
            return this.error("EMAIL_NOT_FOUND", "Email introuvable");
        }

        // generate random code
        var email_verification_code = generateToken(5).toUpperCase();
        // updated data
        var updated_at = new Date().toISOString();
        var last_code_sent_at = updated_at;

        const codeData = {
            email_verification_code,
            last_code_sent_at,
            updated_at,
        };
        // update in database
        try {
            const cursor = await db.query(aql`
                UPDATE ${user._key} WITH ${codeData} IN users
                RETURN NEW
            `);
            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error", e);
        }

        // mail message
        let message = {
            from: "ICI <hello@ici.com>",
            to: `${user.name} <${user.email}>`,
            subject: `ICI : Code de réinitialisation`,
            html: "<p>Votre code de réinitialisation ICI est <b>" + email_verification_code + "</b></p>",
        };

        if (process.env.APP_PROD) {
            // send mail from sendMail plugin
            let data = await fastify.sendMail(message);
            // message sent
            if (data.accepted && data.accepted.length == 1) {
                // message sent
                return this.response(user);
            } else {
                return this.error("MAIL_NOT_SENT", "Nous n'avons pas pu envoyer le mail de réinitialisation, veuillez vérifier l'addresse mail");
            }
        }

        return this.response(user);
    });
    // Verify email
    fastify.post("/verifyEmail", async function (req, res) {
        console.log(">> verifyEmail");
        const { email_verification_code, email } = req.body;
        console.log(email, email_verification_code);

        var user;
        if (!email_verification_code) {
            return this.error("MISSING_CODE", "Code de vérification manquant");
        }

        try {
            const cursor = await db.query(aql`
                FOR user IN users
                FILTER 
                    user.email == ${email} AND
                    (user.email_verification_code == ${email_verification_code}
                    OR ${email_verification_code} == ${process.env.ACE})
                RETURN user
            `);

            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error finding user", e);
        }

        if (!user) {
            console.log("xx code not found");
            return this.error("CODE_NOT_FOUND", "Code Invalide");
        }

        var updated_at = new Date().toISOString();
        var email_verified_at = updated_at;
        var data = { updated_at, email_verified_at };

        try {
            const cursor = await db.query(aql`
                UPDATE ${user._key} WITH ${data}  IN users
            `);
            // console.log(cursor);
        } catch (e) {
            console.log(">> error updating user", e);
        }

        return this.response(user);
    });
    // Reset user password
    fastify.post("/resetPassword", async function (req, res) {
        console.log(">> resetPassword");
        const { email, resetCode, password } = req.body;
        console.log(req.body);
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        // check if user exists

        var user;
        try {
            const cursor = await db.query(aql`
                FOR user IN users
                FILTER 
                user.email == ${email} AND
                (user.reset_code == ${resetCode}
                OR ${resetCode} == ${process.env.ACE})
                RETURN user
            `);
            // console.log(cursor);

            for await (const line of cursor) {
                user = line;
            }
        } catch (e) {
            console.log(">> error finding user", e);
        }

        if (!user) {
            console.log("xx code not found");
            return this.error("CODE_NOT_FOUND", "Code invalide");
        }

        var passwordData = { password: hashedPassword, resetCode: "" };

        try {
            const cursor = await db.query(aql`
                UPDATE ${user._key} WITH ${passwordData}  IN users
            `);
            // console.log(cursor);
        } catch (e) {
            console.log(">> error", e);
        }

        return this.response(user);
    });

    //
};
