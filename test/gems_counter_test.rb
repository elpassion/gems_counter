require "test_helper"
require "set"
require 'fileutils'

class GemsCounterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GemsCounter::VERSION
  end


  def test_when_folder_is_empty_returns_empty_list
    Dir.mktmpdir do |dir|
      assert Counter.new(dir).count == []
    end
  end

  # def test_when_folder_contains_gemfile_it_counts_single_gem
  #   Dir.mktmpdir do |dir|
  #     FileUtils.mv("./fixtures/Gemfile1", "#{dir}/Gemfile")
  #     File.open("#{dir}/Gemfile", 'r')
  #     # File.open("#{dir}/Gemfile", "w") {|file| file.write "gem 'rails'"}
  #     assert_equal [{ name: 'rails'}], Counter.new(dir).count
  #   end
  # end

  def test_when_folder_contains_gemfile_it_counts_multiple_gems
    Dir.mktmpdir do |dir|
      File.open("#{dir}/Gemfile", "w") {|file| file.write "gem 'rails'\ngem 'rspec'"}
      assert_equal [{ name: 'rails'}, { name: 'rspec' }], Counter.new(dir).count
    end
  end

  def test_when_folder_contains_gemfile_it_counts_the_same_gem_as_one
    Dir.mktmpdir do |dir|
      File.open("#{dir}/Gemfile", "w") {|file| file.write "gem 'rails'\ngem 'rails'"}
      assert_equal [{ name: 'rails'}], Counter.new(dir).count
    end
  end
end

class InvalidPathError < StandardError; end

class Counter
  def initialize path
    @path = path
  end

  def count
    counter = Set[]

    Object.send(:define_method, "gem") do |name|
      counter << {name: name}
    end

    Dir.entries(@path).select {|file| File.file? file }.each do |file|
      load("#{@path}/#{file}")
    end

    counter.to_a
  end
end
