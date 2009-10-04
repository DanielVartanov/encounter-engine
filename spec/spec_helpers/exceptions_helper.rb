module ExceptionsHelper
  def assert_unauthenticated(&block)
    block.should raise_error(Merb::Controller::Unauthenticated)
  end

  def assert_unauthorized(&block)
    block.should raise_error(Merb::Controller::Unauthorized)
  end
end