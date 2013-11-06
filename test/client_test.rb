require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'

class ClientTest < Minitest::Test

  def test_client_requires_host_argument
    assert_raises(ArgumentError) { DiscourseApi::Client.new }
  end

  def test_client_port_default_is_80
    client = DiscourseApi::Client.new('http://localhost')
    assert_equal(80, client.port)
  end

  def test_client_accepts_port_argument
    client = DiscourseApi::Client.new('http://localhost',3000)
    assert_equal(3000, client.port)
  end

  def test_client_responds_to_invite_user_to_topic
    client = DiscourseApi::Client.new('http://localhost')
    assert_respond_to(client, :invite_user_to_topic)
  end

  def test_client_responds_to_latest_topics
    client = DiscourseApi::Client.new('http://localhost')
    assert_respond_to(client, :latest_topics)
  end

  def test_client_responds_to_hot_topics
    client = DiscourseApi::Client.new('http://localhost')
    assert_respond_to(client, :hot_topics)
  end

  def test_client_responds_to_categories
    client = DiscourseApi::Client.new('http://localhost')
    assert_respond_to(client, :categories)
  end

end
