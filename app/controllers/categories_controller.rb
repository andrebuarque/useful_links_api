class CategoriesController < ApplicationController

	def index
		begin
			render :json => Category.all
		rescue
			render :status => 500
		end
	end

	def show
		begin
			render :json => Category.find(params[:id])
		rescue
			render :status => 500
		end
	end

	def create
		begin
			Category.create(:name => params[:name])
			render :status => :ok
		rescue
			render :status => 500
		end
	end

	def update
		begin
			Category.update(params[:id], params.permit(:name))
			render :status => :ok
		rescue
			render :status => 500
		end
	end

	def destroy
		begin
			Category.find(params[:id]).delete
			render :status => :ok
		rescue
			render :status => 500
		end
	end
	
end
