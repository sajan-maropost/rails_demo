class ImagesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@images = MyImage.order(created_at: :desc).page params[:page]
  end

  def new
  	@image = MyImage.new
  end

  def create
  	@image = MyImage.new(name: params['my_image'][:name], image: params['my_image'][:image])
  	respond_to do |format|
      if @image.save
        format.html { redirect_to gallery_path, notice: 'Image uploaded successfully'}
        format.json { render json: { status: "Success", message: "Successful", code: 200 } }
      else
        format.html { render 'new' }
        format.json { render json: { status: "Failure", message: @image.errors.full_messages, code: 500 } }
      end
    end
  end

  def update
  	@image = MyImage.find_by_id(params[:id])

  	if @image
  		@image.name = params['my_image'][:name]
  		unless @image.save
  			@errors = @image.errors.full_messages
  		end
  	else
  		@errors = ["No such image found."]
  	end

  	respond_to do |format|
  		format.js
  	end
  end

  def import
    response = MyImage.import(params[:file])
    unless response[:error_message].present?
      message_string = "#{response[:success]} files imported successfully.<br/>"
      message_string += "#{response[:failed]} files failed to import."
      if response[:failed] > 0
        message_string += "<br /> Failed images detail:<br />"
        response[:failed_rows].each do |row|
          message_string += "Row Id: #{row.keys[0]} <br />"
          row[row.keys[0]].each do |message|
            message_string += message + "<br />"
          end
        end
      end
      flash[:notice] = message_string
      redirect_to gallery_path
    else
      @image = MyImage.new
      flash.now[:error] = response[:error_message]
      render 'new'
    end
  end

  def image_detail
    # checking if image id contains non numeric character
    if params[:id].match(/\A\d+\z/i).blank? # means it does have some non numeric character
      message = "Image id can be numeric only"
      respond_to do |format|
        format.html { redirect_to gallery_path, notice: message }
        format.json { render json: { status: "Failure", message: message, code: 500 } }
      end
    else
      @image = MyImage.find_by_id(params[:id])

      respond_to do |format|
        if @image.present?
          format.html
          format.json { 
            render json: { 
              status: "Success",
              message: "Successful",
              data: {name: @image.name, url: request.protocol + request.host_with_port + @image.image_url},
              code: 200 
            } 
          }
        else
          format.html { redirect_to gallery_path, notice: "No image found" }
          format.json { render json: { status: "Failure", message: "No image found", code: 500 } }
        end
      end
    end
  end

  def total_count
    sleep(1); # To test the loader
    @count = MyImage.all.size

    respond_to do |format|
      format.js
    end
  end
end
