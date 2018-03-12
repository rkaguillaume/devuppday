class ReservationMailer < ApplicationMailer
  def send_email_to_guest(guest, room)
    @recipient = guest
    @room = room
    mail(to: @recipient.email, subject: "Réservation acceptée ! 🚀")
  end

  def send_email_to_request(request, room)
    @recipient = request
    @room = room
    mail(to: @recipient.email, subject: "Demande de réservation envoyée  ! 🚀")
  end


  def send_email_to_host(host, room)
    @recipient = host
    @room = room
    mail(to: @recipient.email, subject: "Nouvelle demande de Réservation ! 🚀")
  end
end
