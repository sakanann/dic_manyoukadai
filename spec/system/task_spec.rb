require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'test'
        fill_in 'task[content]', with: '内容'
        fill_in 'task_expired_at', with: DateTime.new(2021, 8, 1, 10, 30)
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'

        click_on '登録する'
        
        expect(page).to have_content 'test'
        expect(page).to have_content '内容'
        expect(current_path).to eq '/tasks'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
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
        task = FactoryBot.create(:task)
        visit tasks_path
        task_list = all('.task_row')

        expect(task_list.first).to have_content '坂本'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
        # task = FactoryBot.create(:task, expired_at: '2022-01-18')
        task = FactoryBot.create(:task, expired_at: '2022-01-17')
        #facboの呼び出してるがカラム指定してるから関係あまりなし
        # task = FactoryBot.create(:task)
        visit tasks_path
        # tasks_path(sort_expired_at: "true")
        task_list = all('.task_row')
        click_link "終了期限"
        # expect(task_list[0]).to have_content '2022-01-18'
        expect(task_list.first).to have_content '2022-01-17'
      end
    end

    # context 'タスクが優先順位の降順に並んでいる場合' do
    #   it '優先順位が高いものから表示する' do
    #     task = FactoryBot.create(:task, priority: '2022-02-01')
    #     #facboの呼び出してるがカラム指定してるから関係あまりなし
    #     # task = FactoryBot.create(:task)
    #     visit tasks_path
    #     tasks_path(sort_priority: "true")
    #     task_list = all('.task_row')
    #     click_on "優先順位"

    #     expect(task_list[0]).to have_content '2022-02-01'
    #     # expect(task_list.first).to have_content '2022-02-01'
    #   end
    # end
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


  describe '検索機能' do

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        task1 = FactoryBot.create(:task, title: '万葉課題ステップ3')
        task2 = FactoryBot.create(:task, title: 'マイクロソフト')
        task3 = FactoryBot.create(:task, title: 'RSpec')
        visit tasks_path
        fill_in 'task[title]', with: '万葉' 
        #fill_in 'search[title]' ブラウザで検証ツールを使って検索窓のIDもしくはnameを確認する
        click_button "検索"
        expect(page).to have_content task1.title
        expect(page).not_to have_content task2.title
      end
    end
  
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        task1 = FactoryBot.create(:task, status: 0 )
        task2 = FactoryBot.create(:task, status: 1 )
        task3 = FactoryBot.create(:task, status: 2 )
        visit tasks_path
        select '完了', from: 'task_status'
        click_button "検索"
        expect(page).to have_content task3.status
        # expect(page).not_to have_content task1.status
      end
    end
  
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        task1 = FactoryBot.create(:task, title: '万葉課題ステップ3')
        task2 = FactoryBot.create(:task, title: 'マイクロソフト')
        task3 = FactoryBot.create(:task, title: 'RSpec')
        task4 = FactoryBot.create(:task, status: 0 )
        task5 = FactoryBot.create(:task, status: 1 )
        task6 = FactoryBot.create(:task, status: 2 )
        task7 = FactoryBot.create(:task, title: '万葉課題ステップ3', status: 2 )
        visit tasks_path
        fill_in 'task[title]', with: '万葉'
        select '完了', from: 'task[status]'
        click_button "検索"
        expect(page).to have_content task1.title
        expect(page).to have_content task6.status
        expect(page).not_to have_content task2.title
      end
    end
  end
end