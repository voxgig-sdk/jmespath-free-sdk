# JmespathFree SDK utility: feature_add
module JmespathFreeUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
