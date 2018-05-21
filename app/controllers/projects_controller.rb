class ProjectsController < ApplicationController

  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to projects_path, alert: exception.message
  end
  def index
    @projects = current_user.projects.all unless current_user.has_role?(:Manager) || current_user.has_role?(:QA)
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:danger] = "Project was Successfully Deleted!"
    redirect_to projects_path
  end

  def create
    #render plain: params[:project].inspect
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project was Successfuly Added!"
      redirect_to projects_path(@project)
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      flash[:success] = "Project was Successfully Updated"
      redirect_to projects_path(@project)
    else
      render 'edit'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private
  def project_params
    #allow the object to create instance
    params.require(:project).permit(:title, :description)
  end

end