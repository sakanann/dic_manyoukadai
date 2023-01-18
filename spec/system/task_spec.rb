require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  let!(:task) { FactoryBot.create(:task, title: 'task') }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'test'
        fill_in 'task[content]', with: 'test'
        click_on '登録する'
        expect(page).to have_content 'test'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task1')
        visit tasks_path
        expect(page).to have_content 'task1'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list.first).to have_content 'task'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
        task = FactoryBot.create(:task)
        # task = FactoryBot.create(:task)
        visit tasks_path
        task_list = all('.task_row')
        click_on "終了期限"
        # expect(task_list[0]).to have_content 'うにゃ'
        expect(task_list[1]).to have_content 'むにゃ'
      end
    end
  end
  
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task', content: 'task')
        visit task_path(task)
        expect(page).to have_content 'task'
      end
    end
  end
end