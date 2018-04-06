class ProductController < ApplicationController
  def list
    @vsellers = Vseller.all
    
  end

  def detail
  end

end
