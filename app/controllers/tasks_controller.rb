class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = "Taskの登録に成功"
            redirect_to tasks_path
        else
            flash.now[:feild] = "Taskの登録に失敗"
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "Taskの更新に成功"
            redirect_to tasks_path
        else
            flash.now[:feild] = "Taskの更新に失敗"
            render :edit
        end
    end

    def destroy
        @task = Task.find(params[:id])
        
        if @task.destroy
            flash[:success] = "Taskの削除に成功"
            redirect_to tasks_path
        else
            flash.now[:feild] = "Taskの削除に失敗"
            render :index
        end
    end
    
    #Strong Parameter
    private
    def task_params
        params.require(:task).permit(:content)
    end

end
