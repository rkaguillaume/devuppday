class RevenuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms

    @reservations = Reservation.current_week_revenue(current_user)

    @this_week_revenue = @reservations.map {|r| {r.updated_at.strftime("%Y-%m-%d") => r.total} }
                                      .inject({}) {|a,b| a.merge(b){|_,x,y| x + y }}

    @this_week_revenue = Date.today().all_week.map{ |date| [date.strftime("%d-%a"), @this_week_revenue[date.strftime("%Y-%m-%d")] || 0 ] }


    @reservation = Reservation.current_month_revenue(current_user)

    @this_month_revenue = @reservation.map {|r| {r.updated_at.strftime("%Y-%m-%d") => r.total} }
                                      .inject({}) {|a,b| a.merge(b){|_,x,y| x + y}}

    @this_month_revenue = Date.today().all_month.map{ |date| [date.strftime("%d"), @this_month_revenue[date.strftime("%Y-%m-%d")] || 0 ] }


    @reserv = Reservation.current_year_revenue(current_user)

    @this_year_revenue = @reserv.map {|r| {r.updated_at.strftime("%Y-%m-%d") => r.total} }
                                      .inject({}) {|a,b| a.merge(b){|_,x,y| x + y}}

    @this_year_revenue = Date.today().all_year.map{ |date| [date.strftime("%m"), @this_year_revenue[date.strftime("%Y-%m-%d")] || 0 ] }
  end





end
