class CardController < ApplicationController

  def index
    render json: Card.all
  end

  def show
    render json: Card.find(params["id"])
  end

  def create
    render json: Card.create(params["card"])
  end

  def delete
    render json: Card.delete(params["id"])
  end

  def update
    render json: Card.update(params["id"], params["card"])
  end


end
