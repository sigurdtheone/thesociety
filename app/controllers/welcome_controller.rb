class WelcomeController < ApplicationController

  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "Index", '/'
  end
end
