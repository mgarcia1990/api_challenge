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

end
