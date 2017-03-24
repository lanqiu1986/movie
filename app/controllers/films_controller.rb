class FilmsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_film_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @films = Film.all
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    @film.user = current_user
    if @film.save
      current_user.favorite_join!(@film)
      redirect_to films_path
    else
      render :new
    end
  end

  def show
    @film = Film.find(params[:id])
    @reviews = @film.reviews.recent.paginate(:page => params[:page], :per_page => 2)
  end

  def edit
  end

  def update

    if @film.update(film_params)
      redirect_to films_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @film.destroy
    flash[:alert] = "Film deleted"
    redirect_to films_path
  end

  def join
     @film = Film.find(params[:id])

      if !current_user.is_favor_of?(@film)
        current_user.favorite_join!(@film)
        flash[:notice] = "favorited"
      else
        flash[:warning] = "你已经favorited了！"
      end

      redirect_to film_path(@film)
    end

    def quit
      @film = Film.find(params[:id])

      if current_user.is_favor_of?(@film)
        current_user.favorite_cancel!(@film)
        flash[:alert] = "已退出favorite！"
      else
        flash[:warning] = "你不是favorite，怎么退出 XD"
      end

      redirect_to film_path(@film)
    end

  private
  def find_film_and_check_permission
    @film = film.find(params[:id])

    if current_user != @film.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def film_params
    params.require(:film).permit(:name, :description)
  end

end
