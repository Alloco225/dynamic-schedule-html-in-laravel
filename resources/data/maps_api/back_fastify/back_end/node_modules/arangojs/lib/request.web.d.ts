/**
 * Node.js implementation of the HTTP(S) request function.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
import { RequestInterceptors, XhrOptions } from "../connection";
import { Errback } from "./errback";
import { ArangojsResponse, RequestOptions } from "./request.node";
export declare const isBrowser = true;
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
export declare function createRequest(baseUrl: string, agentOptions: XhrOptions & RequestInterceptors): ({ method, url, headers, body, timeout, expectBinary }: RequestOptions, cb: Errback<ArangojsResponse>) => void;
//# sourceMappingURL=request.web.d.ts.map