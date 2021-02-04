# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      render status: :created, json: todo
    else
      render status: :unprocessable_entity, json: { errors: todo.errors }
    end
  end

  def update
    todo = Todo.find(params[:id])

    if todo.update(todo_params)
      render json: todo
    else
      render status: :unprocessable_entity, json: { errors: todo.errors }
    end
  end

  def destroy
    todo = Todo.find(params[:id])

    todo.delete

    render :ok
  end

  private

  def todo_params
    params.require(:todo).permit(:description, :done)
  end
end
