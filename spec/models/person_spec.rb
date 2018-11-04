require 'rails_helper'

RSpec.describe Person, type: :model do
  it { expect validate_presence_of(:last_name) }
  it { expect validate_presence_of(:first_name) }

  it { should have_many(:participating_movies) }
  it { should have_many(:movies_as_actor_actress).through(:participating_movies) }
  it { should have_many(:movies_as_director).through(:participating_movies) }
  it { should have_many(:movies_as_producer).through(:participating_movies) }

  it { expect(FactoryBot.create(:person)).to be_valid }

  describe 'participating movies' do
    let!(:person) { FactoryBot.create(:person) }
    let!(:blockbuster) { FactoryBot.create(:movie) }

    subject { -> { ParticipatingMovie.create person: person,
                                             movie: blockbuster,
                                             role: role } }

    context 'as actor/actress' do
      let(:role) { ParticipatingMovie.roles[:star] }      
      it { should change(person.movies_as_actor_actress, :count).to 1 }
    end

    context 'as director' do
      let(:role) { ParticipatingMovie.roles[:director] }      
      it { should change(person.movies_as_director, :count).to 1 }
    end

    context 'as producer' do
      let(:role) { ParticipatingMovie.roles[:producer] }      
      it { should change(person.movies_as_producer, :count).to 1 }
    end
  end
end
