# JmespathFree SDK exists test

require "minitest/autorun"
require_relative "../JmespathFree_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = JmespathFreeSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
