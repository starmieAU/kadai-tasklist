class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        if logged_in?
            @tasks = current_user.tasks.all
        end
        #flashtest
        #index -> show , index -> edit なら flash情報が残ってた
        #index -> show -> edit なら index -> edit の段階でflash情報が消えた
        #flash.nowはどちらの場合でも消えた
        #画面更新でflashは消えるみたい
        #render アクション(ここなら'index')があると考えていい
    end
    
    def show
    end
    
    def new
        @task = current_user.tasks.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = "Taskの登録に成功"
            redirect_to tasks_path
        else
            flash.now[:failed] = "Taskの登録に失敗"
            render :new
        end
    end
    
    def edit
    end
    
    def update

        if @task.update(task_params)
            flash[:success] = "Taskの更新に成功"
            redirect_to tasks_path
        else
            flash.now[:failed] = "Taskの更新に失敗"
            render :edit
        end
    end

    def destroy

        if @task.destroy
            flash[:success] = "Taskの削除に成功"
            redirect_to tasks_path
        else
            flash.now[:feild] = "Taskの削除に失敗"
            render :index
        end
    end
    
    private
    def flashtest
        flash[:test_redirect_to] = 'redirect_toされた'
        flash.now[:test_render] = 'renderされた'
    end

    def set_task
        @task = current_user.tasks.find(params[:id])
    end
    #Strong Parameter
    def task_params
        params.require(:task).permit(:content,:status)
    end

end
