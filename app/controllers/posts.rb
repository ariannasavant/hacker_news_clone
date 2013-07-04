get '/posts/new' do
  @post = Post.new
  erb :post
end

post '/posts' do
  if session[:id]
    @post = Post.new(title: params[:title], url: params[:url], user_id: session[:id])
    if @post.save
      erb :individual_post
    else
      erb :post
    end
  else
    redirect '/login'
  end
end

get '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  erb :individual_post
end

post '/posts/:post_id/comments' do
  p params
  @post = Post.find(params[:post_id])
  @comment = @post.comments.create(content: params[:content], user_id: session[:id])
  erb :individual_post
end
