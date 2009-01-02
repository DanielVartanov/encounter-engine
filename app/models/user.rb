require 'merb-auth-more/mixins/salted_user'

class User < ActiveRecord::Base
  include Merb::Authentication::Mixins::SaltedUser
end
