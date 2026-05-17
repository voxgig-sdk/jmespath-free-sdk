package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/jmespath-free-sdk/go"
	"github.com/voxgig-sdk/jmespath-free-sdk/go/core"

	vs "github.com/voxgig-sdk/jmespath-free-sdk/go/utility/struct"
)

func TestJmesPathEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.JmesPath(nil)
		if ent == nil {
			t.Fatal("expected non-nil JmesPathEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := jmes_pathBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "jmes_path." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set JMESPATHFREE_TEST_JMES_PATH_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		jmesPathRef01Ent := client.JmesPath(nil)
		jmesPathRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "jmes_path"}, setup.data), "jmes_path_ref01"))

		jmesPathRef01DataResult, err := jmesPathRef01Ent.Create(jmesPathRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		jmesPathRef01Data = core.ToMapAny(jmesPathRef01DataResult)
		if jmesPathRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

	})
}

func jmes_pathBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "jmes_path", "JmesPathTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read jmes_path test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse jmes_path test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"jmes_path01", "jmes_path02", "jmes_path03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("JMESPATHFREE_TEST_JMES_PATH_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"JMESPATHFREE_TEST_JMES_PATH_ENTID": idmap,
		"JMESPATHFREE_TEST_LIVE":      "FALSE",
		"JMESPATHFREE_TEST_EXPLAIN":   "FALSE",
		"JMESPATHFREE_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["JMESPATHFREE_TEST_JMES_PATH_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["JMESPATHFREE_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["JMESPATHFREE_APIKEY"],
			},
			extra,
		})
		client = sdk.NewJmespathFreeSDK(core.ToMapAny(mergedOpts))
	}

	live := env["JMESPATHFREE_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["JMESPATHFREE_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
