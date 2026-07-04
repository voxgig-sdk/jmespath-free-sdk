-- ProjectName SDK configuration

local function make_config()
  return {
    main = {
      name = "JmespathFree",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
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
            ["active"] = true,
            ["name"] = "data",
            ["req"] = true,
            ["type"] = "`$ANY`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "query",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 1,
          },
        },
        ["name"] = "jmes_path",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
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
                ["index$"] = 0,
              },
            },
            ["key$"] = "create",
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
