class Api::V1::GamesController < Api::V1::BaseController

  resource_description do
    resource_id 'games'
    name        'Games'
    description <<-EOS
      A *Game* is a unique game.

      A *Game* has many *Users*.
    EOS
  end

  before_action :load_game

  api         :GET, '/games/:id.json', 'Get information about a specific game'
  param       :id, String, required: true
  param_group :common_params, Api::V1::BaseController
  error       :code => 404, :desc => 'Not Found'
  description <<-EOS
    Returns details of the game with the given ID.
  EOS
  def show
    render json: @game
  end

  api         :GET, '/games/:id/tic/:row/:column.json', 'Perform new tic'
  param       :id,     String, required: true
  param       :row,    String, required: true
  param       :column, String, required: true
  param_group :common_params, Api::V1::BaseController
  error       :code => 404, :desc => 'Not Found'
  description <<-EOS
    Returns details of the game with the given ID.
  EOS
  def tic
    key = @game.tic(row: params[:row].to_i, column: params[:column].to_i)
    head :unprocessable_entity and return unless key

    json = {
      value: key,
      user:  @game.current_user,
      win:   @game.win?,
      drawn: @game.drawn?,
    }

    Game.add_winner(@game.current_user) if json[:win]
    if json[:win] || json[:drawn]
      @game.destroy
    else
      @game.next_move
      @game.save
    end

    render json: json
  end

  private

  # Private: before_action hook which loads an existing game.
  def load_game
    @game = Game.find params[:id]
    head :unprocessable_entity unless @game
  end

end
