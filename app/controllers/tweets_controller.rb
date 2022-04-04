class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        logged_in? ? (erb :'/tweets/new') : (redirect '/login')
    end

    get '/tweets/:id' do
        logged_in? ? ((@tweet = Tweet.find(params[:id])) && (erb :'/tweets/show')) : (redirect '/login')
    end   

    post '/tweets' do
        if params[:content] == " " || params[:content] == ""
            redirect 'tweets/new'
        else
            @user = current_user
            @tweet = Tweet.new(content: params[:content], user_id: @user.id)
            if @tweet.valid?
                @tweet.save
                redirect "/tweets/#{@tweet.id}"
            else
                redirect '/login'
            end
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @user = current_user
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == @user.id
                erb :'/tweets/edit'
            end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do 
        if params[:content] == " " || params[:content] == ""
            redirect back
        elsif logged_in?
            @user = current_user
            @tweet = Tweet.find(params[:id])
            @tweet.update(content: params[:content])
            @tweet.save if @tweet.valid?
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @user = current_user
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == @user.id
                @tweet.destroy
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

end