require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

# Load Sinatra Framework (with AR)
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/contrib/all' # Requires cookies, among other things

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Global Sinatra configuration
configure do
  set :root, APP_ROOT.to_path
  set :server, :puma

  enable :sessions
  set :session_secret, ENV['SESSION_KEY'] || 'lighthouselabssecret'

  set :views, File.join(Sinatra::Application.root, "app", "views")
end
# Development and Test Sinatra Configuration
configure :development, :test do
  require 'pry'
  
  ActiveRecord::Base.establish_connection(
       :adapter  => 'postgresql',
       :host     => 'ec2-50-19-219-148.compute-1.amazonaws.com',
       :username => 'pvurmpxcrhxfpy',
       :password => 'NUhcb84vgmVxbLF9n2UDQAEWqk',
       :database => 'd20hlg33c1mr4e',
       :encoding => 'utf8'
  )
end

# Production Sinatra Configuration
configure :production do
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
       :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
       :host     => db.host,
       :username => db.user,
       :password => db.password,
       :database => db.path[1..-1],
       :encoding => 'utf8'
  )
end

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Load the routes / actions
require APP_ROOT.join('app', 'actions')
