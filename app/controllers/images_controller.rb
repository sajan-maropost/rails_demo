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
  	p @image
  	if @image.save
  		flash[:notice] = "Image uploaded successfully"
  		redirect_to gallery_path
  	else
  		render 'new'
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

end
