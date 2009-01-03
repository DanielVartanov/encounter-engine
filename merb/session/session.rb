module Merb
  module Session
    
    # The Merb::Session module gets mixed into Merb::SessionContainer to allow 
    # app-level functionality; it will be included and methods will be available 
    # through request.session as instance methods.

#    def redirect_after_login
#      redirect_back_or "/dashboard", :ignore => [slice_url(:login), slice_url(:logout)]
#    end
#
#    def redirect_after_logout
#      redirect "/"
#    end
  end
end