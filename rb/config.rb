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
              "active" => true,
              "name" => "data",
              "req" => true,
              "type" => "`$ANY`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "query",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 1,
            },
          ],
          "name" => "jmes_path",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "active" => true,
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/jmespath",
                  "parts" => [
                    "jmespath",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
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
