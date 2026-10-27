class PostsController < ApplicationController
  # Punto 20.1: Solo usuarios logueados pueden acceder
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # Punto 3: Validación para que solo el dueño pueda editar/borrar
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(permit_post)
    @post.user = current_user # Asignamos el autor actual
    
    if @post.save
      flash[:success] = "¡Tu publicación se ha creado con éxito!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    if @post.update(permit_post)
      flash[:success] = "¡Tu publicación se ha actualizado!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "¡Publicación eliminada correctamente!"
    else
      flash[:error] = "No se pudo eliminar la publicación."
    end
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # Lógica de validación de dueño
  def correct_user
    unless @post.user == current_user
      flash[:alert] = "⛔ No tienes permiso para modificar o eliminar esta publicación."
      redirect_to posts_path
    end
  end

  def permit_post
    params.require(:post).permit(:image, :description)
  end
end