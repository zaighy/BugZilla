class ProjectsController < ApplicationController

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to projects_path, alert: exception.message
  end

  def index
    #@projects = current_user.projects.all unless current_user.has_role?(:Manager) || current_user.has_role?(:QA)

    @projects = current_user.projects.all
  end

  def new
    @project = Project.new
    @dev = User.with_role :Developer
    @qa = User.with_role :QA

    @dev_ops = @dev.map { |x| [x.name, x.id] }
    @qa_ops = @qa.map { |x| [x.name, x.id] }

  end

  def edit
    @project = current_user.projects.find(params[:id])
    @dev = User.with_role :Developer
    @qa = User.with_role :QA

    @dev_ops = @dev.map { |x| [x.name, x.id] }
    @qa_ops = @qa.map { |x| [x.name, x.id] }
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:danger] = "Project was Successfully Deleted!"
    redirect_to projects_path
  end

  def create
    #render plain: params[:project].inspect
    # @project = current_user.projects.new(project_params)
    users = project_params[:user_ids]
    users.push current_user.id.to_s
    final_params = project_params.merge(user_ids: users)
    @project = Project.new(final_params)

    if @project.save
      flash[:success] = "Project was Successfuly Added!"
      redirect_to projects_path(@project)
    else
      render 'new'
    end
  end

  def update

    users = project_params[:user_ids]
    users.push current_user.id.to_s
    final_params = project_params.merge(user_ids: users)

    @project = Project.find(params[:id])
    if @project.update(final_params)
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
    params.require(:project).permit(:title, :description, user_ids: [] )
  end

end