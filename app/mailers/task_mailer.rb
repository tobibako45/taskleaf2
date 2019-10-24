class TaskMailer < ApplicationMailer
  # デフォルトの設定 fromのデフォルト
  default form: 'taskleaf2@example.com'

  # Task登録の通知メールを送る
  def creation_email(task)
    @task = task # テンプレートで利用したいので、インスタンス変数に
    # mailメソッドでメールの作成・送信
    mail(
      subject: 'タスク作成完了メール',
      to: 'user@example.com',
      from: 'taskleaf2@example.com'
    )
  end

end
