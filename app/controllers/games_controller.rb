class GamesController < ApplicationController

  def index
    @winners = Rails.cache.read('Game#winners') || []
  end

  def new
    @user1 = User.new(key: 1)
    @user2 = User.new(key: 2)
    @game  = Game.new
  end

  def create
    @user1 = User.new(name: game_params[0][:name], key: 1)
    @user2 = User.new(name: game_params[1][:name], key: 2)
    @game  = Game.new(users: [@user1, @user2])

    if @user1.valid? && @user2.valid? && @game.save
      redirect_to game_path(@game), notice: t('.success_flash') and return
    end

    flash[:error] = t('.error_flash')
    render :new
  end

  def show
    @game = Game.find params[:id]
  end

  private

  def game_params
    params.require(:game).require(:users)
  end

end
