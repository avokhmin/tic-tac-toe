require 'rails_helper'

RSpec.describe 'Games API V1', type: :request, apiv1: true do
  let(:user1) { User.new(name: 'Foo', key: 1) }
  let(:user2) { User.new(name: 'Bar', key: 2) }
  let(:users) { [user1, user2] }
  let(:game)  { Game.new(users: users) }

  describe 'show' do
    before do
      game.save
    end

    it 'documents itself', :show_in_doc do
      get "/api/v1/games/#{game.id}"
      expect(response).to be_success
    end

    it 'is successful' do
      get "/api/v1/games/#{game.id}"
      expect(response).to be_success
      expect(json_body['id']).to eq game.id
    end
  end

  describe 'tic' do
    before do
      game.save
    end

    it 'documents itself', :show_in_doc do
      put "/api/v1/games/#{game.id}/tic/1/2"
      expect(response).to be_success
    end

    it 'is successful' do
      put "/api/v1/games/#{game.id}/tic/1/2"
      expect(response).to be_success
      expect(json_body['value']).to eq 1
    end
  end

end
