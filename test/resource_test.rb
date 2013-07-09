require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'

class ResourceTest < MiniTest::Unit::TestCase
  class TestAPI
    extend DiscourseApi::Resource

    resource :foo do |r|
      r.post :bar, :require => [:baz]
    end
  end

  def test_method_exists
    assert_true(TestAPI.new.respond_to?(:foo))
  end
end
