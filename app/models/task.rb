class Task < ApplicationRecord
  # validates :name, presence: true
  # validates :name, length: {maximum: 30}

  # 一行で
  # validates :name, presence: true, length: {maximum: 30} # Specを失敗させるためコメントアウト

  # 検証用メソッド「validate_name_not_including_comma」という名前にして、
  # それをvalidateというクラスメソッドに渡すことにより、
  # これを検証のために利用するということをTaskモデルクラスに知らせる
  validate :validate_name_not_including_comma

  # userに従属していることの関連付け
  belongs_to :user

  # スコープ
  # recent(最近)という名前で登録
  scope :recent, -> { order(created_at: :desc) }

  private

  # カンマではなく名前を検証する
  def validate_name_not_including_comma
    # カンマが含まれているかをinclude?でチェック。
    # &.でnameがnilのときには検証が通る(errors.addしない)ようにしている
    errors.add(:name, 'カンマを含めることはできません') if name&.include?(',')
  end

  # include? 含まれるときはtrue、含まれないときはfalse
  # &. ぼっち演算子 xxxがnilでないときにメソッドyyyを呼び出す。
end

