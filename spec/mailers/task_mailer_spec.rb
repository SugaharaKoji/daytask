require 'rails_helper'

describe TaskMailer, type: mailer do

  let(:task){ FactoruBot.create(:task, name: 'メイラーを書く', description: '送信したメールの内容を確認します') }

  let(:text_part) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
    part.body.raw_source
  end

  describe '#creation_email' do
    let(:mail){ TaskMailer.creation_email(task) }

    it '想定どおりのメールが' do
      #ヘッダー
      expect(mail.subject).to eq('タスク作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['daytask@example.com'])

      # text形式の本文
      expect(text.body).to match('以下のタスクを作成しました')
      expect(text.body).to match('メイラーSpecを書く')
      expect(text.body).to match('送信したメールの内容を確認します')

      # html形式の本文
      expect(html.body).to match('以下のタスクを作成しました')
      expect(html.body).to match('メイラーSpecを書く')
      expect(html.body).to match('送信したメールの内容を確認します')
    end
  end
end
