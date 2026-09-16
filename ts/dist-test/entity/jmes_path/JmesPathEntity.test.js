"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('JmesPathEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when JMESPATH_FREE_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('JMESPATH_FREE_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.JmespathFreeSDK.test();
        const ent = testsdk.JmesPath();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.JMESPATH_FREE_TEST_LIVE;
        for (const op of ['create']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'jmes_path.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": [{ "active": true, "name": "data", "req": true, "short": "The JSON object or array to transform", "type": "`$ANY`", "union": { "branches": 2, "count": 1, "depth": 0 }, "index$": 0 }, { "active": true, "name": "query", "req": true, "short": "The JMESPath expression string to evaluate against the data", "type": "`$STRING`", "index$": 1 }], "name": "jmes_path", "op": { "create": { "input": "data", "name": "create", "points": [{ "active": true, "args": {}, "contract": { "id": "POST /jmespath", "json": "{\"operationId\":\"transformJson\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"examples\":{\"filterPeople\":{\"summary\":\"Filter people by age\",\"value\":{\"data\":{\"people\":[{\"age\":30,\"name\":\"Ana\"},{\"age\":20,\"name\":\"Bob\"}]},\"query\":\"people[?age>`25`].name\"}},\"filterTasks\":{\"summary\":\"Filter unfinished tasks\",\"value\":{\"data\":{\"tasks\":[{\"completed\":false,\"priority\":2,\"title\":\"Draft docs\"},{\"completed\":true,\"priority\":1,\"title\":\"Send invoice\"},{\"completed\":false,\"priority\":3,\"title\":\"Plan launch\"}]},\"query\":\"tasks[?completed==`false`].title\"}},\"projectNestedFields\":{\"summary\":\"Project nested contact fields\",\"value\":{\"data\":{\"customers\":[{\"contact\":{\"city\":\"Austin\",\"email\":\"asha@example.com\"},\"name\":\"Asha Patel\"},{\"contact\":{\"city\":\"Seattle\",\"email\":\"lee@example.com\"},\"name\":\"Lee Wong\"}]},\"query\":\"customers[].{name: name, email: contact.email}\"}},\"sortAndLimit\":{\"summary\":\"Sort by rating and get top results\",\"value\":{\"data\":{\"products\":[{\"name\":\"Starter\",\"rating\":4.2},{\"name\":\"Pro\",\"rating\":4.8},{\"name\":\"Enterprise\",\"rating\":4.6}]},\"query\":\"reverse(sort_by(products, &rating))[:2].name\"}}},\"schema\":{\"properties\":{\"data\":{\"description\":\"The JSON object or array to transform\",\"oneOf\":[{\"type\":\"object\"},{\"type\":\"array\"}]},\"query\":{\"description\":\"The JMESPath expression string to evaluate against the data\",\"example\":\"people[?age>`25`].name\",\"type\":\"string\"}},\"required\":[\"data\",\"query\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"examples\":{\"arrayResult\":{\"summary\":\"Array of filtered names\",\"value\":[\"Ana\"]},\"objectArrayResult\":{\"summary\":\"Array of projected objects\",\"value\":[{\"email\":\"asha@example.com\",\"name\":\"Asha Patel\"},{\"email\":\"lee@example.com\",\"name\":\"Lee Wong\"}]}},\"schema\":{\"description\":\"The result of evaluating the JMESPath query against the provided data\",\"oneOf\":[{\"type\":\"object\"},{\"type\":\"array\"},{\"type\":\"string\"},{\"type\":\"number\"},{\"type\":\"boolean\"},{\"type\":\"null\"}]}}},\"description\":\"Successfully transformed JSON data\"},\"400\":{\"content\":{\"application/json\":{\"examples\":{\"invalidQuery\":{\"summary\":\"Invalid JMESPath expression\",\"value\":{\"error\":\"RuntimeError: Invalid token: Parse error at column 11...\"}}},\"schema\":{\"properties\":{\"error\":{\"description\":\"Descriptive error message explaining what went wrong with the query\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Invalid JMESPath query or malformed request\"},\"500\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message describing the server error\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error\"}},\"securitySource\":\"unspecified\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "POST", "orig": "/jmespath", "segments": [{ "lit": "jmespath" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "create" } }, "relations": { "ancestors": [] }, "key$": "jmes_path", "name__orig": "jmes_path", "Name": "JmesPath", "name_": "jmes_path", "name-": "jmes-path", "NAME": "JMES_PATH", "index$": 0 }, { "active": true, "entity": "jmes_path", "key$": "BasicJmesPathFlow", "kind": "basic", "name": "BasicJmesPathFlow", "param": {}, "step": [{ "active": true, "data": {}, "input": { "ref": "jmes_path_ref01" }, "match": {}, "op": "create", "spec": [], "valid": [], "index$": 0 }] }, 'JmesPath');
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const jmes_path_ref01_ent = client.JmesPath();
        let jmes_path_ref01_data = setup.data.new.jmes_path['jmes_path_ref01'];
        jmes_path_ref01_data = (await jmes_path_ref01_ent.create(jmes_path_ref01_data)).data();
        (0, node_assert_1.default)(null != jmes_path_ref01_data);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/jmes_path/JmesPathTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.JmespathFreeSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['jmes_path01', 'jmes_path02', 'jmes_path03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'JMESPATH_FREE_TEST_JMES_PATH_ENTID': idmap,
        'JMESPATH_FREE_TEST_LIVE': 'FALSE',
        'JMESPATH_FREE_TEST_EXPLAIN': 'FALSE',
    });
    idmap = env['JMESPATH_FREE_TEST_JMES_PATH_ENTID'];
    const live = 'TRUE' === env.JMESPATH_FREE_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['JMESPATH_FREE_TEST_JMES_PATH_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.JmespathFreeSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
            {},
            // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
            // last entry is undefined, and basicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK undefined. Harmless
            // while there was nothing in that object; not harmless now.
            extra || {},
            { system: { fetch: transport.fetch } }
        ]));
    }
    const setup = {
        idmap,
        env,
        options,
        client,
        struct,
        data: entityData,
        explain: 'TRUE' === env.JMESPATH_FREE_TEST_EXPLAIN,
        live,
        transport,
        now: Date.now(),
    };
    return setup;
}
//# sourceMappingURL=JmesPathEntity.test.js.map