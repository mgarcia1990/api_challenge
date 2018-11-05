require 'rails_helper'

RSpec.describe V1::MoviesController, type: :controller do

  let!(:movie_a) { FactoryBot.create(:movie) }
  let!(:movie_b) { FactoryBot.create(:movie) }

  let(:params) {
      {
          title: 'Awesome Movie',
          release_year: 2018
      }
  }

  describe 'index' do
      it 'returns 200' do
          get :index, format: :json
          expect(response.status).to eq(200)
      end

      it 'fetches people' do
          get :index, format: :json
          expect(assigns(:movies)).to contain_exactly(movie_a, movie_b)
      end
  end

  describe 'create' do

      subject { post :create, params: { movie: params }, format: :json }

      context 'with valid params' do
          it 'returns 201' do
              subject
              expect(response.status).to eq(201)
          end

          it 'creates a new movie' do
              expect{
                  subject
              }.to change(Movie, :count).by(1)
          end
      end

      context 'with invalid params' do
          before {
              params.delete(:title)
          }

          it 'returns 400' do
              subject
              expect(response.status).to eq(400)
          end

          it 'does not create a movie when params are invalid' do
              expect{
                  subject
              }.to change(Movie, :count).by(0)
          end
      end
  end

  describe 'update' do
      let(:updated_title) { 'Awesomess increased' }

      it 'returns 200' do
          put :update, params: { id: movie_a.id, movie: { title: updated_title } }, format: :json
          expect(response.status).to eq(200)
      end

      it 'should update movie' do
          put :update, params: { id: movie_a.id, movie: { title: updated_title } }, format: :json
          expect(movie_a.reload.title).to eq(updated_title)
      end

      it 'returns 404 on invalid id' do
          put :update, params: { id: 999, movie: { title: updated_title } }, format: :json
          expect(response.status).to eq(404)
      end
  end

  describe 'delete' do

      it 'returns 204' do
          delete :destroy, params: { id: movie_a.id }, format: :json
          expect(response.status).to eq(204)
      end

      it 'should destroy movie' do
          expect{
              delete :destroy, params: { id: movie_a.id }, format: :js
          }.to change(Movie, :count).to(1)
      end

      it 'returns 404 on invalid id' do
          delete :destroy, params: { id: 999 }, format: :js
          expect(response.status).to eq(404)
      end
  end

  describe 'crew' do
    let(:crew_params) {
        {
          id: movie_a.id,
          person_id: FactoryBot.create(:person).id,
          role: role
        }
    }

    subject { post :crew, params: crew_params, format: :json }

    context 'as star' do
      let(:role) { 'star' }

      it 'returns 200' do
        subject
        expect(response.status).to eq(200)
      end

      it 'adds start to movie crew' do
        expect{
            subject
        }.to change(movie_a.casting, :count).by(1)
      end
    end

    context 'as director' do
      let(:role) { 'director' }

      it 'returns 200' do
        subject
        expect(response.status).to eq(200)
      end

      it 'adds director to movie crew' do
        expect{
            subject
        }.to change(movie_a.directors, :count).by(1)
      end
    end

    context 'as producer' do
      let(:role) { 'producer' }

        it 'returns 200' do
          subject
          expect(response.status).to eq(200)
        end

        it 'adds producer to movie crew' do
          expect{
              subject
          }.to change(movie_a.producers, :count).by(1)
      end
    end
  end

  describe 'destroy_person' do
    let(:person) { FactoryBot.create(:person) }
    let(:crew_params) {
        {
          id: movie_a.id,
          person_id: person.id,
          role: role
        }
    }

    before {
      ParticipatingMovie.roles.values.each do |role|
        ParticipatingMovie.create! person: person, movie: movie_a, role: role
      end
    }

    subject { delete :destroy_person, params: crew_params, format: :json }

    context 'as star' do
      let(:role) { 'star' }

      it 'returns 200' do
        subject
        expect(response.status).to eq(200)
      end

      it 'removes star from movie crew' do
        expect{
            subject
        }.to change(movie_a.casting, :count).by(-1)
      end
    end

    context 'as director' do
      let(:role) { 'director' }

      it 'returns 200' do
        subject
        expect(response.status).to eq(200)
      end

      it 'removes director from movie crew' do
        expect{
            subject
        }.to change(movie_a.directors, :count).by(-1)
      end
    end

    context 'as producer' do
      let(:role) { 'producer' }

      it 'returns 200' do
        subject
        expect(response.status).to eq(200)
      end

      it 'removes producer from movie crew' do
        expect{
            subject
        }.to change(movie_a.producers, :count).by(-1)
      end
    end
  end

end
