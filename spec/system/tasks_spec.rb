require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    #共通機能(let)でユーザA,ユーザBを作成
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com')}
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com')}

    before do
      #作成者がユーザAであるタスクを作成
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)

      #ユーザA,Bでログインする#URLへアクセス[visit url]
      visit login_path
      #field操作[fili_in 'ラベルの名称', with: (let)]
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
    end

    context 'ユーザAでログインしている時' do
      let(:login_user) { user_a }

      it 'ユーザAで作成したタスクが表示される' do
        #作成済みのタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザBでログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザAで作成したタスクが表示されない' do
        #ユーザAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end
end
