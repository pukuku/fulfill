class ClipsController < ApplicationController
  def create
  	@share=Share.find(params[:share_id])
  	clip = current_user.clips.build(share_id: params[:share_id])
  	clip.save
  end

  def destroy
  	@share=Share.find(params[:share_id])
  	clip = Clip.find_by(share_id: params[:share_id], user_id: current_user.id)
  	clip.destroy
  end
end
