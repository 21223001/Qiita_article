

## In a nutshell
これは，Visual Studio Code(以下，VSCode)を使用する初学者を対象としたドキュメントである．コードの可読性や保守性を高めるためには，無駄なスペースの削除が重要である．特に，行末に意図せず挿入される「trailing spaces(トレーリングスペース)」は，エラーの原因となることもあり，無視できない問題である．


## はじめに
プログラミングや文章整形において，コードの美しさや一貫性は重要である．特にチーム開発やバージョン管理を行う環境では，不要なスペースがノイズとなり，レビューや差分確認の妨げとなる．Visual Studio Code には，このような不要なスペース(trailing spaces)を検出・削除する機能が複数用意されており，本稿ではその導入と活用方法について記述する．



## 予想される読み手
 - VSCode における実用的な拡張機能を探している
 - 文章の成形コストを下げたい
 - コードの見た目と品質を維持したい
 - バージョン管理の無駄な差分を削減したい



## trailing spacesとは

trailing spacesとは，**各行の末尾に存在する不要な空白文字列のこと**である．視覚的には見えないが，以下のような問題を引き起こすことがある．

- Gitなどのバージョン管理において無意味な差分が発生する．
- 一部の言語やツールではエラーの原因となる．
- コードスタイルとして不統一感を生む．

VSCodeでは，拡張機能「Trailing Spaces」などを用いることで，これらのスペースを視覚的にハイライトできる．加えて，VSCodeの設定を通じて，trailing spacesの**自動削除**も実現できる．


### 単なる空白文字との違い
 - trailing Spaces(トレーリングスペース)とは，行末に存在する不要な空白．一般に削除されるべき対象である．
 - white space(空白文字)とは，空白，タブ，改行など，視覚的に表示されない文字の総称．trailing space はこの中の一部にあたる．
 - つまり，trailing space は whitespace の部分集合であり，位置的に行末に限定された概念である．



## 手動削除または自動削除のどちらを選択すべきか
個人的な使用感としては，手動削除を行う事に関して，殆ど手間は無いので，必要が無ければ手動でも十分だと感じる．また，自動削除ではなく，**必要に応じて手動で削除**する，自動削除と手動削除を併用する方法もある．


## 手動での削除について
このセクションは，手動での削除について記述してある．自動削除はこの次のセクションで扱う．

### 拡張機能「Trailing Spaces」について
拡張機能 [**Trailing Spaces**](https://marketplace.visualstudio.com/items/?itemName=shardulm94.trailing-spaces) は，**行末の空白をハイライトし，視覚的に認識・削除を容易にするツール**である．

主な機能は以下
- **ハイライト表示**：行末のスペースを赤や灰色などで表示し，不要なスペースを明示する．
- **一括削除コマンド**：`Trim Trailing Spaces` コマンドを提供し，全ファイルまたは現在のファイルに対してトレーリングスペースを削除できる．
- **除外設定**：特定の行(例:カーソル位置のある行)や正規表現にマッチする行の削除をスキップするオプションがある．
- **保存時に自動削除(補助機能)**：`files.trimTrailingWhitespace` 設定が無効でも，拡張機能側のオプションで保存時削除が可能．

この拡張機能を導入することで，**手動削除の精度と操作性が向上**する．特に，削除前に視認したい場合や，特定行を除外したい場合に有効である．なお，本記事の手動削除はこの拡張機能の導入を前提としている．

以下，手順
`Ctrl + Shift + P` を押して「Trim Trailing Whitespace」を検索．
実行することで，現在開いているファイルのtrailing spacesを一括で削除できる．

独自のキーボードショートカットの設定も可能である．但し，恩恵はそこまで無いと思う．



## 自動削除について

### 保存時に自動で削除する
以下の設定をVSCodeの `settings.json` に追加する．保存時に行末のスペースを削除する設定を行う．最も基本的で安全な方法．この設定により，**ファイル保存時にtrailing spacesが自動で削除**される．


#### 手順
`Ctrl + Shift + P` を押下し，「Preferences: Open Settings (JSON)」を検索・選択する．
`settings.json` に以下を記述する．
```json
"files.trimTrailingWhitespace": true
```


### 保存時にフォーマットも行う

以下の設定を追加することで，保存時にコードの整形(フォーマット)も同時に実行できる．この設定と `files.trimTrailingWhitespace` を併用することで，より整ったコードを維持することが可能である．

```json
"editor.formatOnSave": true
```


### 特定の言語のみに適用する
全ての言語に適用したくない場合，特定の言語に限定して設定を行うこともできる．以下はPythonのみに適用する例である．このように記述することで，不要な削除を防ぎ，かつ，必要な言語にのみ機能を有効化できる．

```json
"[python]": {
  "files.trimTrailingWhitespace": true
}
```


## 補足

### 単純な置換では対処できない理由

trailing spacesの削除を `" "` -> `""` のような単純な置換処理で行おうとすると，行末以外の**意図的なスペース**までも削除されてしまう．これにより，コードの可読性やインデント構造が損なわれる可能性がある．そのため，**「行末のみ」を対象とした削除処理**をVSCodeの機能として利用するのが最善である．


## まとめ表

これらの機能を活用することで，trailing spacesによる不具合や煩雑さを解消し，クリーンで統一されたコードを維持できる．

| 方法 | 特徴 |
|------|------|
| `files.trimTrailingWhitespace` | 保存時に自動で削除される |
| `editor.formatOnSave` 併用 | 自動整形も同時に行われる |
| 言語別設定 | 特定の言語に限定して適用できる |
| コマンド実行 | 必要に応じて手動削除が可能 |



## Summary
- trailing space は whitespace の一種で，各行末の不要な空白を指す．
- VSCodeでは保存時の自動削除やコマンドによる手動削除が可能である．
- `" "` -> `""` の置換処理では誤って必要な空白まで削除する可能性がある．
- `files.trimTrailingWhitespace` により自動削除を実現できる．
- `editor.formatOnSave` を併用することでコードの整形も可能となる．
- 言語ごとに適用範囲を調整することもできる．



## References
- Visual Studio Code - [User and Workspace Settings](https://code.visualstudio.com/docs/configure/settings)
- Visual Studio Marketplace - [Trailing Spaces 拡張機能](https://marketplace.visualstudio.com/items/?itemName=shardulm94.trailing-spaces)






