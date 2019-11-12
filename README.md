[![GitHub Actions Status](https://github.com/wawawatataru/atcoder_ogp/workflows/capture_atcoder_rate/badge.svg?branch=master)](https://github.com/wawawatataru/atcoder_ogp/actions)

# atcoder_ogp とは

GitHub Pages と GitHub Actions を利用した、AtCoder レーティング表示サービスです。

一定間隔ごとに AtCoder のレーティングのグラフを画像として保存し、GitHub Pages の OGP として設定することで、

何度もグラフの画像を撮る必要がなくなります。

<img src="https://github.com/wawawatataru/atcoder_ogp/blob/master/docs/image/sample.png?raw=true" width="320px">

## 使い方

### 取得する AtCoder のレーティング画像の設定

`capture_rate.py`内でどのページの画像を取得するかを決めています。

```
driver.get("https://atcoder.jp/users/wawawatataru")
```

上記の`users/hogehoge`を自身の AtCoder のアカウント名に変更してください。

### OGP の設定

`docs/index.html`内で OGP の設定をしています。

```
<head>
~~~
    <meta property="og:url" content="https://wawawatataru.github.io/atcoder_ogp">
    <meta property="og:image" content="https://wawawatataru.github.io/atcoder_ogp/image/screenshot.png">
~~~
</head>
```

Twitter などでリンクをクリックした際の遷移先と OGP に表示する画像を決めているので、
自身の GitHub Pages の URL と、自身のレーティングの画像を指定してください。
その後、リポジトリの Setting から GitHub Pages として公開する設定を行ってください。

### GitHub Actions の設定

`.github/workflows/capture.yml`で実行間隔を設定しています。

```
on:
  schedule:
    - cron: "0 1 1-31 * *"
```

AtCoder のコンテストが終了する時刻に合わせて実行頻度を変更しても問題ないと思います。

また、GitHub Actions から push するために ACCESS_TOKEN を設定しています。

```
      - name: Setup git
        env:
          ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }}
        run: |
          git config --local user.name GitHubActions
          git remote set-url origin https://wawawatataru:${ACCESS_TOKEN}@github.com/wawawatataru/atcoder_ogp.git
```
