require 'rails_helper'

describe 'タスク管理機能', type: :system do

  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      # user_a = FactoryBot.create(:user)
      # ユーザーが複数のとき、一部内容を変更してデータ作るほうが良い
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')

      # 作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a) # 作ったtaskをuser_aに紐付け
    end

    context 'ユーザーAがログインしているとき' do
      before do
        ##### ユーザーAでログインする #####
        # 1,ログイン画面にアクセスする
        visit login_path
        # 2,メールアドレスを入力する
        fill_in 'メールアドレス', with: 'a@example.com'
        # 3,パスワードを入力する
        fill_in 'パスワード', with: 'password'
        # 4,「ログインする」ボタンを押す
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称(最初のタスク)が画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
        # expect(page).to   page(画面)に期待するよ...することを。
        # have_content '最初のタスク'   あるはずだよね、「最初のタスク」という内容が
      end
    end
  end

  context 'ユーザーBがログインしているとき' do
    before do
      # ユーザーBを作成しておく
      FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')

      ##### ユーザーBでログインする #####
      # 1,ログイン画面にアクセスする
      visit login_path
      # 2,メールアドレスを入力する
      fill_in 'メールアドレス', with: 'b@example.com'
      # 3,パスワードを入力する
      fill_in 'パスワード', with: 'password'
      # 4,「ログインする」ボタンを押す
      click_button 'ログインする'
    end

    it 'ユーザーAが作成したタスクが表示されない' do
      # ユーザーAが作成したタスクの名称(最初のタスク)が画面上に表示されていないことを確認
      expect(page).not_to have_content '最初のタスク'
      # expect(page).not_to   page(画面)に期待しない...することを。
      # have_content '最初のタスク'   あるはずだよね、「最初のタスク」という内容が
    end
  end

end
