require 'rails_helper'

RSpec.describe 'ユーザー管理機能' , type: :system do
  let(:user1) { FactoryBot.create(:user1) }
  let(:user2) { FactoryBot.create(:user2) }

  describe 'ユーザ登録のテスト' do
    context '新規登録画面に遷移した場合' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_path
        fill_in 'user_name', with: '坂本'
        fill_in 'user_email', with: 'sakamoto@dive.com'
        fill_in 'user_password', with: 'sakamoto'
        fill_in 'user_password_confirmation', with: 'sakamoto'
        click_on "登録"
        expect(page).to have_content '坂本'
      end
    end

    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ログインした場合' do
      it '自分の詳細画面(マイページ)に飛べる' do
        visit new_user_path
        fill_in 'user_name', with: '坂本'
        fill_in 'user_email', with: 'sakamoto@dive.com'
        fill_in 'user_password', with: 'sakamoto'
        fill_in 'user_password_confirmation', with: 'sakamoto'
        click_on "登録"
        expect(page).to have_content '坂本のページ'
      end
    end

    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session[email]', with: user1.email
        fill_in 'session[password]', with: user1.password
        click_on "Log in"
        sleep(1)
        visit user_path(user2)
        expect(current_path).to eq tasks_path
      end
    end

    context 'ログイン後' do
      it 'ログアウトができる' do
      visit new_session_path
      fill_in 'session_email', with: user1.email
      fill_in 'session_password', with: user1.password
      click_on "Log in"
      click_on "Logout"
      expect(current_path).to eq new_session_path
      end
    end
  end
end