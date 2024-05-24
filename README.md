# photo-contest-crawler(pcc)

東○カメラ部のWebサイトに掲載されている開催中のフォトコンテスト情報を取得するためのクローラーです。  
取得したフォトコンテスト情報は、Googleカレンダーに登録されます。

## 使用したライブライなど
- Docker
- Ruby on Rails
- Devise
- Omniauth (GitHub)
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
