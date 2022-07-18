"use strict";
/**
 * Node.js implementation of the HTTP(S) request function.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.createRequest = exports.isBrowser = void 0;
const url_1 = require("url");
const btoa_1 = require("./btoa");
const joinPath_1 = require("./joinPath");
const omit_1 = require("./omit");
const xhr_1 = require("./xhr");
exports.isBrowser = true;
/**
 * Create a function for performing requests against a given host.
 *
 * @param baseUrl - Base URL of the host, i.e. protocol, port and domain name.
 * @param agentOptions - Options to use for performing requests.
 *
 * @param baseUrl
 * @param agentOptions
 *
 * @internal
 * @hidden
 */
function createRequest(baseUrl, agentOptions) {
    const { auth, ...baseUrlParts } = url_1.parse(baseUrl);
    const options = omit_1.omit(agentOptions, ["maxSockets"]);
    return function request({ method, url, headers, body, timeout, expectBinary }, cb) {
        const urlParts = {
            ...baseUrlParts,
            pathname: url.pathname
                ? baseUrlParts.pathname
                    ? joinPath_1.joinPath(baseUrlParts.pathname, url.pathname)
                    : url.pathname
                : baseUrlParts.pathname,
            search: url.search
                ? baseUrlParts.search
                    ? `${baseUrlParts.search}&${url.search.slice(1)}`
                    : url.search
                : baseUrlParts.search,
        };
        if (!headers["authorization"]) {
            headers["authorization"] = `Basic ${btoa_1.btoa(auth || "root:")}`;
        }
        let callback = (err, res) => {
            callback = () => undefined;
            cb(err, res);
        };
        const req = xhr_1.default({
            useXDR: true,
            withCredentials: true,
            ...options,
            responseType: expectBinary ? "blob" : "text",
            url: url_1.format(urlParts),
            body,
            method,
            headers,
            timeout,
        }, (err, res) => {
            if (!err) {
                const response = res;
                response.request = req;
                if (!response.body)
                    response.body = "";
                if (options.after) {
                    options.after(null, response);
                }
                callback(null, response);
            }
            else {
                const error = err;
                error.request = req;
                if (options.after) {
                    options.after(error);
                }
                callback(error);
            }
        });
        if (options.before) {
            options.before(req);
        }
    };
}
exports.createRequest = createRequest;
//# sourceMappingURL=request.web.js.map