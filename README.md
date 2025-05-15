# Webserv-DevSite 🧪

42Cursusの課題「Webserv」におけるHTTPサーバーの機能検証を効率化するために構築した検証用Webサイトです。<br>
実際のWebクライアント操作を通じて、webservの以下の機能を包括的に検証できます。<br>
Webserv本体のリポジトリは以下になります。

- [https://github.com/urabexon/42cursus_Webserv](https://github.com/urabexon/42cursus_Webserv)

## Usage💻
```bash
make w
```

上記のリポジトリからWebservをcloneし、以下を実行してサーバーを起動してください。
```bash
make
./webserv
```

上記2点を実行後、localhost:8082にアクセスしてください。

## Test Items Supported🔍

- **GET / POST / DELETE** メソッド検証（JSON/ファイル）
- **ファイルアップロード・ダウンロード**
- **ディレクトリリスティング**
- **リダイレクト処理**
- **カスタムエラーページ**
- **CGI（PHPスクリプト）**
- **タイムアウト・クラッシュ耐性テスト**
など

## Site Structure🧭
| パス                                   | 説明                        |
| ------------------------------------ | ------------------------- |
| `/`                                  | トップページ・ナビゲーション            |
| `/uploads`                           | ファイルアップロードテスト             |
| `/store`                             | アップロード後のファイル表示と削除         |
| `/protected-resource`                | JSONファイルへのGET/POST/DELETE |
| `/directory/`                        | ディレクトリリスティングテスト           |
| `/old-page → /new-page`              | リダイレクトテスト                 |
| `/cgi-test`                          | CGI（POST/GETなど）検証         |
| `/cgi-bin/test.php`                  | 環境変数・入力データ表示              |
| `/cgi-bin/memory_hog.php`            | メモリ消費テスト                  |
| `/cgi-bin/infinite_loop.php`         | タイムアウトテスト                 |
| `/cgi-bin/crash_test.php`            | PHPクラッシュテスト               |
| `/error/404.html`, `/error/500.html` | カスタムエラーページ                |

## License📄

This project is licensed under the [MIT License](./LICENSE).