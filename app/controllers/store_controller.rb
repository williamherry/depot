class StoreController < ApplicationController
  def index
    increment_counter
    @products = Product.order(:title)
    @cart = current_cart
  end

  private

    def increment_counter
      if session[:counter].nil?
        session[:counter] = 0
      end
      session[:counter] += 1
    end
end
