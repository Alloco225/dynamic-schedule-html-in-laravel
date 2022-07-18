"use strict";

const { Database, aql } = require("arangojs");
const slugify = require("slugify");
const fs = require("fs");
const path = require("path");

module.exports = async function (fastify, opts) {
    console.log("\n ** releases **");
    const database = new Database({
        url: process.env.ARANGO_HOST,
        databaseName: process.env.ARANGO_DB,
        auth: { username: process.env.ARANGO_AUTH, password: process.env.ARANGO_PASSWORD },
    });

    const appPass = [
        "olivier0304",
        "amane2511",
        "abdoul2407",
        "abraham2201",
        "andrea1502",
        "aristide2106",
        "hazizu0405",
        "berassou2305",
        "christine",
        "esdras0902",
        "israel1107",
        "itchigo0101",
        "jacques0811",
        "jemima1210",
        "jesse0501",
        "jonas1001",
        "michel0208",
        "marc2801",
        "nafiou1612",
        "pakaline3005",
        "patrick2006",
        // "roland",
        "roland1807",
        "stephanie0401",
        // "thibault",
        "yoel1809",
    ];
    var appData = {
        users: {
            females: ["Andréa Gbamele", "Bérassou Koffi", "Christine Biley", "Jemima Gbato", "Pakaline Monlieu", "Stéphanie Kouakou"],
        },
        testers: [
            "Joseph-Olivier Biley",
            "Amané Hosanna",
            "Abdoul Sérémé",
            "Abraham Koné",
            "Andréa Gbamele",
            "Aristide Manyesse",
            "Hazizu Sunmaila",
            "Bérassou Koffi",
            "Christine Biley",
            "Esdras Koya",
            "Israel Coulibaly",
            "Itchigo Uzumaki",
            "Jacques Gnongui",
            "Jemima Gbato",
            "Jesse Gougou",
            "Jonas Tano",
            "Michel Koya",
            "Marc Irié",
            "Nafiou Waidi",
            "Pakaline Monlieu",
            "Patrick Séry",
            // "Roland Aké",
            "Roland Assoh",
            "Stéphanie Kouakou",
            // "Thibault Kanga",
            "Yoel ",
        ],

        // [
        //     "Joseph-Olivier Biley",
        //     "olivier0304",
        //     "Amané Hosanna",
        // "amane2511",
        //     "Abdoul Sérémé",
        // "abdoul2407",
        //     "Abraham Koné",
        // "abraham2201",
        //     "Andréa Gbamele",
        // "andrea1502",
        //     "Aristide Manyasse",
        // "aristide2106",
        //     "Azizu Soumaila",
        // "azizu0405",
        //     "Bérassou Koffi",
        // "berassou2305",
        //     "Christine Biley",
        // "christine",
        //     "Esdras Koya",
        // "esdras0902",
        //     "Israel Coulibaly",
        // "israel1107",
        //     "Itchigo Uzumaki",
        // "itchigo0101",
        //     "Jacques Gnongui",
        // "jacques0811",
        //     "Jemima Gbato",
        // "jemima1210",
        //     "Jesse Gougou",
        // "jesse0501",
        //     "Jonas Tano",
        // "jonas1001",
        //     "Michel Koya",
        // "michel0208",
        //     "Marc Irié",
        // "marc2801",
        //     "Nafiou Waidi",
        // "nafiou1612",
        //     "Pakaline Monlieu",
        // "pakaline3005",
        //     "Patrick Séry",
        // "patrick2006",
        //     // "Roland Aké",
        // // "roland",
        //     "Roland Assoh",
        // "roland1807",
        //     "Stéphanie Kouakou",
        // "stephanie0401",
        //     // "Thibault Kanga",
        // // "thibault",
        //     "Yoel ",
        // "yoel1809",
        // ]
        review: [
            {
                title: "Ca fonctionne très bien, bravo",
                value: "good",
            },
            {
                title: "Ca fonctionne, MAIS ",
                value: "good_but",
                subreview: [
                    {
                        title: "Ca affiche une erreur",
                        value: "warning",
                    },
                    {
                        title: "C'est lent",
                        value: "slow",
                    },
                    {
                        title: "Ca crashe",
                        value: "crash",
                    },
                    {
                        title: "Est-ce qu'on peut pas..",
                        value: "suggestion",
                    },
                ],
            },
            {
                title: "Ca fonctionne pas comme ça devrait",
                value: "error",
            },
            {
                title: "Je me demande si c'est pas mieux de",
                value: "suggestion",
            },
            {
                title: "Autre",
                value: "other",
            },
        ],
    };
    fastify.get("/", async function (request, reply) {
        var releases = [];
        // secret tool for later
        var options = appData;
        try {
            const query = await database.query(aql`
                FOR r IN app_releases
                SORT r._id DESC
                RETURN r
            `);

            for await (var item of query) {
                releases.push(item);
            }
            var message;
            var auth;
            var reviewed = [];
        } catch (e) {
            console.log("xx error getting releases", e);
        }

        // Check for users in current/not ended sessions
        var user_sessions = [];
        // try {
        //     const getSessions = await database.query(aql`
        //     FOR session IN app_release_testing_sessions
        //         // FILTER session.end == null
        //     RETURN session
        // `);

        //     for await (var item of getSessions) {
        //         user_sessions.push(item);
        //     }
        // } catch (e) {
        //     console.log("xx error getting user sessions", e);
        // }

        try {
            message = JSON.parse(request.session.get("message"));
            request.session.set("message", null);
            auth = JSON.parse(request.session.get("auth"));
            //
            if (request.session.get("reviewed")) reviewed = JSON.parse(request.session.get("reviewed"));
            if (auth) {
                if (!reviewed) {
                    // fill up reviewed features
                    releases.forEach((release) => {
                        release.comments.forEach((comment) => {
                            if (comment.tester === auth) {
                                reviewed.add(comment.feature);
                            }
                        });
                    });
                }
            }
            // update available users from non sessionned
            var testers_to_display = [];

            if (user_sessions.length > 0) {
                appData.testers.forEach((tester) => {
                    // check sessions
                    var is_offline = true;

                    user_sessions.forEach((session) => {
                        if (session.user == tester) {
                            is_offline = false;
                            console.log("::|:: ", tester);
                        }
                    });

                    if (is_offline) {
                        if (testers_to_display.indexOf(tester) === -1) {
                            testers_to_display.push(tester);
                            console.log("::0:: ", tester);
                        }
                    }
                });
                //
                options.testers = testers_to_display;
                // save to cache
                request.session.set("reviewed", JSON.stringify(reviewed));
            } else {
                console.log("<<< no session");
                // if no session no user
                // if (auth) {
                //     // warn user if session is on
                //     request.session.set("auth", null);
                //     request.session.set("reviewed", null);
                //     message = JSON.stringify({ success: false, title: "Oups, La Session a expiré", content: "Essaie de te reconnecter pour voir" });
                //     request.session.set("message", message);
                //     // request.session.set("message", null);
                //     auth = null;
                // }
            }
        } catch (e) {
            console.log("xx error parsing message");
            reviewed = [];
        }
        console.log(">>>auth", auth, reviewed);
        return reply.view("/templates/releases.ejs", { releases, options, message, auth, reviewed });
        // return reply.sendFile("releases.html"); // serving path.join(__dirname, 'public', 'myHtml.html') directly
    });
    // submit and login
    fastify.post("/", async function (request, reply) {
        var { tester, feature, review, comment, version, password } = request.body;
        if (!(tester || feature || review, comment)) {
            return this.error("MISSING_DATA", "Certaines données manquent");
        }
        var tester_words = tester.split(" ");
        var auth = "";
        if (request.session.get("auth")) auth = JSON.parse(request.session.get("auth"));

        // check db auth

        if (!auth) {
            if (!password) {
                return this.error("UNAUTHENTICATED", "Faut se connecter d'abord");
            }
        }

        // Check for users in current/not ended sessions
        var user_sessions = [];
        try {
            const getSessions = await database.query(aql`
            FOR session IN app_release_testing_sessions
                FILTER session.end == null
            RETURN session
        `);

            for await (var item of getSessions) {
                user_sessions.push(item);
            }
        } catch (e) {
            console.log("xx error getting user sessions", e);
        }

        if (user_sessions.length < 1) {
            return reply.redirect("/releases");
        }
        var isAuth = false;
        user_sessions.forEach((session) => {
            if (session.user == auth) {
                // return reply.redirect("/releases");
                isAuth = true;
            }
        });

        if(!isAuth){
            return reply.redirect("/releases");
        }

        var release;
        // find release
        try {
            const query = await database.query(aql`
                    FOR r IN app_releases
                    FILTER r.slug == ${version}
                    RETURN r
                `);

            for await (var item of query) {
                release = item;
            }

            if (!release) {
                return this.error("NOT_FOUND", "La version " + version + " spécifiée est introuvable, et on a fouillé partout");
            } else {
                console.log(">>xx release exists", release.slug);
            }
        } catch (e) {
            console.log("xx arango error", e);
            return this.error("NOT_FOUND", "On a eu un souci en cherchant la version à commenter");
        }
        // Check if user downloaded the app first
        var hasDownloaded = false;
        if (release.downloads) {
            release.downloads.forEach((download) => {
                if (download.user === auth) {
                    hasDownloaded = true;
                }
            });
        }
        if (!hasDownloaded) {
            var meh = [
                "meh",
                ":/",
                "ಠ_ಠ",
                "( ͡°Ĺ̯ ͡° )",
                "ب_ب",
                "ಠಠ",
                "(≖︿≖ )",
                "(ノಠ益ಠ)ノ彡┻━┻",
                "ლ(ಠ益ಠლ)",
                "(╯°□°）╯︵/( ‿⌓‿ )\\",
                "(┛◉Д◉)┛彡┻━┻",
                "┻━┻ ︵ヽ(`Д´)ﾉ︵ ┻━┻",
                "ಠoಠ",
                '("º _ º)',
                "òó",
                "ಠ_ಥ",
            ];
            var emj = meh[Math.floor(Math.random() * meh.length)];
            var rep = tester_words[0] + ", tu n'as pas encore téléchargé l'application " + emj;
            return this.error("NOT_DOWNLOADED", rep);
        }
        // Check if user has not reviewed the feature
        release.comments.forEach((comment, index) => {
            if (comment.tester == tester && comment.feature == feature) {
                return this.error("DUPLICATE", tester_words[0] + ", on a déjà enregistré que tu dis que ''" + comment.comment + "''");
            }
        });

        var datetime = new Date().toISOString();
        var newComment = {
            tester,
            feature,
            review,
            comment,
            created_at: datetime,
        };

        // console.log(">>> release", release);
        try {
            var updatedRelease = {};

            const cursor = await database.query(aql`
                FOR release IN app_releases
                    FILTER release.slug == ${version}
                        UPDATE release WITH { comments: UNSHIFT(release.comments, ${newComment}) } IN app_releases
                    RETURN NEW
            `);

            for await (var item of cursor) {
                updatedRelease = item;
            }
        } catch (e) {
            console.log(">> error updating release", e);
            var texts = ["On n'a pas pu sauvegardé votre commentaire, désolé", "Contactez Amané si le problème persiste"];
            return this.error("DB_ERROR", texts[Math.floor(Math.random() * texts.length)]);
        }

        try {
            console.log(">>>caching");
            // Save tester
            var auth = JSON.stringify(tester);
            request.session.set("auth", auth);
            // save reviewed item
            var reviewed = [];
            //
            if (request.session.get("reviewed")) reviewed = JSON.parse(request.session.get("reviewed"));
            //
            reviewed.push(feature);
            console.log(">>< reviewed", reviewed);

            // save
            var reviewedJson = JSON.stringify(reviewed);
            console.log(">>< reviewed json", reviewedJson);

            request.session.set("reviewed", reviewedJson);
        } catch (err) {
            console.log(">> error parsing session ", err);
        }

        return this.response({ version, count: updatedRelease.comments.length });
    });

    fastify.post("/logout", async function (request, reply) {
        var auth;
        var session_id;

        if (request.session.get("auth")) auth = JSON.parse(request.session.get("auth"));
        if (request.session.get("session_id")) session_id = JSON.parse(request.session.get("session_id"));

        var words = auth.split(" ");
        var fN = words[0] ?? "";
        var goodbyeTexts = [
            "Au revoir",
            "C'est un redjô !",
            "Bye bye",
            "Merci d'avoir participé",
            "Merci, à bientôt",
            "Ciao",
            "Reviens pour de nouvelles release",
            "Sayounara",
            "さようなら",
        ];
        var message = JSON.stringify({ success: true, title: "A très bientôt " + fN + " !", content: goodbyeTexts[Math.floor(Math.random() * goodbyeTexts.length)] });
        request.session.set("auth", null);
        request.session.set("reviewed", null);
        request.session.set("message", message);
        auth = false;

        if (!session_id) {
            return this.response(true);
        }

        // update session
        var current_session;
        try {
            const getCurrentSession = await database.query(aql`
                    FOR session IN app_release_testing_sessions
                    FILTER session.session_id == ${session_id}
                    RETURN session
                `);

            for await (var item of getCurrentSession) {
                current_session = item;
            }
        } catch (e) {
            console.log("xx arango error, finding session", e);
        }

        if (current_session) {
            // Update session
            try {
                var datetime = new Date().toISOString();
                var session_update_data = {
                    end: datetime,
                };
                // insert session data
                const newSession = await database.query(aql`
                    FOR session IN app_release_testing_sessions
                        FILTER session.session_id == ${session_id}
                        UPDATE session WITH ${session_update_data} IN app_release_testing_sessions
                `);

                return this.response(true);
            } catch (e) {
                console.log("xx arango error, start session", e);
            }
        }
        return this.response(true);
    });
    fastify.post("/login", async function (request, reply) {
        var { username, password } = request.body;
        var auth;
        var latest_session_id;
        var welcomeMessages = [""];
        var message;

        var index = appData.testers.indexOf(username);
        if (index === -1) return this.error("USER_NOT_FOUND", "On connais pas ce nom là");
        if (appPass[index] !== password) return this.error("WRONG_PASSWORD", "Mot de passe là c'est pas ça");
        //
        auth = username;
        request.session.set("auth", JSON.stringify(auth));
        //
        if (request.session.get("session_id")) latest_session_id = JSON.parse(request.session.get("session_id"));
        //
        var words = auth.split(" ");
        var fN = words[0] ?? "";

        // find last session
        var user_sessions = [];
        var last_session;
        // get latest session
        try {
            const getSessions = await database.query(aql`
                    FOR session IN app_release_testing_sessions
                    FILTER session.user == ${username}
                    RETURN session
                `);

            for await (var item of getSessions) {
                user_sessions.push(item);
            }
        } catch (e) {
            console.log("xx arango error, counting sessions", e);
            // return reply.error("/releases");
        }
        var session_count = user_sessions.length;
        last_session = user_sessions[user_sessions.length - 1];

        if (last_session) {
            // if latest session exists
            // check if ended
            if (!last_session.end) {
                // if last session is not terminated
                // TODO make realistic with limit on session duration
                message = JSON.stringify({ success: true, title: "Bon retour, " + fN + " !", content: "\\(^^)/" });
                request.session.set("session_id", JSON.stringify(last_session.session_id));
                request.session.set("message", message);

                return this.response(fN);
            }
        }

        // create new user session
        var datetime = new Date().toISOString();
        var session_id = slugify("sss " + username + " " + datetime, { replacement: "_", strict: true, lower: true });
        // TODO store browser version n operator
        var meta_data = request.headers;

        var session_data = {
            session_id,
            user: username,
            start: datetime,
            end: null,
            meta_data,
        };

        try {
            // insert session data
            const newSession = await database.query(aql`
                INSERT ${session_data} INTO app_release_testing_sessions
            `);
        } catch (e) {
            console.log("xx arango error, start session", e);
        }

        request.session.set("session_id", JSON.stringify(session_id));
        // Set welcome message
        var titleTexts = ["Bienvenue, "];
        if (session_count < 1) {
            welcomeMessages = ["Bonne arrivée", "Premier gaou 😂", "Bonne première utilisation"];
            titleTexts = ["Sois le bienvenu "];
            if (appData.users.females.indexOf(auth) !== -1) {
                welcomeMessages[1] = "Première gawazz 😂";
                titleTexts = ["Sois la bienvenue, "];
            }
        } else {
            titleTexts = ["Bon retour parmi nous, "];
            welcomeMessages = ["Tu nous as manqué ", "On espère que tu vas bien", "2 jours hin 👊🏿", "Welcome back"];
        }
        message = JSON.stringify({
            success: true,
            title: titleTexts[Math.floor(Math.random() * titleTexts.length)] + fN + " !",
            content: welcomeMessages[Math.floor(Math.random() * welcomeMessages.length)],
        });
        request.session.set("message", message);

        return this.response(fN);
    });

    fastify.get("/download/:version", async function (request, reply) {
        var auth;
        var message;
        if (request.session.get("auth")) auth = JSON.parse(request.session.get("auth"));
        if (!auth) {
            message = JSON.stringify({ success: false, title: "403", content: "Faut se connecter pour télécharger l'apk" });
            request.session.set("message", message);
            return reply.redirect("/releases");
        }
        var version = request.params.version;
        var message;
        // Find release
        var release;

        try {
            const query = await database.query(aql`
                    FOR r IN app_releases
                    FILTER r.slug == ${version}
                    RETURN r
                `);

            for await (var item of query) {
                release = item;
            }

            if (!release) {
                // insert release
                message = JSON.stringify({ success: false, title: "404", content: "Hm, il semble que cette version soit introuvable" });
                request.session.set("message", message);
                return reply.redirect("/releases");
            } else {
                console.log(">>xx release exists", release.slug);
            }
        } catch (e) {
            console.log("xx arango error", e);
            // TODO save log
            message = JSON.stringify({ success: false, title: "Oups !", content: "Petit souci. Veuillez réessayer" });
            request.session.set("message", message);
            return reply.redirect("/releases");
        }
        // console.log(">>> release", release);
        try {
            var datetime = new Date().toISOString();
            var downloads = [];
            if (release.downloads) {
                release.downloads.forEach((download) => {
                    downloads.unshift(download);
                });
            }
            downloads.unshift({
                user: auth,
                downloaded_at: datetime,
            });

            // Update download count
            var updateData = {
                download_count: release.download_count + 1,
                updated_at: datetime,
                last_download: datetime,
                downloads,
            };

            const cursor = await database.query(aql`
                UPDATE ${release._key} WITH ${updateData} IN app_releases
            `);
        } catch (e) {
            console.log(">> error updating release", e);
            message = JSON.stringify({ success: false, title: "Oups !", content: "Petit souci. Veuillez réessayer ou contacter Amané" });
            request.session.set("message", message);
            return reply.redirect("/releases");
        }

        // download
        try {
            // var file = "releases/"+release.slug;
            // return reply.sendFile(file);
            var file = path.join("public", "releases", release.slug);
            console.log(">>><<<<<< ", file);
            var apk = fs.existsSync(file);
            if (apk) {
                console.log(">> file exists");
                // message = JSON.stringify({ success: true, title: "Yay ! ", content: `${release.name} v ${release.version} téléchargé` });
                // request.session.set("message", message);
                const stream = fs.createReadStream(file);
                return reply.send(stream);
            } else {
                console.log("<<xx file doesn't exist");
                message = JSON.stringify({ success: false, title: "Oups !", content: "Le fichier a apparement été supprimé" });
                request.session.set("message", message);
                return reply.redirect("/releases");
            }
        } catch (e) {
            console.log(">> error downloading release", e);
            message = JSON.stringify({ success: false, title: "Oups !", content: "Nous n'avons pas pu télécharger le fichier" });
            request.session.set("message", message);
            return reply.redirect("/releases");
        }
    });

    // setup releases
    fastify.get("/setup/cmd/amane/yes", async function (request, reply) {
        var releases = [
            {
                name: "Ici Collector",
                version: "0.5.0",
                size: "20 MB",
                features: [
                    {
                        name: "Authentication",
                        status: "done",
                        description: "",
                        features: [
                            {
                                name: "Inscription",
                                status: "done",
                                description: "",
                            },
                            {
                                name: "Connexion",
                                status: "done",
                                description: "",
                            },
                            {
                                name: "Déconnexion",
                                status: "done",
                                description: "",
                            },
                            {
                                name: "Mot de passe oublié",
                                status: "ongoing",
                                description: "",
                            },
                            {
                                name: "Réinitialisation de mot de passe",
                                status: "ongoing",
                                description: "",
                            },
                        ],
                    },

                    {
                        name: "Carte",
                        status: "done",
                        description: "",
                        features: [
                            {
                                name: "Affichage de carte",
                                status: "done",
                                description: "",
                            },
                            {
                                name: "Actualisation de positions",
                                status: "done",
                                description: "",
                            },
                        ],
                    },

                    {
                        name: "Places",
                        status: "done",
                        description: "",
                        features: [
                            {
                                name: "Popup tutoriel",
                                status: "done",
                                description: "",
                            },
                            {
                                name: "Dessin de polygone",
                                status: "done",
                                description: "",
                            },
                            {
                                name: "Enregistrement de place",
                                status: "done",
                                description: "Formulaire d'enregistrement",
                            },
                            {
                                name: "Affichage des places",
                                status: "done",
                                description: "Traduction du truc",
                            },
                        ],
                    },

                    {
                        name: "Tracking",
                        status: "cancelled",
                    },
                ],
            },
        ];

        var releaseData = [];

        releases.forEach((release) => {
            var title = slugify(release.name, { replacement: "_", strict: true, lower: true });
            var slug = title + "-v" + release.version + ".apk";
            var datetime = new Date().toISOString();

            // features
            var features = [];

            if (release.features) {
                release.features.forEach((feature) => {
                    var featSlug = "";
                    if (feature.name) {
                        featSlug = slugify(feature.name, { replacement: "_", strict: true, lower: true });
                    } else {
                        featSlug = slugify(feature.description.substring(0, 15), { replacement: "_", strict: true, lower: true });
                    }

                    // sub features
                    var subfeatures = [];
                    if (feature.features) {
                        feature.features.forEach((subfeature) => {
                            var subfeatSlug = "";
                            if (subfeature.name) {
                                subfeatSlug = slugify(subfeature.name, { replacement: "_", strict: true, lower: true });
                            } else {
                                subfeatSlug = slugify(subfeature.description.substring(0, 15), { replacement: "_", strict: true, lower: true });
                            }
                            subfeatures.push({
                                status: subfeature.status,
                                name: subfeature.name,
                                slug: subfeatSlug,
                                description: subfeature.description,
                            });
                        });
                    }

                    features.push({
                        status: feature.status,
                        name: feature.name,
                        slug: featSlug,
                        description: feature.description,
                        features: subfeatures,
                    });
                });
            }
            var data = {
                slug,
                size: release.size,
                name: release.name,
                version: release.version,
                features,
                comments: [],
                downloads: [],
                download_count: 0,
                created_at: datetime,
                // file: "/releases/" + slug,
            };
            releaseData.push(data);
        });

        var query;
        releaseData.forEach(async (release) => {
            // check if exists
            var existingRelease;
            try {
                query = await database.query(aql`
                    FOR r IN app_releases
                    FILTER r.slug == ${release.slug}
                    RETURN r
                `);

                for await (var item of query) {
                    existingRelease = item;
                }
                // Create release if doesn't exist
                if (!existingRelease) {
                    // insert release
                    query = await database.query(aql`
                        INSERT ${release} INTO app_releases
                    `);
                    console.log(">> added release", release.slug);
                } else {
                    console.log(">>xx release exists", release.slug);
                }
            } catch (e) {
                console.log("xx arango error", e);
                // TODO save log
            }
        });

        return this.response(true);
    });
    // setup clear
    fastify.get("/cleanup/cmd/amane/yes", async function (request, reply) {
        request.session.set("auth", null);
        request.session.set("reviewed", null);

        return this.response(true);
    });
    // setup releases
    // fastify.get("/setup/new/cmd/amane/yes", async function (request, reply) {
    //     var releases = [
    //         {
    //             name: "Ici Collector",
    //             version: "0.0.8",
    //             features: [
    //                 {
    //                     name: "Inscription",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Connexion",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Déconnexion",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Mot de passe oublié",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Réinitialisation de mot de passe",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Carte",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Actualisation de positions",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Popup tutoriel",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Dessin de polygone",
    //                     status: "done",
    //                     description: "",
    //                 },
    //                 {
    //                     name: "Enregistrement de place",
    //                     status: "done",
    //                     description: "Formulaire d'enregistrement",
    //                 },
    //                 {
    //                     name: "Affichage des places",
    //                     status: "ongoing",
    //                     description: "Traduction du truc",
    //                 },
    //                 {
    //                     name: "Tracking",
    //                     status: "cancelled",
    //                 },
    //             ],
    //         },
    //     ];

    //     var releaseData = [];

    //     releases.forEach(async (release) => {
    //         var title = slugify(release.name, { replacement: "_", strict: true, lower: true });
    //         var slug = title + "-v" + release.version + ".apk";
    //         var datetime = new Date().toISOString();

    //         // features
    //         var features = [];

    //         if (release.features) {
    //             release.features.forEach((feature) => {
    //                 var featSlug = "";
    //                 if (feature.name) {
    //                     featSlug = slugify(feature.name, { replacement: "_", strict: true, lower: true });
    //                 } else {
    //                     featSlug = slugify(feature.description.substring(0, 15), { replacement: "_", strict: true, lower: true });
    //                 }

    //                 features.push({
    //                     status: feature.status,
    //                     name: feature.name,
    //                     slug: featSlug,
    //                     description: feature.description,
    //                 });
    //             });
    //         }
    //         var data = {
    //             slug,
    //             name: release.name,
    //             version: release.version,
    //             features,
    //             comments: [],
    //             download_count: 0,
    //             created_at: datetime,
    //             // file: "/releases/" + slug,
    //         };
    //         releaseData.push(data);
    //     });

    //     var query;
    //     releaseData.forEach(async (release) => {
    //         // check if exists
    //         var existingRelease;
    //         try {
    //             query = await database.query(aql`
    //                 FOR r IN app_releases
    //                 FILTER r.slug == ${release.slug}
    //                 RETURN r
    //             `);

    //             for await (var item of query) {
    //                 existingRelease = item;
    //             }
    //             // Create release if doesn't exist
    //             if (!existingRelease) {
    //                 // insert release
    //                 query = await database.query(aql`
    //                     INSERT ${release} INTO app_releases
    //                 `);
    //             }
    //         } catch (e) {
    //             console.log("xx arango error", e);
    //             // TODO save log
    //         }
    //     });

    //     return this.response(true);
    // });
};
