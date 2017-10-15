require 'test_helper'

class Sluggable::Rails::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Sluggable::Rails
  end
end
