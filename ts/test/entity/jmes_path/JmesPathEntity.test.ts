

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { JmespathFreeSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


loadEnvLocal(__dirname + '/../../../.env.local')


describe('JmesPathEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when JMESPATH_FREE_TEST_LIVE=TRUE.
  afterEach(liveDelay('JMESPATH_FREE_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = JmespathFreeSDK.test()
    const ent = testsdk.JmesPath()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.JMESPATH_FREE_TEST_LIVE
    for (const op of ['create']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'jmes_path.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"data":{"a":true,"h":"Data","n":"data","r":true,"sh":"The JSON object or array to transform","t":"`$ANY`","union":{"branches":2,"count":1,"depth":0},"key$":"data","index$":0},"query":{"a":true,"h":"Query","n":"query","r":true,"sh":"The JMESPath expression string to evaluate against the data","t":"`$STRING`","key$":"query","index$":1}},"name":"jmes_path","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /jmespath","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/jmespath","q":{},"r":{},"s":[{"lit":"jmespath"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"jmes_path","name__orig":"jmes_path","Name":"JmesPath","name_":"jmes_path","name-":"jmes-path","NAME":"JMES_PATH","index$":0}, {"active":true,"entity":"jmes_path","key$":"BasicJmesPathFlow","kind":"basic","name":"BasicJmesPathFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"jmes_path_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0}]}, 'JmesPath', {"POST /jmespath":{"protocol":"http","operationId":"transformJson","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","required":["data","query"],"properties":{"data":{"oneOf":[{"type":"object"},{"type":"array"}],"description":"The JSON object or array to transform","key$":"data"},"query":{"type":"string","description":"The JMESPath expression string to evaluate against the data","example":"people[?age>`25`].name","key$":"query"}},"index$":1},"examples":{"filterPeople":{"summary":"Filter people by age","value":{"data":{"people":[{"name":"Ana","age":30},{"name":"Bob","age":20}]},"query":"people[?age>`25`].name"}},"filterTasks":{"summary":"Filter unfinished tasks","value":{"data":{"tasks":[{"title":"Draft docs","completed":false,"priority":2},{"title":"Send invoice","completed":true,"priority":1},{"title":"Plan launch","completed":false,"priority":3}]},"query":"tasks[?completed==`false`].title"}},"projectNestedFields":{"summary":"Project nested contact fields","value":{"data":{"customers":[{"name":"Asha Patel","contact":{"email":"asha@example.com","city":"Austin"}},{"name":"Lee Wong","contact":{"email":"lee@example.com","city":"Seattle"}}]},"query":"customers[].{name: name, email: contact.email}"}},"sortAndLimit":{"summary":"Sort by rating and get top results","value":{"data":{"products":[{"name":"Starter","rating":4.2},{"name":"Pro","rating":4.8},{"name":"Enterprise","rating":4.6}]},"query":"reverse(sort_by(products, &rating))[:2].name"}}}}}},"responses":{"200":{"description":"Successfully transformed JSON data","content":{"application/json":{"schema":{"oneOf":[{"type":"object"},{"type":"array"},{"type":"string"},{"type":"number"},{"type":"boolean"},{"type":"null"}],"description":"The result of evaluating the JMESPath query against the provided data","index$":0},"examples":{"arrayResult":{"summary":"Array of filtered names","value":["Ana"]},"objectArrayResult":{"summary":"Array of projected objects","value":[{"name":"Asha Patel","email":"asha@example.com"},{"name":"Lee Wong","email":"lee@example.com"}]}}}}},"400":{"description":"Invalid JMESPath query or malformed request","content":{"application/json":{"schema":{"type":"object","properties":{"error":{"type":"string","description":"Descriptive error message explaining what went wrong with the query"}}},"examples":{"invalidQuery":{"summary":"Invalid JMESPath expression","value":{"error":"RuntimeError: Invalid token: Parse error at column 11..."}}}}}},"500":{"description":"Internal server error","content":{"application/json":{"schema":{"type":"object","properties":{"error":{"type":"string","description":"Error message describing the server error"}}}}}}},"parameters":[],"securitySource":"unspecified"}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const jmes_path_ref01_ent = client.JmesPath()
    let jmes_path_ref01_data = setup.data.new.jmes_path['jmes_path_ref01']

    jmes_path_ref01_data = (await jmes_path_ref01_ent.create(jmes_path_ref01_data)).data()
    assert(null != jmes_path_ref01_data)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/jmes_path/JmesPathTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = JmespathFreeSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['jmes_path01','jmes_path02','jmes_path03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'JMESPATH_FREE_TEST_JMES_PATH_ENTID': idmap,
    'JMESPATH_FREE_TEST_LIVE': 'FALSE',
    'JMESPATH_FREE_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['JMESPATH_FREE_TEST_JMES_PATH_ENTID']

  const live = 'TRUE' === env.JMESPATH_FREE_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['JMESPATH_FREE_TEST_JMES_PATH_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new JmespathFreeSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
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
  }

  return setup
}
  
