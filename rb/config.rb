# JmespathFree SDK configuration

module JmespathFreeConfig
  def self.make_config
    {
      "main" => {
        "name" => "JmespathFree",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://noteapiconnector-tools.vercel.app/api",
        "auth" => {
          "prefix" => "Bearer",
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "jmes_path" => {},
        },
      },
      "entity" => {
        "jmes_path" => {
          "fields" => [
            {
              "name" => "data",
              "req" => true,
              "type" => "`$ANY`",
              "active" => true,
              "index$" => 0,
            },
            {
              "name" => "query",
              "req" => true,
              "type" => "`$STRING`",
              "active" => true,
              "index$" => 1,
            },
          ],
          "name" => "jmes_path",
          "op" => {
            "create" => {
              "name" => "create",
              "points" => [
                {
                  "method" => "POST",
                  "orig" => "/jmespath",
                  "parts" => [
                    "jmespath",
                  ],
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "active" => true,
                  "args" => {},
                  "select" => {},
                  "index$" => 0,
                },
              ],
              "input" => "data",
              "key$" => "create",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    JmespathFreeFeatures.make_feature(name)
  end
end
