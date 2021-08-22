class HelpsController < ApplicationController

  def index
    if params[:search_word] == nil
      @helps = Help.all.page(params[:page]).per(5)
    else
      @helps = Help.search(params[:search_word]).page(params[:page]).per(5)
    end
  end

end
