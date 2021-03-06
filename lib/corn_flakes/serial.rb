require 'set'
module CornFlakes
  class Serial

    @@allows = Set.new(('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a)

    attr_reader :length, :ignores, :separator, :separate_size, :prefix, :suffix

    def initialize(seed, opts = {})
      @seed = seed
      @length = opts[:length] || 10
      @ignores = Set.new(opts[:ignores]) || Set.new
      @separator = opts[:separator]
      @separate_size = opts[:separate_size]
      @prefix = opts[:prefix]
      @suffix = opts[:suffix]

      self.random = if seed
                      Random.new(seed.kind_of?(Integer) ? seed : str2i(seed))
                    else
                      Random.new
                    end
    end

    def next
      @next ||= Serial.new(
        to_i,
        length: length,
        ignores: ignores,
        separator: separator,
        separate_size: separate_size,
        prefix: prefix,
        suffix: suffix
      )
    end

    def to_s
      @stringify ||= "#{prefix}#{key}#{suffix}"
    end

    def to_i
      separate? ? str2i(key.delete(separator)) : str2i(key)
    end

    private

    def str2i(s)
      s.bytes.join.to_i
    end

    def key
      @key ||= generate(random).encode("UTF-8")
    end

    def generate(random)
      s = random.bytes(length * 1000).chars.select { |c| @@allows.include?(c) }.delete_if { |c| ignores.include?(c) }[0...length]
      if separate?
        s.each_slice(separate_size).map(&:join).join(separator)
      else
        s.join
      end
    end

    def random
      @random
    end

    def random=(random)
      @random = random
    end

    def separate?
      separate_size && separator
    end
  end
end
