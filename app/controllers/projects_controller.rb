# frozen_string_literal: true

# Project class
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  def index
    authorize! :read, Project
    if current_user
      @pagy, @projects = pagy(related_project, items: 3)
    else
      redirect_to root_path
    end
  end

  def new
    @project = Project.new
    authorize! :create, @project
  end

  def create
    @project = Project.new(params.require(:project).permit(:name, :description))
    @project.user = current_user
    authorize! :create, @project
    if @project.save
      @project.update(project_params)
      flash[:success] = 'Project was created successfully!'
      redirect_to project_path(@project)
    else
      render 'new', status: 300
    end
  end

  def show
    authorize! :read, @project
    @pagy, @tickets = pagy(@project.tickets, items: 5)
  end

  def edit
    authorize! :edit, @project
    @users = @project.users
  end

  def update
    authorize! :edit, @project
    if @project.update(project_params)
      flash[:success] = 'Project was updated successfully!'
      redirect_to project_path(@project)
    else
      render 'edit'

    end
  end

  def destroy
    authorize! :destroy, @project
    @project.destroy
    flash[:success] = 'Project was deleted successfully!'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, user_ids: [])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def related_project
    if current_user.manager?
      current_user.projects
    else
      current_user.assigned_projects
    end
  end
end
