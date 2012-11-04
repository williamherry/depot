class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    increment_counter

    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    else
      @products = Product
      @products = Product.order(:title)
      @cart = current_cart
    end
  end

  private

    def increment_counter
      if session[:counter].nil?
        session[:counter] = 0
      end
      session[:counter] += 1
    end
end
