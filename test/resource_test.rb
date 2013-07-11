require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'

class ResourceTest < Minitest::Test
  class TestClient < DiscourseApi::Resource
    post :test => "/hello/:world", :require => [:foo]
  end

  def test_method_exists
    assert_respond_to(TestClient.new, :test)
  end

  def test_api_args
    client = TestClient.new
    client.api_key = "XXX"
    client.api_username = "BOB"
    assert_equal({:api_key => "XXX", :api_username => "BOB", :a => 1}, client.api_args({:a => 1}))
  end

end
