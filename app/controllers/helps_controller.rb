class HelpsController < ApplicationController

  def index
    if params[:search_word] == nil
      @helps = Help.all
    else
      @helps = Help.search(params[:search_word])
    end
  end

end
