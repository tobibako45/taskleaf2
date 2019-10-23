FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'RSpec＆Capybara＆FactoryBotを準備する' }

    # userとだけ書いているが、
    # 「定義した:userという名前のFactoryを、Taskモデルに定義されたuserという名前の関連を生成するのに利用する」という意味。
    user

    # 関連名とファクトリ名が異なる場合はuserの代わりに次のような記述をする
    # association :user, factory: :admin_user

  end
end
