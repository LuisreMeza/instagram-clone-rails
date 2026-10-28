class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)
    
    if @like.save
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js # Esto renderiza create.js.erb
      end
    else
      flash[:error] = "No se pudo dar like."
      redirect_to post_path(@post)
    end
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    
    if @like&.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js # Esto renderiza destroy.js.erb
      end
    else
      flash[:error] = "No se pudo quitar el like."
      redirect_to post_path(@post)
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end