"use strict";
/**
 * Utility function for constructing a multipart form in Node.js.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.toForm = void 0;
const stream_1 = require("stream");
const Multipart = require("multi-part");
/**
 * @internal
 * @hidden
 */
function toForm(fields) {
    return new Promise((resolve, reject) => {
        try {
            const form = new Multipart();
            for (const key of Object.keys(fields)) {
                let value = fields[key];
                if (value === undefined)
                    continue;
                if (!(value instanceof stream_1.Readable) &&
                    !(value instanceof global.Buffer) &&
                    (typeof value === "object" || typeof value === "function")) {
                    value = JSON.stringify(value);
                }
                form.append(key, value);
            }
            const stream = form.stream();
            const bufs = [];
            stream.on("data", (buf) => bufs.push(buf));
            stream.on("end", () => {
                bufs.push(Buffer.from("\r\n"));
                const body = Buffer.concat(bufs);
                const boundary = form.getBoundary();
                const headers = {
                    "content-type": `multipart/form-data; boundary=${boundary}`,
                    "content-length": String(body.length),
                };
                resolve({ body, headers });
            });
            stream.on("error", (e) => {
                reject(e);
            });
        }
        catch (e) {
            reject(e);
        }
    });
}
exports.toForm = toForm;
//# sourceMappingURL=multipart.js.map