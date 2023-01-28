require 'rails_helper'

RSpec.describe 'ユーザー管理機能' , type: :system do


  describe 'ユーザ登録のテスト' do
    context '新規登録画面に遷移した場合' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_path
        fill_in 'user_name', with: '坂本'
        fill_in 'user_email', with: 'sakamoto@dive.com'
        fill_in 'user_password', with: 'sakamoto'
        fill_in 'user_password_confirmation', with: 'sakamoto'
        sleep(4)
        click_on "登録"
        expect(page).to have_content '坂本'
      end
    end
  end
end