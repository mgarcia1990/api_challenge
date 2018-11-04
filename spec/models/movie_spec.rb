require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { expect validate_presence_of(:title) }
  it { expect validate_presence_of(:release_year) }

  it { should have_many(:participating_movies) }
  it { should have_many(:casting).through(:participating_movies) }
  it { should have_many(:directors).through(:participating_movies) }
  it { should have_many(:producers).through(:participating_movies) }

  it { expect(FactoryBot.create(:person)).to be_valid }

  describe 'participating movies' do
    let!(:person) { FactoryBot.create(:person) }
    let!(:blockbuster) { FactoryBot.create(:movie) }

    subject { -> { ParticipatingMovie.create person: person,
                                             movie: blockbuster,
                                             role: role } }

    context 'as actor/actress' do
      let(:role) { ParticipatingMovie.roles[:star] }      
      it { should change(blockbuster.casting, :count).to 1 }
    end

    context 'as director' do
      let(:role) { ParticipatingMovie.roles[:director] }      
      it { should change(blockbuster.directors, :count).to 1 }
    end

    context 'as producer' do
      let(:role) { ParticipatingMovie.roles[:producer] }      
      it { should change(blockbuster.producers, :count).to 1 }
    end
  end
end
