# require "gems_counter/version"

module GemsCounter
  class Error < StandardError; end

  class Counter

    def initialize(dir_path)
      raise ArgumentError if !Dir.exist?(dir_path) || Dir.empty?(dir_path)
      @dir_path = dir_path
      fetch_data
    end

    def fetch_all_gems
      @gems
    end

    def count_all_gems
      gems_count = Hash.new{0}
      @gems.each { |gem| gems_count[gem[0]] += 1 }
      gems_count
    end

    def rails_gems
      rails_gems = []
      @gems.each { |gem| rails_gems << gem[1] if gem[0] == "rails" }
      rails_gems
    end

    def count_rails_versions
      rails_gems
      rails_gems_count = Hash.new{0}
      rails_gems.each { |rl| rails_gems_count[rl] += 1 }
      rails_gems_count
    end

    def count_ruby_versions
      ruby_versions = Hash.new{0}
      @ruby.each { |r| ruby_versions[r] += 1 }
      ruby_versions
    end

    private

    def fetch_data
      @gems = []
      @ruby = []
      Dir[@dir_path + '/*'].each do |file|
        File.read(file).each_line do |line|
          @gems << [line.split[1].delete("',"), line.split[3]] if line.split[0] == "gem"
          @ruby << line.split[1].delete("'") if line.split[0] == "ruby"
        end
      end
    end
  end
  # c = Counter.new('./test/fixtures/gemfiles')
  # c = GemsCounter.new('./spec/fixtures/gem_test')
  # puts c.fetch_all_gems
  # puts c.count_ruby_versions
  # puts c.rails_gems
  # puts c.count_rails_versions
  # puts c.count_all_gems
  # puts c
end
