# JmespathFree SDK configuration

module JmespathFreeConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "JmespathFree",
        "slug" => "jmespath-free",
        "version" => "0.0.1",
        "target" => "rb",
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
              "name" => "data",
              "req" => true,
              "short" => "The JSON object or array to transform",
              "type" => "`$ANY`",
              "union" => {
                "branches" => 2,
                "count" => 1,
                "depth" => 0,
              },
            },
            {
              "name" => "query",
              "req" => true,
              "short" => "The JMESPath expression string to evaluate against the data",
              "type" => "`$STRING`",
            },
          ],
          "name" => "jmes_path",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
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
                },
              ],
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
