class TagsController < ApplicationController
	def index
		begin
			render :json => Tag.all
		rescue
			render :status => 500
		end
	end

	def show
		begin
			render :json => Tag.find(params[:id])
		rescue
			render :status => 500
		end
	end

	def create
		begin
			Tag.create(:name => params[:name])
			render :status => :ok
		rescue
			render :status => 500
		end
	end

	def update
		begin
			Tag.update(params[:id], params.permit(:name))
			render :status => :ok
		rescue
			render :status => 500
		end
	end

	def destroy
		begin
			Tag.find(params[:id]).delete
			render :status => :ok
		rescue
			render :status => 500
		end
	end
end
