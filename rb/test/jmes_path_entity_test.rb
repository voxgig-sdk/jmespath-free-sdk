# JmesPath entity test

require "minitest/autorun"
require "json"
require_relative "../JmespathFree_sdk"
require_relative "runner"

class JmesPathEntityTest < Minitest::Test
  # main.kit.test.live.strict is true (the default is true): a live
  # request that fails, or a live test missing an input it needs,
  # fails the test.
  # An account with no record for a test to read skips it either way.
  LIVE_STRICT = true

  def test_create_instance
    testsdk = JmespathFreeSDK.test(nil, nil)
    ent = testsdk.JmesPath(nil)
    assert !ent.nil?
  end

  def test_validate
    cfg = JmespathFreeConfig.shared_config
    unless cfg["feature"].is_a?(Hash) && cfg["feature"].key?("validate")
      skip("feature not present in this SDK: validate")
    end
    client = JmespathFreeSDK.test(nil, { "feature" => { "validate" => { "active" => true } } })
    err = assert_raises(StandardError) do
      client.JmesPath(nil).create({ "data" => "x", "query" => 1 }, nil)
    end
    assert_equal "validate_failed", err.code
  end

  def test_basic_flow
    setup = jmes_path_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "jmes_path." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    client = setup[:client]

    # CREATE
    jmes_path_ref01_ent = client.JmesPath(nil)
    jmes_path_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.jmes_path"), "jmes_path_ref01"))

    jmes_path_ref01_data_result = jmes_path_ref01_ent.create(jmes_path_ref01_data, nil)
    jmes_path_ref01_data = Helpers.to_map(jmes_path_ref01_data_result.respond_to?(:data_get) ? jmes_path_ref01_data_result.data_get : jmes_path_ref01_data_result)
    assert !jmes_path_ref01_data.nil?

  end
end

def jmes_path_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "jmes_path", "JmesPathTestData.json")
  entity_data_source = File.read(entity_data_file, encoding: "UTF-8")
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = JmespathFreeSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["jmes_path01", "jmes_path02", "jmes_path03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Whether *_ENTID supplied the idmap, read before env_override consumes
  # it: without it, the ids a live flow binds are the fixture's synthetic ones.
  entid_env_raw = ENV["JMESPATH_FREE_TEST_JMES_PATH_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "JMESPATH_FREE_TEST_JMES_PATH_ENTID" => idmap,
    "JMESPATH_FREE_TEST_LIVE" => "FALSE",
    "JMESPATH_FREE_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["JMESPATH_FREE_TEST_JMES_PATH_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["JMESPATH_FREE_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      Runner.live_client_options,
      {
      },
      extra || {},
    ])
    client = JmespathFreeSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["JMESPATH_FREE_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["JMESPATH_FREE_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
