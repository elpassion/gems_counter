require "test_helper"

class GemsCounterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GemsCounter::VERSION
  end

  def test_fails_when_folder_does_not_exist
    assert_raises InvalidPathError do
      Counter.new("invalid_path")
    end
  end
end

class InvalidPathError < StandardError; end

class Counter
  def initialize path
    raise InvalidPathError
  end
end
