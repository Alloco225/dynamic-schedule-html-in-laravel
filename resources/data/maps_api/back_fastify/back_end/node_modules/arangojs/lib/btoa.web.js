"use strict";
/**
 * Wrapper around browser `btoa` function to allow substituting a
 * Node.js-specific implementation.
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
    return window.btoa(str);
}
exports.btoa = btoa;
//# sourceMappingURL=btoa.web.js.map