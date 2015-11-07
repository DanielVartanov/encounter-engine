# -*- encoding : utf-8 -*-
class Levels < Application
  before :find_game
  before :ensure_author
  before :ensure_game_was_not_started, :only => [:new, :create, :edit, :update, :delete]
  before :build_level, :only => [:new, :create]
  before :find_level, :exclude => [:new, :create]

  def new
    render
  end

  def create
    if @level.save
      redirect resource(@game, @level)
    else      
      render :new
    end
  end

  def show
    render
  end

  def edit
    render
  end

  def update
    if @level.update_attributes(params[:level])
      redirect resource(@level.game, @level)
    else
      render :edit
    end
  end

  def delete
    @level.destroy
    redirect resource(@game)
  end

  def move_up
    @level.move_higher
    redirect resource(@game)
  end

  def move_down
    @level.move_lower
    redirect resource(@game)
  end

protected
  
  def find_game
    @game = Game.find(params[:game_id])
  end

  def build_level
    @level = Level.new(params[:level])    
    @level.game = @game
  end

  def find_level
    @level = Level.find(params[:id])
  end
end
