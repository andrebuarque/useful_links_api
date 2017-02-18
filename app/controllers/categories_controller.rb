class CategoriesController < ApplicationController

	def index
		render :json => Category.all
	end

	def show
		render :json => Category.find(params[:id])
	end

	def create
		begin
			Category.create(:name => params[:name])
			render :status => :ok
		rescue Exception => e
			render :status => 500
		end
	end

	def update
		begin
			Category.update(params[:id], params.permit(:name))
			render :status => :ok
		rescue Exception => e
			render :status => 500
		end
	end

	def destroy
		begin
			Category.find(params[:id]).delete
			render :status => :ok
		rescue Exception => e
			render :status => 500
		end
	end
	
end
