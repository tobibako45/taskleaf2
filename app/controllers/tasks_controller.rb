class TasksController < ApplicationController
  # @tasks = current_user.tasks.find(params[:id])を、privateメソッドのset_taskにまとめてDRYに。
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    # @tasks = Task.all

    # ログインしているユーザーに紐づくデータだけを表示
    # @tasks = current_user.tasks.order(created_at: :desc) # 登録順
    # @tasks = current_user.tasks.recent # 上のscope版

    # 検索ransack
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).recent
  end

  def show
    # @task = Task.find(params[:id])

    # ログインしているユーザーに紐づくデータだけを表示
    # @task = current_user.tasks.find(params[:id])    # privateのset_taskでDRYにしてbefore_actionに設定
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


    # 戻るボタンの対応
    # params[:back]は「戻るボタン」のname
    if params[:back].present?
      render :new
      return
    end

    # if @task.save! だとテストが通らない！ダメなら例外を発生させる
    if @task.save # ダメならnilを返す

      ###### ロガー #######

      # loggerオブジェクトのdebugメソッドを呼び、ログにタスク情報をdebugレベルで出力する
      logger.debug "これが自分で出したログね。task: #{@task.attributes.inspect}"

      # デバッグ用に、保存したタスクの情報をログに出力させたい場合。
      # logger.debug "タスク： #{@task.attributes.inspect}"
      # log/developments.log に出力
      logger.debug 'logger に出力'
      # logger.formatter.debug

      # log/custom.log に出力。なければ作成。
      Rails.application.config.custom_logger.debug 'custom_logger にも出力してる'

      # taskに関するログだけを専用ファイルに出力
      task_logger.debug 'taskのログを出力'


      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  # 確認画面
  def confirm_new
    # 新規登録画面からparameterを元に、current_userのtaskオブジェクトを作成して代入
    @task = current_user.tasks.new(task_params)
    # unlessで、taskオブジェクトがなければ、new(新規登録画面)に戻す。
    render :new unless @task.valid? # .valid? バリデーションが実行。通ればtrue。invalid?は逆
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

  # オリジナルのロガー taskに関するログだけファイル出力
  def task_logger
    @task_logger ||= Logger.new('log/task.log', 'daily')
  end

end
