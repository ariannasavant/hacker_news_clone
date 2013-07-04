# RESTful routing 101
# 1. The HTTP method *and* the route are both used to determine which action to take.
# 2. There are standard naming conventions for "resources".

# post '/users' do; end       # POST   / Create a new user
# get '/users' do; end        # GET    / Read all users
# get '/users/:id' do; end    # GET    / Read a single user
# put '/users/:id' do; end    # PUT    / Update a single user
# delete '/users/:id' do; end # DELETE / Delete a single user

# get '/users/new' do; end      # render the new user form (convention)
# get '/users/:id/edit' do; end # render the update user form (convention)


# post '/posts/:post_id/comments' do; end # POST / Create a new comment on post with id = :post_id

# post '/comments' do; end



get '/login' do
  session[:last_page_visited] = request.referrer
  @user = User.new
  erb :login
end

post '/sessions' do
  @user = User.find_by_username(params[:username])
  User.authenticate(@user.username, @user.password)
  session[:id] = @user.id
  redirect session.delete(:last_page_visited)
end

post '/users' do
  @user = User.new(params)
  if @user.save
    session[:id] = @user.id
    redirect session.delete(:last_page_visited)
  else
    erb :login
  end
end


get '/users/:user_id' do
  @user = User.find(session[:id])
  p @user
  if !@user
    @error = "You aren't logged in! Please login or sign up."
    redirect '/'
  else
    erb :user_profile
  end
end

get '/sessions/:user_id' do
  session.clear
  redirect '/'
end
