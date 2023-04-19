# frozen_string_literal: true

# Ticket class
class TicketsController < ApplicationController
  # def index
  #   if current_user.assigned_projects.map(&:id).include?(params[:id].to_i)
  # || Project.find(params[:id].to_i).user_id == current_user.id
  #     @tickets = Project.find(params[:id]).tickets
  #     authorize! :read, Ticket
  #     @project = params[:id]
  #   else
  #     flash[:danger] = 'You are not allowed to view this page'
  #     redirect_to root_path
  #   end
  # end

  def show
    @ticket = Ticket.find(params[:id])
    authorize! :read, @ticket
  end

  def new
    @project = params[:id]
    @pro = Project.find(params[:id].to_i)
    authorize! :create, Ticket
    # binding.pry
    if current_user.user_type == 'QA'
      @ticket = Ticket.new
    else
      redirect_to @root_path
    end
  end

  def create
    @pro = Project.find(ticket_params[:project_id].to_i)
    @ticket = Ticket.new(ticket_params)
    authorize! :create, @ticket
    @ticket.user_id = current_user.id
    # binding.pry
    if @ticket.save
      # binding.pry
      flash[:success] = 'Bug was created successfully!'
      redirect_to ticket_path(@ticket)
    else
      # binding.pry
      render 'new', status: 300
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
    authorize! :edit, @ticket
  end

  def update
    @ticket = Ticket.find(params[:id])
    authorize! :edit, @ticket

    if @ticket.update(ticket_params)
      flash[:success] = 'Bug was updated successfully!'
      redirect_to ticket_path(@ticket)
    else
      render 'edit'

    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @project = @ticket.project.id
    authorize! :destroy, @ticket
    @ticket.destroy
    flash[:success] = 'Bug was updated successfully!'
    redirect_to tickets_path(id: @project)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :category, :status, :deadline, :project_id, :user_id,
                                   :image_url, :developer_id)
  end
end
