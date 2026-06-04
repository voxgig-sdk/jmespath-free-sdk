# JmespathFree SDK

Run JMESPath queries against arbitrary JSON over a serverless HTTP endpoint

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About JMESPath Free API

[JMESPath Free API](https://freepublicapis.com/jmespath-free-api) is a serverless endpoint that runs [JMESPath](https://jmespath.org) queries against arbitrary JSON payloads. It is hosted on Vercel and operated by [Note API Connector](https://noteapiconnector.com), where JMESPath transformations are also offered as part of their wider Notion integration tooling.

What you get from the API:

- A single `POST /jmespath` endpoint that accepts a JSON body containing `data` (the JSON to query) and `query` (the JMESPath expression).
- The result of evaluating the JMESPath expression against the supplied data, returned as JSON.
- A way to filter, reshape, and extract values from JSON without standing up your own JMESPath runtime.

The service is intended for prototyping and low-volume automation rather than heavy production traffic. CORS is enabled, and the public catalogue listing does not mention authentication keys or hard rate limits.

## Try it

**TypeScript**
```bash
npm install jmespath-free
```

**Python**
```bash
pip install jmespath-free-sdk
```

**PHP**
```bash
composer require voxgig/jmespath-free-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/jmespath-free-sdk/go
```

**Ruby**
```bash
gem install jmespath-free-sdk
```

**Lua**
```bash
luarocks install jmespath-free-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { JmespathFreeSDK } from 'jmespath-free'

const client = new JmespathFreeSDK({})

```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o jmespath-free-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "jmespath-free": {
      "command": "/abs/path/to/jmespath-free-mcp"
    }
  }
}
```

## Entities

The API exposes one entity:

| Entity | Description | API path |
| --- | --- | --- |
| **JmesPath** | Evaluation of a JMESPath expression against a supplied JSON document via `POST /jmespath` with `data` and `query` fields in the JSON body. | `/jmespath` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from jmespathfree_sdk import JmespathFreeSDK

client = JmespathFreeSDK({})

```

### PHP

```php
<?php
require_once 'jmespathfree_sdk.php';

$client = new JmespathFreeSDK([]);

```

### Golang

```go
import sdk "github.com/voxgig-sdk/jmespath-free-sdk/go"

client := sdk.NewJmespathFreeSDK(map[string]any{})

```

### Ruby

```ruby
require_relative "JmespathFree_sdk"

client = JmespathFreeSDK.new({})

```

### Lua

```lua
local sdk = require("jmespath-free_sdk")

local client = sdk.new({})

```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = JmespathFreeSDK.test()
const result = await client.JmesPath().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = JmespathFreeSDK.test(None, None)
result, err = client.JmesPath(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = JmespathFreeSDK::test(null, null);
[$result, $err] = $client->JmesPath(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.JmesPath(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = JmespathFreeSDK.test(nil, nil)
result, err = client.JmesPath(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:JmesPath(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the JMESPath Free API

- Upstream: [https://noteapiconnector.com](https://noteapiconnector.com)
- API docs: [https://freepublicapis.com/jmespath-free-api](https://freepublicapis.com/jmespath-free-api)

---

Generated from the JMESPath Free API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
