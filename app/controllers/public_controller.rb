class PublicController < ApplicationController

  layout 'public'

  before_action :authenticate_user!, only: [:locked]
  before_action :authenticate_admin!, only: [:manage_content, :update_content]

  def locked
    p '---------------------------------'
    p session.delete(:logged_in).eql?(true)
    p '---------------------------------'
    render html: 'Hi'
  end

  def index
    @page = Page.find_by permalink: 'homepage'
    @facts = Fact.all.order position: :asc

    @deputy_testimonials = Testimonial.where testimonial_type: 'Deputy'
    @family_testimonials = Testimonial.where testimonial_type: 'Family'

    @video_deputy = Video.find_by position: 'homepage-deputy-video' rescue nil
    @video_family = Video.find_by position: 'homepage-family-video' rescue nil

    @content = TempDatum.first
    @data = TempDatum.new
  end

  def splash
    @content = TempDatum.first
    @data = TempDatum.new
  end

  def send_contact
    @data = TempDatum.new temp_datum_params
    if @data.save
      PostmanMailer.contact_form(@data).deliver_now
      respond_to do |format|
        format.json { format.json { render json: { message: 'Success' }, status: 200 } }
        format.html { redirect_to root_url, notice: "We've received your information. Thank you for re-registering!" }
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'Error!' }, status: 500 }
        format.html {
          @content = TempDatum.first
          render :splash
        }
      end
    end
  end

  def manage_content
    @data = TempDatum.first
  end

  def update_content
    @data = TempDatum.first
    if @data.update(temp_datum_params)
      redirect_to manage_content_path, notice: 'Successfully Updated'
    else
      render :manage_content
    end
  end

  private

  def temp_datum_params
    params.require(:temp_datum).permit :first_name, :last_name, :middle_initial, :email, :phone, :street1, :street2, :zipcode, :member_type, :content
  end

end
