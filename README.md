# photo-contest-crawler(pcc)

東○カメラ部のWebサイトに掲載されている開催中のフォトコンテスト情報を取得するためのクローラーです。  
取得したフォトコンテスト情報は、Googleカレンダーに登録されます。

## 使用したライブラリなど
- Docker
- Ruby on Rails
- Devise
- Omniauth (GitHub)
- Sidekiq
- Google Calendar API
- AdminLTE

## セットアップ
```
$ make all
```

## 起動
```
$ make run
```
http://localhost:13000 にアクセス

## スクリーンショット
<img width="1508" alt="スクリーンショット 2024-05-24 23 41 44" src="https://github.com/Layer021/pcc/assets/28092171/6b8a5f1d-fcc0-45ae-81a8-122a59e96139">

<img width="770" alt="スクリーンショット 2024-05-24 23 42 10" src="https://github.com/Layer021/pcc/assets/28092171/35aecb9d-ae7c-4e3a-8535-7716ae096a16">

