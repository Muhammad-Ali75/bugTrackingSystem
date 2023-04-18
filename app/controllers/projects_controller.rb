class ProjectsController < ApplicationController

   before_action :set_project, only: [:show, :edit, :update, :destroy]
    
   def index
    authorize! :read, Project

    if current_user
        if current_user.user_type == "manager"
            @projects = current_user.projects 
            
          end
          if current_user.user_type == "QA"
            @projects = current_user.assigned_projects 

          end
          if current_user.user_type == "Developer"
            @projects = current_user.assigned_projects 

          end
    else
     redirect_to root_path
    end   
        #   binding.pry 
   end
    def new
      @project = Project.new
      authorize! :create, @project
    end

    def create
      @project = Project.new(project_params)
      @project.user = current_user
      authorize! :create, @project
      if @project.save
          flash[:success] = "project was created successfully!"
          redirect_to project_path(@project)
        else
          render 'new', status: 300
        end
    end

    def show
      authorize! :read, @project
    end

    def edit
      authorize! :edit, @project
    end

    def update
      authorize! :edit, @project
        if @project.update(project_params)
            flash[:success] = "Project was updated successfully!"
            redirect_to project_path(@project)
        else
            render 'edit'
    
        end
    end

    def destroy
        authorize! :destroy, @project
        @project.destroy
        flash[:success] = "Project was deleted successfully!"
        redirect_to projects_path 
    end

    private
    def project_params
        params.require(:project).permit(:name, :description, user_ids: [])
    end
   
    def set_project
            @project=Project.find(params[:id])
    end
        
end