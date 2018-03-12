class RoomsController < ApplicationController
  before_action :set_room, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :pdf_upload, :event, :equipment, :location, :update]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build

  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to listing_room_path(@room), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong ..."
      render :new
    end
  end

  def show
    @photos = @room.photos
    @guest_reviews = @room.guest_reviews
    @pdfs = @room.pdfs
  end

  def listing
    @rooms = current_user.rooms
  end

  def pricing
    @rooms = current_user.rooms
  end

  def description
    @rooms = current_user.rooms
  end

  def photo_upload
    @photos = @room.photos
  end

  def pdf_upload
    @pdfs = @room.pdfs
  end

  def event
    @rooms = current_user.rooms
  end

  def equipment
    @rooms = current_user.rooms
  end

  def location
    @rooms = current_user.rooms
  end

  def update

    new_params = room_params
    new_params = room_params.merge(active: true) if is_ready_room

    if @room.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer)
  end

# --- RESERVATIONS ---
def preload
  today = Date.today
  reservations = @room.reservations.where("(start_date >= ? OR end_date >= ?) AND status = ?", today, today, 1)
  unavailable_dates = @room.calendars.where("status = ? AND day > ?", 1, today)

  special_dates = @room.calendars.where("status = ? AND day > ? AND price <> ?",0, today, @room.price)

  render json: {
        reservations: reservations,
        unavailable_dates: unavailable_dates,
        special_dates: special_dates
    }
end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date, @room)
    }

    render json: output
  end


private
  def is_conflict(start_date, end_date, room)
    check = room.reservations.where("(? < start_date AND end_date < ?) AND status = ?", start_date, end_date, 1)
    check_2 = room.calendars.where("day BETWEEN ? AND ? AND status = ?", start_date, end_date, 1).limit(1)

    check.size > 0 || check_2.size > 0 ? true : false
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def is_authorised
    redirect_to root_path, alert: "You don't have permission" unless current_user.id == @room.user_id
  end

  def is_ready_room
    !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.photos.blank? && !@room.address.blank?
  end

  def room_params
    params.require(:room).permit(:room_type, :volume, :surface, :listing_name, :summary, :address,
      :is_table, :is_chair, :is_kitchen, :is_wc, :is_parking, :is_outdoor, :is_tv, :is_projector,
      :is_stage, :is_shower, :is_sound, :is_bar, :is_air, :is_heating, :is_wifi, :is_decoration,
      :is_wedding, :is_baptism, :is_birthday, :is_special, :is_meeting, :is_lotto, :is_gathering,
      :is_concert, :is_show, :is_seminary, :is_conference, :price, :pricelocal, :priceasso, :active, :instant)
    end

end
