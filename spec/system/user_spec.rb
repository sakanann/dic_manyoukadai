require 'rails_helper'

RSpec.describe 'ユーザー管理機能' , type: :system do
  let(:user) { FactoryBot.create(:user) }
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

  describe '管理画面のテスト' do
    context '管理ユーザが管理画面にアクセスした場合' do
      it '管理画面にアクセス出来る' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end

    context '一般ユーザが管理画面にアクセスした場合' do
      it '管理画面にアクセス出来ない' do
        visit new_session_path
        fill_in 'session[email]', with: user1.email
        fill_in 'session[password]', with: user1.password
        click_button "Log in"
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
    end

    context '管理ユーザーがユーザーの新規登録をした場合' do
      it 'ユーザの新規登録ができる' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit admin_users_path
        click_on "ユーザーを登録する"
        fill_in 'user[name]', with: 'mokemoke'
        fill_in 'user[email]', with: 'mokemoke@gmail.com'
        fill_in 'user[password]', with: 'mokemoke'
        fill_in 'user[password_confirmation]', with: 'mokemoke'
        select '一般ユーザー', from: :user_admin
        click_button "登録"
        visit admin_users_path
        expect(page).to have_content 'mokemoke'
      end
    end

    context '管理ユーザーはユーザーの詳細にアクセスをした場合' do
      it 'ユーザーの詳細画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit admin_users_path
        visit admin_user_path(user1)
        expect(current_path).to eq admin_user_path(user1)
      end
    end

    context '管理ユーザーはユーザーの編集画面で名前と権限を編集した場合' do
      it 'ユーザーの詳細画面で変更後の名前が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit admin_users_path
        visit edit_admin_user_path(user1)
        fill_in 'user[name]', with: user1.name
        fill_in 'user[email]', with: user1.email
        fill_in 'user[password]', with: user1.password
        fill_in 'user[password_confirmation]', with: user1.password
        select '一般ユーザー', from: :user_admin
        click_button "登録"
        visit admin_user_path(user1)
        expect(page).to have_content user1.name
      end
    end

    context '管理ユーザがユーザ一覧画面の削除をクリックした場合' do
      it 'ユーザの削除ができる' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit admin_users_path
        click_on '削除', match: :first
        # sleep(7)
        expect(page).to have_content user.name
        # expect(page).to have_content '管理者'
      end
    end
  end
end