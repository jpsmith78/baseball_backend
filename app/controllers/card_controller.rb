class CardController < ApplicationController

  def index
    render json: {message: 'hi', status: 200}
  end




end
