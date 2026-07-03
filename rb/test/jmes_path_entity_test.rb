# JmesPath entity test

require "minitest/autorun"
require "json"
require_relative "../JmespathFree_sdk"
require_relative "runner"

class JmesPathEntityTest < Minitest::Test
  def test_create_instance
    testsdk = JmespathFreeSDK.test(nil, nil)
    ent = testsdk.JmesPath(nil)
    assert !ent.nil?
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
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set JMESPATHFREE_TEST_JMES_PATH_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    jmes_path_ref01_ent = client.JmesPath(nil)
    jmes_path_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.jmes_path"), "jmes_path_ref01"))

    jmes_path_ref01_data_result, err = jmes_path_ref01_ent.create(jmes_path_ref01_data, nil)
    assert_nil err
    jmes_path_ref01_data = Helpers.to_map(jmes_path_ref01_data_result)
    assert !jmes_path_ref01_data.nil?

  end
end

def jmes_path_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "jmes_path", "JmesPathTestData.json")
  entity_data_source = File.read(entity_data_file)
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

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["JMESPATHFREE_TEST_JMES_PATH_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "JMESPATHFREE_TEST_JMES_PATH_ENTID" => idmap,
    "JMESPATHFREE_TEST_LIVE" => "FALSE",
    "JMESPATHFREE_TEST_EXPLAIN" => "FALSE",
    "JMESPATHFREE_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["JMESPATHFREE_TEST_JMES_PATH_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["JMESPATHFREE_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["JMESPATHFREE_APIKEY"],
      },
      extra || {},
    ])
    client = JmespathFreeSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["JMESPATHFREE_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["JMESPATHFREE_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
