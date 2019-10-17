class ApplicationController < ActionController::Base
  # helper_method指定することで、すべてのビューからも使える。コントローラー内のメソッドをビュー内から呼びたい時とかに使う
  helper_method :current_user

  private

  # ログインしているユーザーを取得する処理は、頻繁に必要になるのでココに移動
  def current_user
    # a ||= xxx
    # 「||」演算子の自己代入演算子。aが偽か未定義なら、aにxxxを代入する、という意味。a || (a = true) と同じ
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
