# JmespathFree SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module JmespathFreeFeatures
  def self.make_feature(name)
    case name
    when "base"
      JmespathFreeBaseFeature.new
    when "ratelimit"
      JmespathFreeRatelimitFeature.new
    when "retry"
      JmespathFreeRetryFeature.new
    when "test"
      JmespathFreeTestFeature.new
    when "timeout"
      JmespathFreeTimeoutFeature.new
    else
      JmespathFreeBaseFeature.new
    end
  end
end
