package voxgigjmespathfreesdk

import (
	"github.com/voxgig-sdk/jmespath-free-sdk/core"
	"github.com/voxgig-sdk/jmespath-free-sdk/entity"
	"github.com/voxgig-sdk/jmespath-free-sdk/feature"
	_ "github.com/voxgig-sdk/jmespath-free-sdk/utility"
)

// Type aliases preserve external API.
type JmespathFreeSDK = core.JmespathFreeSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type JmespathFreeEntity = core.JmespathFreeEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type JmespathFreeError = core.JmespathFreeError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewJmesPathEntityFunc = func(client *core.JmespathFreeSDK, entopts map[string]any) core.JmespathFreeEntity {
		return entity.NewJmesPathEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewJmespathFreeSDK = core.NewJmespathFreeSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
