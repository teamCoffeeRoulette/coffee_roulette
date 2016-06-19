# Homepage (Root path)

require_relative 'src/twilio_provider'
require_relative 'src/phone_number_parser'

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
    users = Game.find(session[:game_id]).users
  end

  def results_table
    result = Order.where(user_id: session[:user_id]).order("game_id DESC")
  end

  def get_coffee_getter_name
    coffee_order = Order.where(game_id: session[:game_id]).find_by(result: true)
    puts 1
    if coffee_order
      coffee_getter = coffee_order.user;
      puts 2
      if coffee_getter
        coffee_getter.display_name
        puts 3
      end
    end
    "ERROR"
  end
end

get '/' do
  erb :main
end

get '/:id' do |id|
  erb :'games/fetch'
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
  erb :'profile/show'
end

get '/profile/edit' do
  erb :'profile/edit'
end

post '/profile/edit' do
  if params[:phone_number] && test_number(params[:phone_number])
    user = User.find(session[:user_id])
    if user
      user.email = params[:email]
      user.display_name = params[:display_name]
      user.phone_number = test_number(params[:phone_number])
      user.drink = params[:drink]
      user.password = params[:password]
      if user.save
        redirect '/profile/show'
      else
        erb :'/profile/edit'
      end
    else
      redirect '/'
    end
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
    
    if params[:send_message]
      user = User.find_by(display_name: player)
      if user && user.phone_number
        send_invite_message(user.phone_number)
      end
    end
  end
  coffee_getter = User.find_by(display_name: players.sample)
  coffee_getter_order = Order.where(user_id: coffee_getter.id).where(game_id: @game.id)
  coffee_getter_order.each do |order|
    order.result = true
    order.save
  end
  session[:game_id] = @game.id
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
  session[:game_id] = nil
  redirect "/#{id}"
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
