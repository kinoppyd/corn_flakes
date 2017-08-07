require 'set'
module CornFlakes
  class Serial

    @@allows = Set.new(('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a)

    attr_reader :length, :ignores

    def initialize(seed, opts = {})
      @length = opts[:length] || 10
      @ignores = opts[:ignores] || []
      self.random = seed ? Random.new(seed) : Random.new 
    end

    def next
      @next ||= Serial.new(to_i, length: length, ignores: ignores)
    end

    def to_s
      key
    end

    def to_i
      to_s.bytes.join.to_i
    end

    private

    def key
      @key ||= generate(random)[0...length].encode("UTF-8")
    end

    def generate(random)
      random.bytes(length * 1000).chars.select { |c| @@allows.include?(c) }.delete_if { |c| ignores.include?(c) }.join
    end

    def random
      @random
    end

    def random=(random)
      @random = random
    end

  end
end
