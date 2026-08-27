-- JmespathFree SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "JmespathFree",
      slug = "jmespath-free",
      version = "0.0.1",
      target = "lua",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
        ["transport"] = "base",
      },
    },
    options = {
      base = "https://noteapiconnector-tools.vercel.app/api",
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["jmes_path"] = {},
      },
    },
    entity = {
      ["jmes_path"] = {
        ["fields"] = {
          {
            ["name"] = "data",
            ["req"] = true,
            ["short"] = "The JSON object or array to transform",
            ["type"] = "`$ANY`",
            ["union"] = {
              ["branches"] = 2,
              ["count"] = 1,
              ["depth"] = 0,
            },
          },
          {
            ["name"] = "query",
            ["req"] = true,
            ["short"] = "The JMESPath expression string to evaluate against the data",
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "jmes_path",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/jmespath",
                ["parts"] = {
                  "jmespath",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
