"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Graph = exports.GraphEdgeCollection = exports.GraphVertexCollection = void 0;
/**
 * ```ts
 * import type {
 *   Graph,
 *   GraphVertexCollection,
 *   GraphEdgeCollection,
 * } from "arangojs/graph";
 * ```
 *
 * The "graph" module provides graph related types and interfaces
 * for TypeScript.
 *
 * @packageDocumentation
 */
const collection_1 = require("./collection");
const documents_1 = require("./documents");
const error_1 = require("./error");
const codes_1 = require("./lib/codes");
/**
 * @internal
 * @hidden
 */
function mungeGharialResponse(body, prop) {
    const { new: newDoc, old: oldDoc, [prop]: doc, ...meta } = body;
    const result = { ...meta, ...doc };
    if (typeof newDoc !== "undefined")
        result.new = newDoc;
    if (typeof oldDoc !== "undefined")
        result.old = oldDoc;
    return result;
}
/**
 * @internal
 * @hidden
 */
function coerceEdgeDefinition(options) {
    const edgeDefinition = {};
    edgeDefinition.collection = collection_1.collectionToString(options.collection);
    edgeDefinition.from = Array.isArray(options.from)
        ? options.from.map(collection_1.collectionToString)
        : [collection_1.collectionToString(options.from)];
    edgeDefinition.to = Array.isArray(options.to)
        ? options.to.map(collection_1.collectionToString)
        : [collection_1.collectionToString(options.to)];
    return edgeDefinition;
}
/**
 * Represents a {@link DocumentCollection} of vertices in a {@link Graph}.
 *
 * @param T - Type to use for document data. Defaults to `any`.
 */
class GraphVertexCollection {
    /**
     * @internal
     * @hidden
     */
    constructor(db, name, graph) {
        this._db = db;
        this._name = name;
        this._graph = graph;
        this._collection = db.collection(name);
    }
    /**
     * @internal
     *
     * Indicates that this object represents an ArangoDB collection.
     */
    get isArangoCollection() {
        return true;
    }
    /**
     * Name of the collection.
     */
    get name() {
        return this._name;
    }
    /**
     * A {@link DocumentCollection} instance for this vertex collection.
     */
    get collection() {
        return this._collection;
    }
    /**
     * The {@link Graph} instance this vertex collection is bound to.
     */
    get graph() {
        return this._graph;
    }
    /**
     * Checks whether a vertex matching the given key or id exists in this
     * collection.
     *
     * Throws an exception when passed a vertex or `_id` from a different
     * collection.
     *
     * @param selector - Document `_key`, `_id` or object with either of those
     * properties (e.g. a vertex from this collection).
     *
     * @example
     * ```js
     * const graph = db.graph("some-graph");
     * const collection = graph.vertexCollection("vertices");
     * const exists = await collection.vertexExists("abc123");
     * if (!exists) {
     *   console.log("Vertex does not exist");
     * }
     * ```
     */
    async vertexExists(selector) {
        try {
            return await this._db.request({
                method: "HEAD",
                path: `/_api/gharial/${this.graph.name}/vertex/${documents_1._documentHandle(selector, this._name)}`,
            }, () => true);
        }
        catch (err) {
            if (err.code === 404) {
                return false;
            }
            throw err;
        }
    }
    async vertex(selector, options = {}) {
        if (typeof options === "boolean") {
            options = { graceful: options };
        }
        const { allowDirtyRead = undefined, graceful = false, rev, ...qs } = options;
        const headers = {};
        if (rev)
            headers["if-match"] = rev;
        const result = this._db.request({
            path: `/_api/gharial/${this.graph.name}/vertex/${documents_1._documentHandle(selector, this._name)}`,
            headers,
            qs,
            allowDirtyRead,
        }, (res) => res.body.vertex);
        if (!graceful)
            return result;
        try {
            return await result;
        }
        catch (err) {
            if (error_1.isArangoError(err) && err.errorNum === codes_1.DOCUMENT_NOT_FOUND) {
                return null;
            }
            throw err;
        }
    }
    save(data, options) {
        return this._db.request({
            method: "POST",
            path: `/_api/gharial/${this.graph.name}/vertex/${this._name}`,
            body: data,
            qs: options,
        }, (res) => mungeGharialResponse(res.body, "vertex"));
    }
    replace(selector, newValue, options = {}) {
        if (typeof options === "string") {
            options = { rev: options };
        }
        const { rev, ...qs } = options;
        const headers = {};
        if (rev)
            headers["if-match"] = rev;
        return this._db.request({
            method: "PUT",
            path: `/_api/gharial/${this.graph.name}/vertex/${documents_1._documentHandle(selector, this._name)}`,
            body: newValue,
            qs,
            headers,
        }, (res) => mungeGharialResponse(res.body, "vertex"));
    }
    update(selector, newValue, options = {}) {
        if (typeof options === "string") {
            options = { rev: options };
        }
        const headers = {};
        const { rev, ...qs } = options;
        if (rev)
            headers["if-match"] = rev;
        return this._db.request({
            method: "PATCH",
            path: `/_api/gharial/${this.graph.name}/vertex/${documents_1._documentHandle(selector, this._name)}`,
            body: newValue,
            qs,
            headers,
        }, (res) => mungeGharialResponse(res.body, "vertex"));
    }
    remove(selector, options = {}) {
        if (typeof options === "string") {
            options = { rev: options };
        }
        const headers = {};
        const { rev, ...qs } = options;
        if (rev)
            headers["if-match"] = rev;
        return this._db.request({
            method: "DELETE",
            path: `/_api/gharial/${this.graph.name}/vertex/${documents_1._documentHandle(selector, this._name)}`,
            qs,
            headers,
        }, (res) => mungeGharialResponse(res.body, "removed"));
    }
}
exports.GraphVertexCollection = GraphVertexCollection;
/**
 * Represents a {@link EdgeCollection} of edges in a {@link Graph}.
 *
 * @param T - Type to use for document data. Defaults to `any`.
 */
