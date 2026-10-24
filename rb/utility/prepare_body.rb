# JmespathFree SDK utility: prepare_body
require_relative 'media'
module JmespathFreeUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return JmespathFreeUtilities.raw_body(ctx.reqdata) if JmespathFreeUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
