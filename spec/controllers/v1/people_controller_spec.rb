require 'rails_helper'

RSpec.describe V1::PeopleController, type: :controller do

    let!(:person_a) { FactoryBot.create(:person) }
    let!(:person_b) { FactoryBot.create(:person) }

    let(:params) {
        {
            first_name: 'First',
            last_name: 'Last'
        }
    }

    describe 'index' do
        it 'returns 200' do
            get :index, format: :json
            expect(response.status).to eq(200)
        end

        it 'fetches people' do
            get :index, format: :json
            expect(assigns(:people)).to contain_exactly(person_a, person_b)
        end
    end

    describe 'create' do

        subject { post :create, params: { person: params }, format: :json }

        context 'with valid params' do
            it 'returns 201' do
                subject
                expect(response.status).to eq(201)
            end

            it 'creates a new person' do
                expect{
                    subject
                }.to change(Person, :count).by(1)
            end
        end

        context 'with invalid params' do
            before {
                params.delete(:last_name)
            }

            it 'returns 400' do
                subject
                expect(response.status).to eq(400)
            end

            it 'does not create a person when params are invalid' do
                expect{
                    subject
                }.to change(Person, :count).by(0)
            end
        end
    end

    describe 'update' do
        let(:updated_last_name) { 'Updated' }

        it 'returns 200' do
            put :update, params: { id: person_a.id, person: { last_name: updated_last_name } }, format: :json
            expect(response.status).to eq(200)
        end

        it 'should update person' do
            put :update, params: { id: person_a.id, person: { last_name: updated_last_name } }, format: :json
            expect(person_a.reload.last_name).to eq(updated_last_name)
        end

        it 'returns 404 on invalid id' do
            put :update, params: { id: 999, person: { last_name: updated_last_name } }, format: :json
            expect(response.status).to eq(404)
        end
    end

    describe 'delete' do

        it 'returns 204' do
            delete :destroy, params: { id: person_a.id }, format: :json
            expect(response.status).to eq(204)
        end

        it 'should destroy person' do
            expect{
                delete :destroy, params: { id: person_a.id }, format: :js
            }.to change(Person, :count).to(1)
        end

        it 'returns 404 on invalid id' do
            delete :destroy, params: { id: 999 }, format: :js
            expect(response.status).to eq(404)
        end
    end

    describe 'movies' do
      let(:movie_params) {
          {
            id: person_a.id,
            movie_id: FactoryBot.create(:movie).id,
            role: role
          }
      }

      subject { post :movies, params: movie_params, format: :json }

      context 'as star' do
        let(:role) { 'star' }

          it 'returns 200' do
              subject
              expect(response.status).to eq(200)
          end

          it 'add movies to person filmography' do
              expect{
                  subject
              }.to change(person_a.movies_as_actor_actress, :count).by(1)
          end
      end

      context 'as director' do
        let(:role) { 'director' }

          it 'returns 200' do
              subject
              expect(response.status).to eq(200)
          end

          it 'add movies to person filmography' do
              expect{
                  subject
              }.to change(person_a.movies_as_director, :count).by(1)
          end
      end

      context 'as producer' do
        let(:role) { 'producer' }

          it 'returns 200' do
              subject
              expect(response.status).to eq(200)
          end

          it 'add movies to person filmography' do
              expect{
                  subject
              }.to change(person_a.movies_as_producer, :count).by(1)
          end
      end
    end

    describe 'destroy_movies' do
      let(:movie) { FactoryBot.create(:movie) }
      let(:movie_params) {
          {
            id: person_a.id,
            movie_id: movie.id,
            role: role
          }
      }

      before {
        ParticipatingMovie.roles.values.each do |role|
          ParticipatingMovie.create! person: person_a, movie: movie, role: role
        end
      }

      subject { delete :destroy_movie, params: movie_params, format: :json }

      context 'as star' do
        let(:role) { 'star' }

          it 'returns 200' do
              subject
              expect(response.status).to eq(200)
          end

          it 'removes movie from person filmography' do
              expect{
                  subject
              }.to change(person_a.movies_as_actor_actress, :count).by(-1)
          end
      end

      context 'as director' do
        let(:role) { 'director' }

          it 'returns 200' do
              subject
              expect(response.status).to eq(200)
          end

          it 'removes movie from person filmography' do
              expect{
                  subject
              }.to change(person_a.movies_as_director, :count).by(-1)
          end
      end

      context 'as producer' do
        let(:role) { 'producer' }

          it 'returns 200' do
              subject
              expect(response.status).to eq(200)
          end

          it 'removes movie from person filmography' do
              expect{
                  subject
              }.to change(person_a.movies_as_producer, :count).by(-1)
          end
      end
    end
end
