class LinksController < ApplicationController
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
			render :json => Link.find(params[:id])
		rescue
			render :status => 500
		end
	end

	def create
		begin
			tags = params[:tags]

			Link.transaction do 
				link = Link.create(link_params)

				new_tags = tags.select { |id| !Tag.exists?(id) }
				existing_tags = (tags - new_tags).map { |t| Tag.find(t)  }
				
				new_tags = create_tags(new_tags) + existing_tags
				link.tags = new_tags
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
			link = Link.find(link_params[:id])

			

		rescue
			render :status => 500
		end
	end

	private

		def create_tags(tags)
			tags.map { |t| Tag.create(:name => t)  }
		end

		def link_params
			params.require(:link).permit(:title, :url, :category_id)
		end

end
