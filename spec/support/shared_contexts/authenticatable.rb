shared_context 'authenticatable' do
  let!(:user) { User.create(email: 'spec@rails.com', password: 'specspec') }

  before {
    sign_in user
  }

end
