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
driver.find_element_by_id("rating-graph-expand").click()
png = driver.find_element_by_class_name("mt-2").screenshot_as_png
with open(image_path, "wb") as f:
    f.write(png)
```

上記の`users/hogehoge`を自身の AtCoder のアカウント名に変更してください。

撮影するスクリーンショットは`driver.find_element_by_class_name("mt-2")`で指定しています。

この場合は CSS セレクタの`mt-2`クラスを撮影します。

必要に応じて撮影箇所や範囲を変更してください。

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
    - cron: "0 1 * * *"
```

UTC での時刻設定のため、日本の時間に合わせるには+9 時間して考える必要があります。

AtCoder のコンテストが終了する時刻に合わせて実行頻度を変更しても問題ないと思います。

また、GitHub Actions から push するために github_token を利用しています。

ワークフローを実行するリポジトリに対する操作はこのトークンが自動的に設定されるため、

特に新しい設定をする必要はありません。

```
      - name: Setup git
        env:
          ACCESS_TOKEN: ${{ secrets.github_token }}
        run: |
          git config --local user.name GitHubActions
          git remote set-url origin https://wawawatataru:${ACCESS_TOKEN}@github.com/wawawatataru/atcoder_ogp.git
```

### 画像の取得

上記で設定した画像の撮影範囲と、GitHub Actions の設定に応じて Docker を立ち上げ、画像を撮影後、撮影した画像を push することで OGP の自動更新を実現しています。
