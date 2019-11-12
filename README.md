# atcoder_ogpとは

GitHub PagesとGitHub Actionsを利用した、AtCoderレーティング表示サービスです。

一定間隔ごとにAtCoderのレーティングのグラフを画像として保存し、GitHub PagesのOGPとして設定することで、

何度もグラフの画像を撮る必要がなくなります。

<img src="https://github.com/wawawatataru/atcoder_ogp/blob/master/docs/image/sample.png?raw=true" width="320px">

## 使い方
### 取得するAtCoderのレーティング画像の設定
`capture_rate.py`内でどのページの画像を取得するかを決めています。
```
driver.get("https://atcoder.jp/users/wawawatataru")
```
上記の`users/hogehoge`を自身のAtCoderのアカウント名に変更してください。

### OGPの設定
`docs/index.html`内でOGPの設定をしています。

```
<head>
~~~
    <meta property="og:url" content="https://wawawatataru.github.io/atcoder_ogp">
    <meta property="og:image" content="https://wawawatataru.github.io/atcoder_ogp/image/screenshot.png">
~~~
</head>
```
Twitterなどでリンクをクリックした際の遷移先とOGPに表示する画像を決めているので、
自身のGitHub PagesのURLと、自身のレーティングの画像を指定してください。
その後、リポジトリのSettingからGitHub Pagesとして公開する設定を行ってください。

### GitHub Actionsの設定
`.github/workflows/capture.yml`で実行間隔を設定しています。
```
on:
  schedule:
    - cron: "0 1 1-31 * *"
```
AtCoderのコンテストが終了する時刻に合わせて実行頻度を変更しても問題ないと思います。

また、GitHub ActionsからpushするためにACCESS_TOKENを設定しています。
```
      - name: Setup git
        env:
          ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }}
        run: |
          git config --local user.name GitHubActions
          git remote set-url origin https://wawawatataru:${ACCESS_TOKEN}@github.com/wawawatataru/atcoder_ogp.git
```
