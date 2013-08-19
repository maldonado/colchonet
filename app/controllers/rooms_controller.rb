class RoomsController < ApplicationController
  
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(params[:room])

      if @room.save
        redirect_to @room, :notice => t('flash.notice.room_created')
      else
        render :action => "new"
      end
  end

  def update
    @room = Room.find(params[:id])

    if @room.save
      redirect_to @room, :notice => t('flash.notice.room_updated')
    else
      render :action => "edit"
    end
    
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    
    redirect_to rooms_url
  end
  
end
