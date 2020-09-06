Rails.application.routes.draw do


  ActiveAdmin.routes(self)
  resources :tweets do
    post 'likes', to: 'tweets#likes'
    post 'retweet', to: 'tweets#retweet'
  end

  devise_for :users
  get 'home/index'
  get 'all_tweets', to: 'home#all_tweets', as: 'all_tweets'
  #get 'users/follow'
  post 'follow/:user_id', to: 'users#follow', as: 'users_follow'

  root to: 'home#index'

  #get 'api/news'
  scope '/api' do
    get '/news', to: 'api#news'
    get '/:date1/:date2', to: 'api#tweets_between_dates' as:'tweets_between_dates'
  end
end
