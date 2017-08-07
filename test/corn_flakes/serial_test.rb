require 'test_helper'

module CornFlakes
  class SerialTest < MiniTest::Unit::TestCase
    def setup
      @serial = Serial.new(100)
    end

    def test_to_s
      assert_equal "CCGgiWlOCA", @serial.to_s
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
  end
end
