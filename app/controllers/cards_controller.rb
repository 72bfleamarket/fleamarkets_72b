class CardsController < ApplicationController
  def index
    @cards = Card.all
    @users = User.all
  end
  
  def edit
    @cards = Card.all
  end

  def update
  end

  def destory
  end

end
