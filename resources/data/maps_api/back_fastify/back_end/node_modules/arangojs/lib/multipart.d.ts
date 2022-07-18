/**
 * Utility function for constructing a multipart form in Node.js.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
/// <reference types="node" />
import { Headers } from "../connection";
/**
 * @internal
 * @hidden
 */
export declare type Fields = {
    [key: string]: any;
};
/**
 * @internal
 * @hidden
 */
export interface MultipartRequest {
    headers?: Headers;
    body: Buffer;
}
/**
 * @internal
 * @hidden
 */
export declare function toForm(fields: Fields): Promise<MultipartRequest>;
//# sourceMappingURL=multipart.d.ts.map