class TrendsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :show, :destroy]
  before_filter :get_trends, only: [:index, :create, :show]

  def index
    if user_signed_in?
      @trend = @trends.first
    end
  end

  def create
    @trend = Trend.new(params[:trend].merge(user: current_user))

    @trend.save
    render :index
  end

  def show
    @trend = Trend.find(params[:id])

    render :index
  end

  def destroy
    @trend = Trend.find(params[:id])
    @trend.destroy

    redirect_to trends_path
  end

  private

  def get_trends
    @trends = current_user.trends.order("created_at DESC") if user_signed_in?
  end
end
