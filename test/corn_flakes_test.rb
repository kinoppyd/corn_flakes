require 'test_helper'

class CornFlakesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CornFlakes::VERSION
  end
end
