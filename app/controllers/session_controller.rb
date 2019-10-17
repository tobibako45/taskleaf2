class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session_params[:email])

    # &. ぼっち演算子 xxxがnilでないときにメソッドyyyを呼び出す。

    # authenticateメソッドは、has_secure_passwordを使うことで追加された認証のためのメソッド
    # 引数で受け取ったパスワードをハッシュ化して、
    # その結果がUserオブジェクト内部に保存されている、digestと一致するかを調べる
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
