# -*- encoding : utf-8 -*-
# Go to http://wiki.merbivore.com/pages/init-rb

use_orm :activerecord
use_test :rspec
use_template_engine :erb

Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper

  # cookie session store configuration
  c[:session_secret_key]  = '317d0a0e1a381404dd8edc5527896ecd140d117d'  # required for cookie session store
  c[:session_id_key] = '_encounter-engine_session_id' # cookie session id key, defaults to "_session_id"
end

Merb.push_path(:lib, Merb.root / "lib", "*.rb")

Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end

Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
  Merb::Mailer.delivery_method = :test_send
end

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
