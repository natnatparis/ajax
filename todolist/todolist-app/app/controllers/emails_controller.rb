class EmailsController < ApplicationController
	
	def index
		@emails = Email.all	
	end

	#Methode permettant de créer un email à l'aide de la Gem faker et cela en mode AJAX
	def create
		@email = Email.new(body: Faker::Hipster.paragraph, object: Faker::Hipster.sentence)
		 if @email.save
	    	respond_to do |format|
		      format.html { redirect_to root_path }
		      format.js { }
	    	end
	      flash[:notice] = "Email created"
	    else
	      redirect_to root_path
	      flash[:notice] = "Please try again"
	    end
  	end

  	#Méthode permettant d'afficher le contenu d'un email (que nous avons au préalable reçu)
  	def show
		@email = Email.find(params[:id])
	end

	def update
		
	end

	#Methode permettant de supprimer un email en mode AJAX
	def destroy
		@email = Email.find(params[:id])
	    @email.destroy
	    respond_to do |format|
		      format.html { redirect_to root_path }
		      format.js { }
	    end
	end

end
