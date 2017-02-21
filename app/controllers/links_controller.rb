class LinksController < ApplicationController

	before_action :set_link, :only => [:show, :update, :destroy]

	def index
		begin
			links = Link.eager_load(:category, :tags)
			render :json => links.as_json(:include => [:category, :tags])
		rescue
			render :status => 500
		end
	end

	def show
		begin
			render :json => @link
		rescue
			render :status => 500
		end
	end

	def create
		begin
			tags = params[:tags]

			Link.transaction do 
				link = Link.create(link_params)
				link.tags = create_tags(tags)
				link.save
			end

			render :status => :ok
		rescue
			render :status => 500
		end
	end

	def update
		begin
			tags = params[:tags]
			
			Link.transaction do
				@link.title = link_params[:title]
				@link.url = link_params[:url]
				@link.category_id = link_params[:category_id]
				@link.tags = create_tags(tags)

				@link.save
			end

			render :status => :ok

		rescue
			render :status => 500
		end
	end

	def destroy
		begin
			@link.destroy
			render :status => :ok
		rescue
			render :status => 500
		end
	end

	private

		def set_link
			@link = Link.includes(:tags).find(params[:id])
		end

		def create_tags(tags)
			tags.map do |tag|
				Tag.exists?(tag) ? Tag.find(tag) : Tag.create(:name => tag)
			end
		end

		def link_params
			params.require(:link).permit(:title, :url, :category_id)
		end

end
