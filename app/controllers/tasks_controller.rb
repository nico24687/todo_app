# frozen_string_literal: true

# TasksController handles all CRUD operations for tasks
# Includes filtering by completion status and sorting options
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_complete]

  # GET /tasks
  # Displays all tasks with optional filtering and sorting
  def index
    @tasks = Task.all

    # Apply filter based on completion status
    @tasks = apply_filter(@tasks)

    # Apply sorting
    @tasks = apply_sorting(@tasks)
  end

  # GET /tasks/:id
  # Shows a single task with all its details
  def show
  end

  # GET /tasks/new
  # Renders the new task form
  def new
    @task = Task.new
  end

  # POST /tasks
  # Creates a new task
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /tasks/:id/edit
  # Renders the edit task form
  def edit
  end

  # PATCH/PUT /tasks/:id
  # Updates an existing task
  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  # Deletes a task
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  # PATCH /tasks/:id/toggle_complete
  # Toggles the completed status of a task
  def toggle_complete
    @task.update(completed: !@task.completed)
    redirect_back fallback_location: tasks_path, notice: "Task marked as #{@task.completed? ? 'complete' : 'incomplete'}!"
  end

  private

  # Finds the task by ID for show, edit, update, destroy actions
  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tasks_path, alert: "Task not found."
  end

  # Strong parameters - only allow whitelisted attributes
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed, :priority)
  end

  # Applies filter based on the 'filter' parameter
  def apply_filter(tasks)
    case params[:filter]
    when "active"
      tasks.active
    when "completed"
      tasks.completed
    else
      tasks # 'all' or no filter returns everything
    end
  end

  # Applies sorting based on the 'sort' parameter
  def apply_sorting(tasks)
    case params[:sort]
    when "due_date"
      tasks.by_due_date
    when "priority"
      tasks.by_priority
    else
      tasks.by_created_at # Default: newest first
    end
  end
end
