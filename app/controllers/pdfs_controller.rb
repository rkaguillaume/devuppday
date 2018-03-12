class PdfsController < ApplicationController

  def create
    @room = Room.find(params[:room_id])

    if params[:contrats]
      params[:contrats].each do |pdf|
        @room.pdfs.create(contrat: pdf)
      end

      @photos = @room.pdfs
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

  def destroy
    @pdf = Pdf.find(params[:id])
    @room = @pdf.room

    @pdf.destroy
    @pdfs = Pdf.where(room_id: @room.id)

    respond_to :js
  end


end
