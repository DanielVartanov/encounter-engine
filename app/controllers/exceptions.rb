# -*- encoding : utf-8 -*-
class Exceptions < Application

  # handle NotFound exceptions (404)
  def not_found
    render :format => :html
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html
  end

  def unauthorized
    @message = request.exceptions.first.message
    render :layout => false
  end

end
