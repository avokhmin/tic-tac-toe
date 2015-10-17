require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(1) }

  describe '#initialize' do
    it 'assigns a key' do
      expect(user.key).to eq 1
    end
  end

end
