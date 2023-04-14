class ProjectsController < ApplicationController
   before_action :set_project, only: [:show, :edit, :update, :destroy]
    
   def index
    if current_user
        if current_user.user_type == "0"
            @projects = current_user.projects 
          end
          if current_user.user_type == "1"
            @projects = current_user.assigned_projects 
          end
          if current_user.user_type == "2"
            @projects = current_user.assigned_projects 
          end
    else
     redirect_to root_path
    end   
        #   binding.pry 
   end
    def new
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        @project.user = current_user
        if @project.save
          flash[:success] = "project was created successfully!"
          redirect_to project_path(@project)
        else
          render 'new', status: 300
        end
    end

    def show
    end

    def edit
    end

    def update
    
        if @project.update(project_params)
            flash[:success] = "Project was updated successfully!"
            redirect_to project_path(@project)
        else
            render 'edit'
    
        end
    end

    def destroy
        @project.destroy
        flash[:success] = "Project was updated successfully!"
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