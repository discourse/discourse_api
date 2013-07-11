require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'

class ParsedPathTest < Minitest::Test

  def test_generates_correct_path
    path = DiscourseApi::ParsedPath.new('/:hello/:world/1', {})

    assert_equal(["/hello/world/1",{}],path.generate(:hello => "hello", :world => "world"))
  end

  def test_generates_correct_path_for_non_string
    path = DiscourseApi::ParsedPath.new('/:hello', {})

    assert_equal(["/1",{}],path.generate(:hello => 1))
  end

  def test_maintains_params
    path = DiscourseApi::ParsedPath.new('/hello/world/1', {})

    assert_equal(["/hello/world/1", {:a => 1, :b => 2}], path.generate(:a => 1, :b => 2))
  end

  def test_assumes_path_required
    path = DiscourseApi::ParsedPath.new('/:hello', {})

    begin
      path.validate!({})
    rescue ArgumentError => e
      assert_equal("Missing: hello", e.message)
    end
  end

  def test_required_param
    path = DiscourseApi::ParsedPath.new('/', {:required => [:a, :b]})

    begin
      path.validate!({})
    rescue ArgumentError => e
      assert_equal("Missing: a,b", e.message)
    end
  end

end
