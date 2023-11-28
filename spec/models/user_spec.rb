RSpec.describe User, type: :model do
  describe '#name' do
    let(:user) { User.new(first_name: 'John', last_name: 'Doe') }

    it 'returns the full name' do
      expect(user.name).to eq('John Doe')
    end
  end

  describe '#auth_provider' do
    let(:user_google) { User.new(provider: 'google_oauth2') }
    let(:user_github) { User.new(provider: 'github') }

    it 'returns the corresponding authentication provider name' do
      expect(user_google.auth_provider).to eq('Google')
      expect(user_github.auth_provider).to eq('Github')
    end
  end

  describe '.find_google_user' do
    let!(:google_user) { instance_double("User") }

    it 'finds a user by UID and Google provider' do
      allow(User).to receive(:find_by).and_return(google_user)
      found_user = User.find_google_user('some_uid')
      expect(found_user).to eq(google_user)
    end
  end

  describe '.find_github_user' do
    let!(:github_user) { instance_double("User") }
    it 'finds a user by UID and Github provider' do
      allow(User).to receive(:find_by).and_return(github_user)
      found_user = User.find_github_user('some_uid')
      expect(found_user).to eq(github_user)
    end
  end
end
