class TicketsController < ApplicationController
 def index
    @tickets= Project.find(params[:id]).tickets
    @project=params[:id]
    # binding.pry
 end

 def show
    @ticket= Ticket.find(params[:id])
 end

 def new
    @project=params[:id]
    if current_user.user_type=="1"
    @ticket = Ticket.new
    else
        redirect_to @root_path
    end
 end

 def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id=current_user.id
        if @ticket.save
          flash[:success] = "project was created successfully!"
          redirect_to ticket_path(@ticket)
        else
          render 'new', status: 300
        end

 end

 def edit 
    @ticket=Ticket.find(params[:id])
 end

 def update
    @ticket=Ticket.find(params[:id])
    if @ticket.update(ticket_params)
        flash[:success] = "Ticket was updated successfully!"
        redirect_to ticket_path(@ticket)
    else
        render 'edit'

    end
end

 def destroy
        @ticket=Ticket.find(params[:id])
        @project=@ticket.project.id
        @ticket.destroy
        flash[:success] = "Project was updated successfully!"
        redirect_to tickets_path(id:@project)
 end

 private
 def ticket_params
     params.require(:ticket).permit(:title, :description, :category, :status, :deadline, :project_id, :user_id)
 end
end