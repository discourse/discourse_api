require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'

class ClientTest < Minitest::Test

  def test_client_requires_host_argument
    assert_raises(ArgumentError) { DiscourseApi::Client.new }
  end

  def test_client_port_default_is_80
    client = DiscourseApi::Client.new('localhost')
    assert_equal(80, client.port)
  end

  def test_client_accepts_port_argument
    client = DiscourseApi::Client.new('localhost',3000)
    assert_equal(3000, client.port)
  end

end
