require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  let(:user1) { User.new(name: 'Foo', key: 1) }
  let(:user2) { User.new(name: 'Bar', key: 2) }
  let(:users) { [user1, user2] }
  let(:game)  { Game.new(users: users) }

  describe 'index' do
    it 'is successful' do
      get :index
      expect(response).to be_success
      expect(assigns(:winners)).to be
      expect(response).to render_template('index')
    end
  end

  describe 'new' do
    it 'is successful' do
      get :new
      expect(response).to be_success
      expect(assigns(:game)).to be
      expect(assigns(:user1)).to be
      expect(assigns(:user2)).to be
      expect(response).to render_template('new')
    end
  end

  describe 'create' do
    it 'creates a game' do
      expect(SecureRandom).to receive(:uuid) { 'new-game' }
      post :create, game: { users: [{ name: 'Foo' }, {name: 'Bar' }] }
      expect(assigns(:game)).to  be
      expect(assigns(:user1)).to be
      expect(assigns(:user2)).to be
      expect(response).to redirect_to game_path('new-game')
    end
  end

  describe 'show' do
    before do
      allow(Game).to receive(:find) { game }
    end

    it 'is successful' do
      get :show, id: 1234
      expect(response).to be_success
      expect(assigns(:game)).to eq game
      expect(response).to render_template('show')
    end

    it 'is not successful if no game' do
      allow(Game).to receive(:find) { nil }
      expect do
        get :show, id: 1234
      end.to raise_error(ActionController::RoutingError)
    end
  end

end
