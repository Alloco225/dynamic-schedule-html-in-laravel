"use strict";
/**
 * Utility function for omitting properties by key.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.omit = void 0;
/**
 * @internal
 * @hidden
 */
function omit(obj, keys) {
    const result = {};
    for (const key of Object.keys(obj)) {
        if (keys.includes(key))
            continue;
        result[key] = obj[key];
    }
    return result;
}
exports.omit = omit;
//# sourceMappingURL=omit.js.map