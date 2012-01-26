require File.dirname(__FILE__) + '/../test_helper'
require 'prints_controller'

# Re-raise errors caught by the controller.
class PrintsController; def rescue_action(e) raise e end; end

class PrintsControllerTest < Test::Unit::TestCase
  def setup
    @controller = PrintsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
