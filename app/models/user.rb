class User < ApplicationRecord
  # この記述で、DBのカラムに対応しない属性が２つ追加される
  # password属性 ユーザーの入力した生のパスワードを一時的に保管
  # password_confirmation属性 確認用パスワードを一時的に保管
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # 子分的な存在が複数いることの関連付け
  has_many :tasks
end
