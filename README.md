## table schema
### [ column : type ]
<br>


| User            | Label              | Task                 |
| :---:           | :---:              | :---:                |
| user_name:string| user_id:references | user_id:references   |
| email:string    | task_id:references |  title:string        |
| password_digest:string | label_name:string|content:text     |
|                 |                    | priority:integer     |
|                 |                    | expired_at:datetime  |
|                 |                    | status:integer       |

<HR>

## Heroku deploy flow

### GemfileにGemを追加する（Ruby３系を使用している場合）
```
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
```
作成しているアプリのディレクトリに行き - heroku create
git commitコマンドを使用して、コミット
1. `git add` <br>
   `git commit` <br>
Heroku buildpackを追加する
2. `heroku buildpacks:set heroku/ruby` <br>
   `heroku buildpacks:add --index 1 heroku/nodejs`<br>
heroku stack:set heroku- を行いバージョンを変更する
3. `heroku stack:set heroku-20`<br>
heroku stack で現在使われているstackを確認
4. `heroku stack`<br>
package.json に追加記述
5. `"engines": { "node": "16.x" }`<br>
Herokuにデプロイ
6. `git push heroku step2:master`<br>
データベースの移行
7. `heroku run rails db:migrate`