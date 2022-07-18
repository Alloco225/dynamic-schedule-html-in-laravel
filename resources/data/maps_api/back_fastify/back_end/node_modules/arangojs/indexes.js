"use strict";
/**
 * ```ts
 * import type {
 *   FulltextIndex,
 *   GeoIndex,
 *   HashIndex,
 *   PersistentIndex,
 *   PrimaryIndex,
 *   SkiplistIndex,
 *   TtlIndex,
 * } from "arangojs/indexes";
 * ```
 *
 * The "indexes" module provides index-related types for TypeScript.
 *
 * @packageDocumentation
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports._indexHandle = void 0;
/**
 * @internal
 * @hidden
 */
function _indexHandle(selector, collectionName) {
    if (typeof selector !== "string") {
        if (selector.id) {
            return _indexHandle(selector.id, collectionName);
        }
        throw new Error("Index handle must be a string or an object with an id attribute");
    }
    if (selector.includes("/")) {
        if (!selector.startsWith(`${collectionName}/`)) {
            throw new Error(`Index ID "${selector}" does not match collection name "${collectionName}"`);
        }
        return selector;
    }
    return `${collectionName}/${selector}`;
}
exports._indexHandle = _indexHandle;
//# sourceMappingURL=indexes.js.map