FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@example.com' }
    password { 'password' }
  end

  # 上はクラスを:userという名前から自動で類推してくれるが、
  # ファクトリ名とクラスが異なる場合には、:classオプションでクラスを指定することができます。
  # factory :admin_user, class: User do

end
