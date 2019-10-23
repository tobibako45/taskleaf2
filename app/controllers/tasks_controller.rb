class TasksController < ApplicationController
  # @tasks = current_user.tasks.find(params[:id])を、privateメソッドのset_taskにまとめてDRYに。
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    # @tasks = Task.all

    # ログインしているユーザーに紐づくデータだけを表示
    # @tasks = current_user.tasks.order(created_at: :desc) # 登録順
    @tasks = current_user.tasks.recent # 上のscope版
  end

  def show
    # @task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを表示
    # @task = current_user.tasks.find(params[:id])    # privateのset_taskでDRYにしてbefore_actionに設定
  end

  def new
    @task = Task.new
  end

  # def create
  #   @task = current_user.tasks.new(task_params)
  #
  #   if @task.save
  #     redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
  #   else
  #     render :new
  #   end
  # end

  def create
    # @task = Task.new(task_params)

    # userと紐付けたことで、ログインしているユーザーのuser_idも代入する必要がある
    # @task = User.new(task_params.merge(user_id: current_user))

    # 関連を利用して記述。こっちが良い
    @task = current_user.tasks.new(task_params)

    # if @task.save! だとテストが通らない！ダメなら例外を発生させる
    if @task.save # ダメならnilを返す
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    # @task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを表示
    # @task = current_user.tasks.find(params[:id])    # privateのset_taskでDRYにしてbefore_actionに設定
  end

  def update
    # task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを表示
    # @task = current_user.tasks.find(params[:id])    # privateのset_taskでDRYにしてbefore_actionに設定

    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    # task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを表示
    # @task = current_user.tasks.find(params[:id])    # privateのset_taskでDRYにしてbefore_actionに設定

    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  # taskの設定をDRYに
  def set_task
    @task = current_user.tasks.find(params[:id])
  end


end
