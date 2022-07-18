"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.arangojs = void 0;
const database_1 = require("./database");
module.exports = exports = arangojs;
function arangojs(config, name) {
    if (typeof config === "string" || Array.isArray(config)) {
        const url = config;
        return new database_1.Database(url, name);
    }
    return new database_1.Database(config);
}
exports.arangojs = arangojs;
exports.default = arangojs;
var aql_1 = require("./aql");
Object.defineProperty(exports, "aql", { enumerable: true, get: function () { return aql_1.aql; } });
var collection_1 = require("./collection");
Object.defineProperty(exports, "CollectionStatus", { enumerable: true, get: function () { return collection_1.CollectionStatus; } });
Object.defineProperty(exports, "CollectionType", { enumerable: true, get: function () { return collection_1.CollectionType; } });
var database_2 = require("./database");
Object.defineProperty(exports, "Database", { enumerable: true, get: function () { return database_2.Database; } });
var view_1 = require("./view");
Object.defineProperty(exports, "ViewType", { enumerable: true, get: function () { return view_1.ViewType; } });
//# sourceMappingURL=index.js.map