class ApplicationController < ActionController::Base



  # helper_method指定することで、すべてのビューからも使える。コントローラー内のメソッドをビュー内から呼びたい時とかに使う
  helper_method :current_user
  # アクション前に呼ばれるbefore_actionメソッドに登録。今回はonlyは指定せず、すべてのアクションに対して有効
  # でも、SessionControllerはログインしていなくても使える様にしないといけないので、あっちでskip_before_actionを設定
  before_action :login_required

  private

  # ログインしているユーザーを取得する処理は、頻繁に必要になるのでココに移動
  def current_user
    # a ||= xxx
    # 「||」演算子の自己代入演算子。aが偽か未定義なら、aにxxxを代入する、という意味。a || (a = true) と同じ
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ログインしているかどうかをcurrent_userで調べ、していなければログイン画面にリダイレクト
  def login_required
    redirect_to login_path unless current_user
  end

  # ログインしていなければ日本語
  def set_locale
    I18n.locale = current_user&.locale || :ja
  end

end
