require 'test_helper'

module CornFlakes
  class SerialTest < MiniTest::Unit::TestCase
    def setup
      @serial = Serial.new(100)
    end

    def test_to_s
      assert_equal "CCGgiWlOCA", @serial.to_s
    end

    def test_string_seed
      serial = Serial.new("test")
      assert_equal "kBrbcAjPGK", serial.to_s
    end

    def test_separator
      serial = Serial.new(100, separator: '-', separate_size: 4)
      assert_equal "CCGg-iWlO-CA", serial.to_s
    end

    def test_separator_no_separate_size
      serial = Serial.new(100, separator: '-')
      assert_equal "CCGgiWlOCA", serial.to_s
    end

    def test_no_separator_with_separate_size
      serial = Serial.new(100, separate_size: 4)
      assert_equal "CCGgiWlOCA", serial.to_s
    end

    def test_immutable_to_s
      @serial.to_s
      @serial.to_s
      @serial.to_s
      assert_equal "CCGgiWlOCA", @serial.to_s
    end

    def test_next
      assert_equal "hpDcTGIUMU", @serial.next.to_s
    end

    def test_string_seed_next
      serial = Serial.new("test").next
      assert_equal "wjElyYbGrx", serial.to_s
    end

    def test_separator_next
      serial = Serial.new(100, separator: '-', separate_size: 4).next
      assert_equal "hpDc-TGIU-MU", serial.to_s
    end

    def test_ignores_next
      serial = Serial.new(100, ignores: ['h', 'T']).next # next: hpDcTGIUMU
      assert !(serial.to_s.include?('h'))
      assert !(serial.to_s.include?('T'))
    end

    def test_prefix_and_suffix_next
      serial = Serial.new(100, prefix: "A-", suffix: "-Z").next
      assert_equal "A-hpDcTGIUMU-Z", serial.to_s
    end

    def test_default_length_is_10
      assert_equal 10, @serial.to_s.size
    end

    def test_set_length
      serial = Serial.new(100, length: 5)
      assert_equal "CCGgi", serial.to_s
      assert_equal 5, serial.to_s.size
    end

    def test_ignore_chars
      serial = Serial.new(100, ignores: ['g', 'A'])
      assert !(serial.to_s.include?('g'))
      assert !(serial.to_s.include?('A'))
    end

    def test_prefix
      serial = Serial.new(100, prefix: "A-")
      assert_equal "A-CCGgiWlOCA", serial.to_s
    end

    def test_suffix
      serial = Serial.new(100, suffix: "-Z")
      assert_equal "CCGgiWlOCA-Z", serial.to_s
    end

    def test_prefix_and_suffix
      serial = Serial.new(100, prefix: "A-", suffix: "-Z")
      assert_equal "A-CCGgiWlOCA-Z", serial.to_s
    end

    def test_length_is_not_affected_by_prefix
      serial = Serial.new(100, prefix: "A-")
      assert_equal 12, serial.to_s.size
    end

    def test_length_is_not_affected_by_suffix
      serial = Serial.new(100, suffix: "-Z")
      assert_equal 12, serial.to_s.size
    end

    def test_length_is_not_affected_by_prefix_and_suffix
      serial = Serial.new(100, prefix: "A-", suffix: "-Z")
      assert_equal 14, serial.to_s.size
    end

    def test_separator_is_not_affected_by_prefix_and_suffix
      serial = Serial.new(100, separator: '-', separate_size: 4, prefix: "A-", suffix: "-Z")
      assert_equal "A-CCGg-iWlO-CA-Z", serial.to_s
    end

  end
end
