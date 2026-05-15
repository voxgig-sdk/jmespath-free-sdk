# JmespathFree SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

JmespathFreeUtility.registrar = ->(u) {
  u.clean = JmespathFreeUtilities::Clean
  u.done = JmespathFreeUtilities::Done
  u.make_error = JmespathFreeUtilities::MakeError
  u.feature_add = JmespathFreeUtilities::FeatureAdd
  u.feature_hook = JmespathFreeUtilities::FeatureHook
  u.feature_init = JmespathFreeUtilities::FeatureInit
  u.fetcher = JmespathFreeUtilities::Fetcher
  u.make_fetch_def = JmespathFreeUtilities::MakeFetchDef
  u.make_context = JmespathFreeUtilities::MakeContext
  u.make_options = JmespathFreeUtilities::MakeOptions
  u.make_request = JmespathFreeUtilities::MakeRequest
  u.make_response = JmespathFreeUtilities::MakeResponse
  u.make_result = JmespathFreeUtilities::MakeResult
  u.make_point = JmespathFreeUtilities::MakePoint
  u.make_spec = JmespathFreeUtilities::MakeSpec
  u.make_url = JmespathFreeUtilities::MakeUrl
  u.param = JmespathFreeUtilities::Param
  u.prepare_auth = JmespathFreeUtilities::PrepareAuth
  u.prepare_body = JmespathFreeUtilities::PrepareBody
  u.prepare_headers = JmespathFreeUtilities::PrepareHeaders
  u.prepare_method = JmespathFreeUtilities::PrepareMethod
  u.prepare_params = JmespathFreeUtilities::PrepareParams
  u.prepare_path = JmespathFreeUtilities::PreparePath
  u.prepare_query = JmespathFreeUtilities::PrepareQuery
  u.result_basic = JmespathFreeUtilities::ResultBasic
  u.result_body = JmespathFreeUtilities::ResultBody
  u.result_headers = JmespathFreeUtilities::ResultHeaders
  u.transform_request = JmespathFreeUtilities::TransformRequest
  u.transform_response = JmespathFreeUtilities::TransformResponse
}
