require 'rails_helper'

describe TaskMailer, type: :mailer do
  # 共通的なテストデータとしてtaskとうletを用意
  let(:task) { FactoryBot.create(:task, name: 'メイラーのSpecを書く', description: '送信したメールの内容を確認します') }

  # 手軽にmailという名前で参照できるように想定
  # let text_bodyにtext形式の内容入れる
  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
    part.body.raw_source
  end

  # let html_bodyにhtml形式の内容入れる
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
    part.body.raw_source
  end

  describe '#creation_email' do
    # TaskMailerのcreation_emailメソッドを使って、メール生成し、生成したオブジェクトをmailというletに定義
    let(:mail) { TaskMailer.creation_email(task) }

    # そのmailから、内容を参照してチェック

    it '想定どおりのメールが生成されている' do
      # ヘッダ
      expect(mail.subject).to eq('タスク作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['taskleaf2@example.com'])

      # text形式メールの本文
      expect(text_body).to match('以下のタスクを作成しました。')
      expect(text_body).to match('メイラーのSpecを書く')
      expect(text_body).to match('送信したメールの内容を確認します')

      # html形式メールの本文
      expect(html_body).to match('以下のタスクを作成しました。')
      expect(html_body).to match('メイラーのSpecを書く')
      expect(html_body).to match('送信したメールの内容を確認します')
    end

  end

end
