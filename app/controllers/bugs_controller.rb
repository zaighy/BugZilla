class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  authorize_resource class: false

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to project_bugs_path, alert: exception.message
  end

  # GET /bugs
  # GET /bugs.json
  def index
    @bugs = @project.bugs
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show
    @bug = @project.bugs.find(params[:id])
  end

  # GET /bugs/new
  def new
    @bug = @project.bugs.build

  end

  # GET /bugs/1/edit
  def edit
    @bug = @project.bugs.find(params[:id])
  end

  # GET /bugs/1/assign_me
  def assign_me

    @bug = Bug.find(params[:bug_id])
    respond_to do |ff|
      if @bug.update(assigned_to: current_user.id)
        ff.html { redirect_to assign_bug_path, notice: "#{@bug.bug_type} was assigned to #{current_user.name}"}
      else
        ff.html { render :index}
      end
    end
  end

  # GET /bugs/1/mark_status
  def mark_status
    @bug = Bug.find(params[:bug_id])
    if @bug.bug_type == "Feature"
      lbl = "Completed"
    elsif @bug.bug_type == "Bug"
      lbl = "Resolved"
    end
    respond_to do |ff|
      if @bug.update(status: lbl)
        ff.html { redirect_to project_bugs_path, notice: "#{@bug.bug_type} was marked as #{lbl}"}
      else
        ff.html { render :index}
      end
    end

  end

  # POST /bugs
  # POST /bugs.json
  def create

    @bug = @project.bugs.create(bug_params.merge(user_id: current_user.id, project_id: @project.id))

    respond_to do |format|
      if @bug.save
        format.html { redirect_to [@bug.project, @bug], notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1
  # PATCH/PUT /bugs/1.json
  def update

    @bug = @project.bugs.find(params[:id])

    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to [@bug.project, @bug], notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug = @project.bugs.find(params[:id])
    @bug.destroy

    respond_to do |format|
      format.html { redirect_to project_bugs_url, notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:title, :bug_type, :status, :deadline)
    end
end
