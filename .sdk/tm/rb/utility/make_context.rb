# JmespathFree SDK utility: make_context
require_relative '../core/context'
module JmespathFreeUtilities
  MakeContext = ->(ctxmap, basectx) {
    JmespathFreeContext.new(ctxmap, basectx)
  }
end
