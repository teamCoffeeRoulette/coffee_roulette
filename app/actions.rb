# Homepage (Root path)
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
end

get '/' do
  if @current_user.nil?
    erb :main
  else
    erb :index
  end
end

get '/login' do
  if @current_user
    redirect "/"
  else
    erb :login
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
  erb :login_error
end

get "/logout" do
  session.clear
  cookies.clear
  @current_user = nil
  redirect "/"
end

get '/users/new' do
  erb :create_account
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
  @game = Game.new(
    user_id: @current_user
    )
  @game.save!
  redirect '/games/:id'
end



