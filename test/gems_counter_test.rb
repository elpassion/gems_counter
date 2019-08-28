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

  def test_when_folder_contains_gemfile_it_counts_gems
    Dir.mktmpdir do |dir|
      File.open("#{dir}/Gemfile", "w") {|file| file.write "gem 'rails'"}
      assert_equal [{ name: 'rails', count: 1 }], Counter.new(dir).count
    end
  end
end

class InvalidPathError < StandardError; end

class Counter
  def initialize path
    @path = path
  end

  def count
    counter = []

    Object.send(:define_method, "gem") do |name|
      counter = [{name: name, count: 1}]
    end

    Dir.entries(@path).select {|file| File.file? file }.each do |file|
      load("#{@path}/#{file}")
    end

    counter
  end
end
