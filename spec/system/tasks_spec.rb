require 'rails_helper'

describe 'タスク管理機能', type: :system do

  #共通しているbeforeをまとめる(let)でユーザA,ユーザBを作成
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com')}
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com')}
  #作成者がユーザAであるタスクを作成
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a)}

  before do
    #ユーザA,Bでログインする#URLへアクセス[visit url]
    visit login_path

    #field操作[fili_in 'ラベルの名称', with: (let)]
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  # 共通しているitをまとめる(shared_examples_for)
  shared_examples_for 'ユーザAが作成したタスクが表示される' do
    it {expect(page).to have_content '最初のタスク'}
  end

  describe '一覧表示機能' do
    context 'ユーザAでログインしている時' do
      let(:login_user) { user_a }

      #作成済みのタスクの名称が画面上に表示されていることを確認
      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end

    context 'ユーザBでログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザAで作成したタスクが表示されない' do
        #ユーザAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザAがログインしている時' do
      let(:login_user) { user_a}

      before do
        visit task_path(task_a)
      end

      #作成済みのタスクの名称が画面上に表示されていることを確認
      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end
  end
end
