class TasksController < ApplicationController
  def index
    # @tasks = Task.all

    # ログインしているユーザーに紐づくデータだけを表示
    @tasks = current_user.tasks
  end

  def show
    # @task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを表示
    @tasks = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params)

    # userと紐付けたことで、ログインしているユーザーのuser_idも代入する必要がある
    # @task = User.new(task_params.merge(user_id: current_user))

    # 関連を利用して記述。こっちが良い
    @task = current_user.tasks.new(task_params)

    if @task.save!
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end

  end

  def edit
    # @task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを表示
    @task = current_user.tasks.find(params[:id])
  end

  def update
    # task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを検索
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    # task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを検索
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
