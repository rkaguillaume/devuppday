class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    room = Room.find(params[:room_id])

    if current_user == room.user
      flash[:alert] = "Vous ne pouvez pas réserver votre propre salle !"
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date).to_i

      special_dates = room.calendars.where(
        "status = ? AND day BETWEEN ? AND ? AND price <> ?",
        0, start_date, end_date, room.price
      )

      @reservation = current_user.reservations.build(reservation_params)
      @reservation.room = room
      @reservation.price = room.price
      #@reservation.total = room.price * days
      #@reservation.save

      @reservation.total = room.price * (days - special_dates.count)
      special_dates.each do |date|
        @reservation.total += date.price
      end

      if @reservation.save
        if room.Request?
          flash[:notice] = "Requête envoyée !"
          send_host(@reservation.room, @reservation)
          send_request(@reservation.room, @reservation)
        else
          @reservation.Approved!
          flash[:notice] = "Réservation effectuée !"
        end

      else
        flash[:alert] = "Réservation impossible !"

      end


    end
      redirect_to room
  end


  def your_booking
    @booking = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @rooms = current_user.rooms
  end

  def approve
    charge(@reservation.room, @reservation)
    redirect_to your_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to your_reservations_path

  end


  private

  def charge(room, reservation)
    reservation.Approved!
    ReservationMailer.send_email_to_guest(reservation.user, room).deliver_later
  end

  def send_host(room, reservation)
    ReservationMailer.send_email_to_host(room.user, room).deliver_later
  end

  def send_request(room, reservation)
    ReservationMailer.send_email_to_request(reservation.user, room).deliver_later
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :question)
  end
end