class GraphEdgeCollection {
    /**
     * @internal
     * @hidden
     */
    constructor(db, name, graph) {
        this._db = db;
        this._name = name;
        this._graph = graph;
        this._collection = db.collection(name);
    }
    /**
     * @internal
     *
     * Indicates that this object represents an ArangoDB collection.
     */
    get isArangoCollection() {
        return true;
    }
    /**
     * Name of the collection.
     */
    get name() {
        return this._name;
    }
    /**
     * A {@link EdgeCollection} instance for this edge collection.
     */
    get collection() {
        return this._collection;
    }
    /**
     * The {@link Graph} instance this edge collection is bound to.
     */
    get graph() {
        return this._graph;
    }
    /**
     * Checks whether a edge matching the given key or id exists in this
     * collection.
     *
     * Throws an exception when passed a edge or `_id` from a different
     * collection.
     *
     * @param selector - Document `_key`, `_id` or object with either of those
     * properties (e.g. a edge from this collection).
     *
     * @example
     * ```js
     * const graph = db.graph("some-graph");
     * const collection = graph.edgeCollection("friends")
     * const exists = await collection.edgeExists("abc123");
     * if (!exists) {
     *   console.log("Edge does not exist");
     * }
     * ```
     */
    async edgeExists(selector) {
        try {
            return await this._db.request({
                method: "HEAD",
                path: `/_api/gharial/${this.graph.name}/edge/${documents_1._documentHandle(selector, this._name)}`,
            }, () => true);
        }
        catch (err) {
            if (err.code === 404) {
                return false;
            }
            throw err;
        }
    }
    async edge(selector, options = {}) {
        if (typeof options === "boolean") {
            options = { graceful: options };
        }
        const { allowDirtyRead = undefined, graceful = false, rev, ...qs } = options;
        const headers = {};
        if (rev)
            headers["if-match"] = rev;
        const result = this._db.request({
            path: `/_api/gharial/${this.graph.name}/edge/${documents_1._documentHandle(selector, this._name)}`,
            qs,
            allowDirtyRead,
        }, (res) => res.body.edge);
        if (!graceful)
            return result;
        try {
            return await result;
        }
        catch (err) {
            if (error_1.isArangoError(err) && err.errorNum === codes_1.DOCUMENT_NOT_FOUND) {
                return null;
            }
            throw err;
        }
    }
    save(data, options) {
        return this._db.request({
            method: "POST",
            path: `/_api/gharial/${this.graph.name}/edge/${this._name}`,
            body: data,
            qs: options,
        }, (res) => mungeGharialResponse(res.body, "edge"));
    }
    replace(selector, newValue, options = {}) {
        if (typeof options === "string") {
            options = { rev: options };
        }
        const { rev, ...qs } = options;
        const headers = {};
        if (rev)
            headers["if-match"] = rev;
        return this._db.request({
            method: "PUT",
            path: `/_api/gharial/${this.graph.name}/edge/${documents_1._documentHandle(selector, this._name)}`,
            body: newValue,
            qs,
            headers,
        }, (res) => mungeGharialResponse(res.body, "edge"));
    }
    update(selector, newValue, options = {}) {
        if (typeof options === "string") {
            options = { rev: options };
        }
        const { rev, ...qs } = options;
        const headers = {};
        if (rev)
            headers["if-match"] = rev;
        return this._db.request({
            method: "PATCH",
            path: `/_api/gharial/${this.graph.name}/edge/${documents_1._documentHandle(selector, this._name)}`,
            body: newValue,
            qs,
            headers,
        }, (res) => mungeGharialResponse(res.body, "edge"));
    }
    remove(selector, options = {}) {
        if (typeof options === "string") {
            options = { rev: options };
        }
        const { rev, ...qs } = options;
        const headers = {};
        if (rev)
            headers["if-match"] = rev;
        return this._db.request({
            method: "DELETE",
            path: `/_api/gharial/${this.graph.name}/edge/${documents_1._documentHandle(selector, this._name)}`,
            qs,
            headers,
        }, (res) => mungeGharialResponse(res.body, "removed"));
    }
}
exports.GraphEdgeCollection = GraphEdgeCollection;
/**
 * Represents a graph in a {@link Database}.
 */
