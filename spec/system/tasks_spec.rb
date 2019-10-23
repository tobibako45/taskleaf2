require 'rails_helper'

describe 'タスク管理機能', type: :system do

  # 詳細表示機能もユーザーがログインしていることを前提にしているため、
  # 一覧表示機能のdescribeの中にあったログイン処理のbeforeを上の階層に移動させている。

  # letで定義(変数定義みたいな感じ)
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  # let!を使って、必ず作っておくようにする
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end


  # shared_exampls
  shared_examples_for 'ユーザーAが作成したタスクが表示される' do # 「ユーザーAが作成したタスクが表示される」で定義。この名前で参照される
    it { expect(page).to have_content '最初のタスク' }
  end


  describe '一覧表示機能' do

    context 'ユーザーAがログインしているとき' do
      # login_userを定義
      let(:login_user) { user_a }

      # it 'ユーザーAが作成したタスクが表示される' do
      #   expect(page).to have_content '最初のタスク'
      # end

      # 上記をこれに置き換え
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      # login_userを定義
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end


  describe '詳細表示機能' do

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      # it 'ユーザーAが作成したタスクが表示される' do
      #   expect(page).to have_content '最初のタスク'
      # end

      # 上記をこれに置き換え
      # it_behaves_like 'ユーザーAが作成したタスクが表示されるるるる' # これだとerror
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

  end




  describe '新規作成機能' do
    let(:login_user) { user_a }
    # デフォルトに設置
    let(:task_name) { '新規作成のテストを書く' }

    before do
      visit new_task_path
      # ログインするユーザーを変えたのと同様に、task_nameというletを利用して、
      # 続く２つのcontextでの違い(名称を入力するか？しないか？)を吸収する。
      fill_in '名称', with: task_name
      click_button '確認'
    end

    context '新規作成画面で名称を入力したとき' do
      # デフォルトに移動
      # let(:task_name) { '新規作成のテストを書く' }

      it '正常に登録される' do
        # have_selector HTML内の特定のセレクタ(CSSセレクタ)で指定することができる
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      # デフォルトを上書き
      let(:task_name) { '' }

      it 'エラーとなる' do
        # within withinブロックの中でpageの内容を検査することで、探索する範囲を画面内の特定の範囲に狭める。
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end

end
