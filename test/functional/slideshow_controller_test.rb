require File.dirname(__FILE__) + '/../test_helper'
require 'slideshow_controller'

# Re-raise errors caught by the controller.
class SlideshowController; def rescue_action(e) raise e end; end

class SlideshowControllerTest < Test::Unit::TestCase
  def setup
    @controller = SlideshowController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
