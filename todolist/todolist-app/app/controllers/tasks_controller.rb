class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category
    if @task.save
      #Ajout permettant de gérer l'éventualité selon laquelle le navigateur de l'utilisateur a désactivé JavaScript ou bien ne le supporte pas.
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { }
      flash[:notice] = "Task created"
      end
    else
      redirect_to root_path
      flash[:notice] = "Please try again"
    end
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    @task = Task.find(params[:id])
    @task.status = !@task.status
    @task.update(task_params)
    #Ajout permettant de gérer l'éventualité selon laquelle le navigateur de l'utilisateur a désactivé JavaScript ou bien ne le supporte pas.
      respond_to do |format|
          format.html { redirect_to tasks_path}
          format.js { }
      end
    flash[:notice] = "Task edited"
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    #Ajout permettant de gérer l'éventualité selon laquelle le navigateur de l'utilisateur a désactivé JavaScript ou bien ne le supporte pas.
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { }
      flash[:notice] = "Task deleted"
      end
  end


  private

  def task_params
    params.permit(:title, :deadline, :description)
  end

  def category_params
    params.require(:Category)
  end

end
