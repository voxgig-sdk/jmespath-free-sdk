# JmespathFree SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module JmespathFreeFeatures
  def self.make_feature(name)
    case name
    when "base"
      JmespathFreeBaseFeature.new
    when "test"
      JmespathFreeTestFeature.new
    else
      JmespathFreeBaseFeature.new
    end
  end
end
