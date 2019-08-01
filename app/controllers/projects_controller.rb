class ProjectsController < ApplicationController

  before_action :confirm_logged_in, :only => [:create, :update, :destroy]

  def index
    @projects = Project.all
    if @projects.length == 0
      redirect_to new_project_path()
    else
      redirect_to project_path(@projects[0].id)
    end
    
  end

  def show
    @user = User.find(session[:user_id]) if session[:user_id]
    @allProjects = Project.all
    @project = Project.find(params[:id])
    @images = @project.image
  end

  def new
    @project = Project.new()
  end

  def create
    project = Project.create!(project_params)

    flash[:notice] = "#{project.title} was created successfully."
    redirect_to(projects_path())

  end

  def edit
    @project = Project.find(params[:id])
    @from = params[:from]
  end

  def update
    @project = Project.find(params[:id])
    # if params[:main_image] != nil
    #   @project.main_image.purge
    #   @project.main_image.attach(params[:main_image])
    # end
    

    # @project.image.attach(params[:image])
    if @project.update_attributes(project_params)
      
      flash[:notice] = "#{@project.title} was updated successfully."
      redirect_to(project_path(@project))

    else
      render('edit')
    end
  end

  def delete
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    flash[:notice] = "#{@project.title} was deleted successfully."
    flash[:success] = true
    redirect_to(projects_path())
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :publicUrl, :adminUrl, :gitUrl, :intro, :main_image, :position, image: [], :tech_ids => [])
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = 'You didnt think that Id let you change things did you? I just left it open for you to see my VERY simple, mostly unnecessary backend system as another entry in my portfolio.'
      if params[:id]
        redirect_to project_path(params[:id])
      else
        redirect_to projects_path()
      end
    end
  end
end
