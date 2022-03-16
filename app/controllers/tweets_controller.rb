class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :like]

  def like
    @tweet.likes = @tweet.likes+1
    if @tweet.save
      respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'You liked correctly' }
      format.json { head :Forbidden }
      end
  end
end
  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    
    respond_to do |format|
      if @tweet.save
        if session[:created_ids].nil?
          session[:created_ids]=[@tweet.id]
        else
          session[:created_ids].insert(0, @tweet.id)
        end
        format.html { redirect_to tweets_url, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
       a = ""
        @tweet.errors.each do |error|
          if a == ""
           a += error.full_message
          else
            a += " and " + error.full_message
          end
        end
        format.html { redirect_to tweets_url, alert: a }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
  
    

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to tweets_url, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    if session[:created_ids].nil? or !session[:created_ids].index(@tweet.id)
      respond_to do |format|
      format.html { redirect_to tweets_url, alert: 'You are not allowed to delete this tweet' }
      format.json { head :Forbidden }
      end
    else 
        @tweet.destroy
          respond_to do |format|
          format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
          format.json { head :no_content }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:author, :content)
    end
end
