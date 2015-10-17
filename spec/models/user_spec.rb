require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:key) }

  let(:user) { User.new(name: 'Foo', key: 1) }

  describe '#initialize' do
    it 'assigns a name' do
      expect(user.name).to eq 'Foo'
    end

    it 'assigns a key' do
      expect(user.key).to eq 1
    end
  end

end