class Graph {
    /**
     * @internal
     * @hidden
     */
    constructor(db, name) {
        this._name = name;
        this._db = db;
    }
    /**
     * Name of the graph.
     */
    get name() {
        return this._name;
    }
    /**
     * Checks whether the graph exists.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const result = await graph.exists();
     * // result indicates whether the graph exists
     * ```
     */
    async exists() {
        try {
            await this.get();
            return true;
        }
        catch (err) {
            if (error_1.isArangoError(err) && err.errorNum === codes_1.GRAPH_NOT_FOUND) {
                return false;
            }
            throw err;
        }
    }
    /**
     * Retrieves general information about the graph.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const data = await graph.get();
     * // data contains general information about the graph
     * ```
     */
    get() {
        return this._db.request({ path: `/_api/gharial/${this._name}` }, (res) => res.body.graph);
    }
    /**
     * Creates a graph with the given `edgeDefinitions` and `options` for this
     * graph's name.
     *
     * @param edgeDefinitions - Definitions for the relations of the graph.
     * @param options - Options for creating the graph.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * // graph now exists
     * ```
     */
    create(edgeDefinitions, options) {
        const { orphanCollections, waitForSync, isSmart, isDisjoint, ...opts } = options || {};
        return this._db.request({
            method: "POST",
            path: "/_api/gharial",
            body: {
                orphanCollections: orphanCollections &&
                    (Array.isArray(orphanCollections)
                        ? orphanCollections.map(collection_1.collectionToString)
                        : [collection_1.collectionToString(orphanCollections)]),
                edgeDefinitions: edgeDefinitions.map(coerceEdgeDefinition),
                isSmart,
                isDisjoint,
                name: this._name,
                options: opts,
            },
            qs: { waitForSync },
        }, (res) => res.body.graph);
    }
    /**
     * Deletes the graph from the database.
     *
     * @param dropCollections - If set to `true`, the collections associated with
     * the graph will also be deleted.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * await graph.drop();
     * // the graph "some-graph" no longer exists
     * ```
     */
    drop(dropCollections = false) {
        return this._db.request({
            method: "DELETE",
            path: `/_api/gharial/${this._name}`,
            qs: { dropCollections },
        }, (res) => res.body.removed);
    }
    /**
     * Returns a {@link GraphVertexCollection} instance for the given collection
     * name representing the collection in this graph.
     *
     * @param T - Type to use for document data. Defaults to `any`.
     * @param collection - Name of the vertex collection.
     */
    vertexCollection(collection) {
        if (collection_1.isArangoCollection(collection)) {
            collection = collection.name;
        }
        return new GraphVertexCollection(this._db, collection, this);
    }
    /**
     * Fetches all vertex collections of this graph from the database and returns
     * an array of their names.
     *
     * See also {@link Graph.vertexCollections}.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * const vertexCollectionNames = await graph.listVertexCollections();
     * // ["start-vertices", "end-vertices"]
     * ```
     */
    listVertexCollections() {
        return this._db.request({ path: `/_api/gharial/${this._name}/vertex` }, (res) => res.body.collections);
    }
    /**
     * Fetches all vertex collections of this graph from the database and returns
     * an array of {@link GraphVertexCollection} instances.
     *
     * See also {@link Graph.listVertexCollections}.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * const vertexCollections = await graph.vertexCollections();
     * for (const vertexCollection of vertexCollections) {
     *   console.log(vertexCollection.name);
     *   // "start-vertices"
     *   // "end-vertices"
     * }
     * ```
     */
    async vertexCollections() {
        const names = await this.listVertexCollections();
        return names.map((name) => new GraphVertexCollection(this._db, name, this));
    }
    /**
     * Adds the given collection to this graph as a vertex collection.
     *
     * @param collection - Collection to add to the graph.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * await graph.addVertexCollection("more-vertices");
     * // The collection "more-vertices" has been added to the graph
     * const extra = db.collection("extra-vertices");
     * await graph.addVertexCollection(extra);
     * // The collection "extra-vertices" has been added to the graph
     * ```
     */
    addVertexCollection(collection) {
        if (collection_1.isArangoCollection(collection)) {
            collection = collection.name;
        }
        return this._db.request({
            method: "POST",
            path: `/_api/gharial/${this._name}/vertex`,
            body: { collection },
        }, (res) => res.body.graph);
    }
    /**
     * Removes the given collection from this graph as a vertex collection.
     *
     * @param collection - Collection to remove from the graph.
     * @param dropCollection - If set to `true`, the collection will also be
     * deleted from the database.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * await graph.removeVertexCollection("start-vertices");
     * // The collection "start-vertices" is no longer part of the graph.
     * ```
     */
    removeVertexCollection(collection, dropCollection = false) {
        if (collection_1.isArangoCollection(collection)) {
            collection = collection.name;
        }
        return this._db.request({
            method: "DELETE",
            path: `/_api/gharial/${this._name}/vertex/${collection}`,
            qs: {
                dropCollection,
            },
        }, (res) => res.body.graph);
    }
    /**
     * Returns a {@link GraphEdgeCollection} instance for the given collection
     * name representing the collection in this graph.
     *
     * @param T - Type to use for document data. Defaults to `any`.
     * @param collection - Name of the edge collection.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * const graphEdgeCollection = graph.edgeCollection("edges");
     * // Access the underlying EdgeCollection API:
     * const edgeCollection = graphEdgeCollection.collection;
     * ```
     */
    edgeCollection(collection) {
        if (collection_1.isArangoCollection(collection)) {
            collection = collection.name;
        }
        return new GraphEdgeCollection(this._db, collection, this);
    }
    /**
     * Fetches all edge collections of this graph from the database and returns
     * an array of their names.
     *
     * See also {@link Graph.edgeCollections}.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * const edgeCollectionNames = await graph.listEdgeCollections();
     * // ["edges"]
     * ```
     */
    listEdgeCollections() {
        return this._db.request({ path: `/_api/gharial/${this._name}/edge` }, (res) => res.body.collections);
    }
    /**
     * Fetches all edge collections of this graph from the database and returns
     * an array of {@link GraphEdgeCollection} instances.
     *
     * See also {@link Graph.listEdgeCollections}.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * const graphEdgeCollections = await graph.edgeCollections();
     * for (const collection of graphEdgeCollection) {
     *   console.log(collection.name);
     *   // "edges"
     * }
     * ```
     */
    async edgeCollections() {
        const names = await this.listEdgeCollections();
        return names.map((name) => new GraphEdgeCollection(this._db, name, this));
    }
    /**
     * Adds an edge definition to this graph.
     *
     * @param edgeDefinition - Definition of a relation in this graph.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * await graph.addEdgeDefinition({
     *   collection: "edges",
     *   from: ["start-vertices"],
     *   to: ["end-vertices"],
     * });
     * // The edge definition has been added to the graph
     * ```
     */
    addEdgeDefinition(edgeDefinition) {
        return this._db.request({
            method: "POST",
            path: `/_api/gharial/${this._name}/edge`,
            body: coerceEdgeDefinition(edgeDefinition),
        }, (res) => res.body.graph);
    }
    replaceEdgeDefinition(collection, edgeDefinition) {
        if (!edgeDefinition) {
            edgeDefinition = collection;
            collection = edgeDefinition.collection;
        }
        if (collection_1.isArangoCollection(collection)) {
            collection = collection.name;
        }
        return this._db.request({
            method: "PUT",
            path: `/_api/gharial/${this._name}/edge/${collection}`,
            body: coerceEdgeDefinition(edgeDefinition),
        }, (res) => res.body.graph);
    }
    /**
     * Removes the edge definition for the given edge collection from this graph.
     *
     * @param collection - Edge collection for which to remove the definition.
     * @param dropCollection - If set to `true`, the collection will also be
     * deleted from the database.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("some-graph");
     * const info = await graph.create([
     *   {
     *     collection: "edges",
     *     from: ["start-vertices"],
     *     to: ["end-vertices"],
     *   },
     * ]);
     * await graph.removeEdgeDefinition("edges");
     * // The edge definition for "edges" has been replaced
     * ```
     */
    removeEdgeDefinition(collection, dropCollection = false) {
        if (collection_1.isArangoCollection(collection)) {
            collection = collection.name;
        }
        return this._db.request({
            method: "DELETE",
            path: `/_api/gharial/${this._name}/edge/${collection}`,
            qs: {
                dropCollection,
            },
        }, (res) => res.body.graph);
    }
    /**
     * Performs a traversal starting from the given `startVertex` and following
     * edges contained in this graph.
     *
     * See also {@link EdgeCollection.traversal}.
     *
     * @param startVertex - Document `_id` of a vertex in this graph.
     * @param options - Options for performing the traversal.
     *
     * @deprecated Simple Queries have been deprecated in ArangoDB 3.4 and can be
     * replaced with AQL queries.
     *
     * @example
     * ```js
     * const db = new Database();
     * const graph = db.graph("my-graph");
     * const collection = graph.edgeCollection("edges").collection;
     * await collection.import([
     *   ["_key", "_from", "_to"],
     *   ["x", "vertices/a", "vertices/b"],
     *   ["y", "vertices/b", "vertices/c"],
     *   ["z", "vertices/c", "vertices/d"],
     * ]);
     * const result = await graph.traversal("vertices/a", {
     *   direction: "outbound",
     *   init: "result.vertices = [];",
     *   visitor: "result.vertices.push(vertex._key);",
     * });
     * console.log(result.vertices); // ["a", "b", "c", "d"]
     * ```
     */
    traversal(startVertex, options) {
        return this._db.request({
            method: "POST",
            path: `/_api/traversal`,
            body: {
                ...options,
                startVertex,
                graphName: this._name,
            },
        }, (res) => res.body.result);
    }
}
exports.Graph = Graph;
//# sourceMappingURL=graph.js.map