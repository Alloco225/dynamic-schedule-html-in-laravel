"use strict";
/**
 * Node.js implementation of browser `btoa` function.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.btoa = void 0;
/**
 * @internal
 * @hidden
 */
function btoa(str) {
    return Buffer.from(str).toString("base64");
}
exports.btoa = btoa;
//# sourceMappingURL=btoa.js.map