get '/' do
  if signed_in?
    redirect "/users/#{current_user.id}"
  end
  erb :index
end


get '/signin' do
  erb :signin
end

post '/signin' do
  @user = User.find_by(username: params[:username])
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{current_user.id}"
  else
    redirect '/'
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.create(params)
  session[:user_id] = @user.id
  redirect '/'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/:id' do
  p current_user
  p signed_in?
  if signed_in?
    @my_surveys = Survey.where(created_by: current_user.username)
    erb :temp_homepage
  end

end


get '/users/:id/surveys/create' do

end

# fill survey
get '/surveys/:survey_id' do

end

# see survey result
get '/surveys/:survey_id/result' do
  @survey = Survey.find(params[:survey_id])

  erb :survey_result, layout: false
end

