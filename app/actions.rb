# Homepage (Root path)

require 'twilio-ruby'

helpers do
  def get_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_current_name
    get_current_user
    if @current_user.nil?
      "Guest"
    else
      @current_user.display_name
    end
  end

  def get_login_or_logout
    get_current_user
    if @current_user
      return "<a href=/logout>Logout</a>"
    else
      return "<a href=/login>Login</a>"
    end
  end

  def get_game_participants_as_array
    users = Order.where(game_id: session[:game_id])
    @names = []

    users.each do |u|
      @names << u.user
    end

    @names
  end

  def get_all_users
    
  end
end

get '/' do
  if @current_user.nil?
    erb :main
  else
    erb :'index'
  end
end

get '/login' do
  if @current_user
    redirect "/"
  else
    erb :'login'
  end

end

post '/login' do
  user = User.find_by(email: params[:email])
  if !user.nil? && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login/error'
  end
end

get '/login/error' do
  erb :'login_error'
end

get "/logout" do
  session.clear
  cookies.clear
  @current_user = nil
  redirect "/"
end

get '/users/new' do
  erb :'create_account'
end

post '/users/new' do
  if params[:email] && params[:display_name] && params[:password] && params[:phone_number] && params[:drink]
    user = User.new(params)
    user.password = params[:password]
    user.save
    redirect '/login'
  else
    # create a create_user error page
    redirect '/users/new'
  end
end

get '/profile/show' do
  @user = User.find(session[:user_id])
  erb :'profile/show'
end

get '/profile/edit' do
  @user = User.find(session[:user_id])
  erb :'profile/edit'
end

post '/profile/edit' do
  @user = User.find(session[:user_id])
  @user.email = params[:email]
  @user.display_name = params[:display_name]
  @user.phone_number = params[:phone_number]
  @user.drink = params[:drink]
  @user.password = params[:password]
  if @user.save
    redirect '/profile/show'
  else
    erb :'/profile/edit'
  end
end

get '/games/new' do
  erb :'games/new'
end

post '/games/new' do
  user = {user_id: User.find(session[:user_id]).id}
  @game = Game.new(user)
  @game.save

  players = params[:user_list].split(',').map do |name| 
    name.strip
  end
  players << get_current_name
  
  @order_new = nil
  players.each do |player|

    order_data = {user_id: User.find_by(display_name: player).id, game_id: @game.id}
    @order_new = Order.new(order_data)
    @order_new.save
  end

  redirect "/games/#{@game.id}"
end

get '/games/:id' do |id|
  session[:game_id] = id;
  erb :'games/current'
end

get '/games/complete/:id' do |id|
  game_holder = Game.find(id)
  if game_holder
    game_holder.is_active = false
    game_holder.save
  end
  redirect '/'
end

get '/login/peter' do
  user = User.find_by(email: "peter@werl.me")
  session[:user_id] = user.id
  redirect '/'
end

get '/login/jason' do
  user = User.find_by(email: "jason@email.com")
  session[:user_id] = user.id
  redirect '/'
end

get '/login/jairus' do
  user = User.find_by(email: "jairus@email.com")
  session[:user_id] = user.id
  redirect '/'
end

get '/test/twilio' do
  @client = Twilio::REST::Client.new ENV['twilio_sid'], ENV['twilio_token']
   
  @client.account.messages.create({
    :from => '+12044006394', 
    :to => '+17803622157', 
    :body => 'TEST', 
  })
end
