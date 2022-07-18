/**
 * Node.js implementation of the HTTP(S) request function.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
/// <reference types="node" />
import { AgentOptions, ClientRequest, IncomingMessage } from "http";
import { Headers, RequestInterceptors } from "../connection";
import { Errback } from "./errback";
/**
 * @internal
 * @hidden
 */
export interface ArangojsResponse extends IncomingMessage {
    request: ClientRequest;
    body?: any;
    arangojsHostId?: number;
}
/**
 * @internal
 * @hidden
 */
export interface ArangojsError extends Error {
    request: ClientRequest;
}
/**
 * @internal
 * @hidden
 */
export declare type RequestOptions = {
    method: string;
    url: {
        pathname: string;
        search?: string;
    };
    headers: Headers;
    body: any;
    expectBinary: boolean;
    timeout?: number;
};
/**
 * @internal
 * @hidden
 */
export declare type RequestFunction = {
    (options: RequestOptions, cb: Errback<ArangojsResponse>): void;
    close?: () => void;
};
/**
 * @internal
 * @hidden
 */
export declare const isBrowser = false;
/**
 * Create a function for performing requests against a given host.
 *
 * @param baseUrl - Base URL of the host, i.e. protocol, port and domain name.
 * @param agentOptions - Options to use for creating the agent.
 * @param agent - Agent to use for performing requests.
 *
 * @internal
 * @hidden
 */
export declare function createRequest(baseUrl: string, agentOptions: AgentOptions & RequestInterceptors, agent?: any): RequestFunction;
//# sourceMappingURL=request.node.d.ts.map