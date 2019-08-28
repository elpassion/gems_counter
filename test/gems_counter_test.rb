require "test_helper"

class GemsCounterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GemsCounter::VERSION
  end


  def test_when_folder_is_empty_returns_empty_list
    Dir.mktmpdir do |dir|
      assert Counter.new(dir).count == []
    end
  end
end

class InvalidPathError < StandardError; end

class Counter
  def initialize dir
  end

  def count
    []
  end
end
