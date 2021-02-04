# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  describe 'GET index' do
    context 'when there are todos' do
      let!(:todos) { create_list(:todo, 3) }

      it 'returns todos json' do
        get :index

        expect(response.body).to eq todos.to_json
      end
    end

    context 'when there are no todos' do
      it 'returns empty json' do
        get :index

        expect(response.body).to eq [].to_json
      end
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      let(:valid_params) { { todo: attributes_for(:todo) } }

      it 'responds 201' do
        post :create, params: valid_params

        expect(response.status).to eq 201
      end

      it 'creates a new todo' do
        expect do
          post :create, params: valid_params
        end.to change { Todo.count }.by(1)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { todo: { description: '' } } }

      it 'responds 422' do
        post :create, params: invalid_params

        expect(response.status).to eq 422
      end

      it 'responds body with errors' do
        post :create, params: invalid_params

        expect(response.body).to eq("{\"errors\":{\"description\":[\"can't be blank\"]}}")
      end

      it 'does not create a new todo' do
        expect do
          post :create, params: invalid_params
        end.to_not change(Todo, :count)
      end
    end
  end

  describe 'PUT update' do
    let(:todo) { create(:todo) }

    context 'with valid params' do
      let(:valid_params) do
        {
          id: todo.id,
          todo: {
            done: true
          }
        }
      end

      it 'responds 200' do
        put :update, params: valid_params

        expect(response.status).to eq 200
      end

      it 'updates existent todo' do
        expect do
          put :update, params: valid_params
        end.to change { todo.reload.done }.to(true)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          id: todo.id,
          todo: {
            description: '',
            done: true
          }
        }
      end

      it 'responds 422' do
        put :update, params: invalid_params

        expect(response.status).to eq 422
      end

      it 'responds body with errors' do
        put :update, params: invalid_params

        expect(response.body).to eq "{\"errors\":{\"description\":[\"can't be blank\"]}}"
      end

      it 'does not create a new todo' do
        expect do
          put :update, params: invalid_params
        end.to_not change(todo, :done)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:todo) { create(:todo) }

    it 'responds 200' do
      delete :destroy, params: { id: todo.id }

      expect(response.status).to eq 200
    end

    it 'delete todo' do
      expect do
        delete :destroy, params: { id: todo.id }
      end.to change { Todo.count }.from(1).to(0)
    end
  end
end
