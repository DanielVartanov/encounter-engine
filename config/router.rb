# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can specify conditions on the placeholder by passing a hash as the second
# argument of "match"
#
#   match("/registration/:course_name", :course_name => /^[a-z]{3,5}-\d{5}$/).
#     to(:controller => "registration")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")

  resources :users do
    resources :games
  end

  resources :teams

  resources :invitations

  resources :games do |games|
    games.resources :levels do |levels|
      levels.resources :hints
      levels.resources :questions

      levels.member :move_up, :method => :get
      levels.member :move_down, :method => :get
    end
  end
 
  match('/play/:game_id/tip', :method => :get).to(:controller => :game_passings, :action => :get_current_level_tip).name(:get_current_level_tip)
  match('/play/:game_id', :method => :get).to(:controller => :game_passings, :action => :show_current_level).name(:show_current_level)
  match('/play/:game_id', :method => :post).to(:controller => :game_passings, :action => :pass_level).name(:pass_level)

#  match('/stats/:game_id', :method => :get).to(:controller => :game_passings, :action => :index).name(:game_stats)
  match('/stats/:action/:game_id').to(:controller => :game_passings).name(:game_stats)

  match('/signup').to(:controller => :users, :action => :new).name(:signup)
  match('/dashboard').to(:controller => :dashboard).name(:dashboard)
  match('/team-room').to(:controller => :team_room).name(:team_room)

  match('/').to(:controller => :index).name(:index_page)

  default_routes
end