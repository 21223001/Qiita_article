
## In a nutshell
MSYS2 は Windows で Unix ライクな開発環境を提供し，`pacman` によるパッケージ管理や MinGW-w64 を用いた Windows ネイティブなプログラム開発が可能なツールである．MinGW-w64 を利用することで，Windows ネイティブな C/C++ の開発が可能．MINGW64，UCRT64，CLANG64 など，用途に応じた開発環境を選択できる．

## はじめに
C++で MINGW64 を利用しているが，MSYS2には複数の系列が存在しており，違いについてよく分からないまま利用をしていたので，以下に纏めた．

##  MSYS2 とは
MSYS2 は Windows 上で Unix ライクな環境を提供するソフトウェアであり，Cygwin を基に開発された．Windows において Unix コマンドやシェルスクリプトを扱いやすくするだけでなく，MinGW-w64 を利用した Windows ネイティブのプログラム開発環境としても機能する．

![MSYS2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/d779c4ad-98aa-435d-ae12-e449599b8ec0.png)

##  なぜ利用するのか？
MSYS2 を利用することで，以下のような利点がある．
- **Unix 環境の再現**：Bash や GNU ツール群を Windows で利用可能．
- **パッケージ管理**：`pacman` によるパッケージ管理が可能．
- **Windows ネイティブな開発環境**：MinGW-w64 を用いた C/C++ 開発ができる．
- **多様なコンパイル環境の提供**：MINGW64, UCRT64, CLANG64, CLANGRM64 など用途に応じた環境を選べる．
- **WSLとの違い**：WSL はより本格的な Linux 環境を提供するが，MSYS2 は Windows ネイティブな開発に向いている


##  MSYS2 の系列
MSYS2 には以下の系列が存在する．

| 環境名 | 目的 | コンパイラ | 特徴 |
|---|---|---|---|
| **MSYS** | Unix 環境エミュレーション | - | Windows ネイティブではなく，Unix 環境向け |
| **MINGW32** | 32bit Windows ネイティブ | `mingw-w64-i686-gcc` | 32bit バイナリ作成向け |
| **MINGW64** | 64bit Windows ネイティブ | `mingw-w64-x86_64-gcc` | 64bit バイナリ作成向け（最もよく使われる） |
| **UCRT64** | 64bit Windows ネイティブ（UCRT使用） | `mingw-w64-ucrt-x86_64-gcc` | 最新の Windows API に適したバイナリを作成 |
| **CLANG64** | 64bit Windows ネイティブ（Clang使用） | `mingw-w64-clang-x86_64` | Clang を用いた開発向け |
| **CLANGRM64** | ARM64 Windows ネイティブ（Clang使用） | `mingw-w64-clang-aarch64` | ARM64 向け Clang 環境 |


##  どの言語で利用するのか？
MSYS2 では主に以下の言語の開発が可能．
- **C/C++**（MinGW-w64 によるコンパイル）
- **Rust**（Rustup 経由で Windows ネイティブバイナリを作成）
- **Python**（`pacman` 経由でインストール可能）
- **Go**（`mingw-w64` 環境で Windows ネイティブな実行ファイルを作成）


##  利点と欠点

### **利点**
- Windows で Unix ライクな開発が可能．
- `pacman` によるパッケージ管理が使える．
- MinGW-w64 による Windows ネイティブなバイナリが作成可能．
- Clang や UCRT64，ARM64 など最新の開発ツールにも対応．

### **欠点**
- Windows の標準環境とは異なるため，設定が必要．
- MSYS2 のシェル環境では Windows ネイティブな実行ファイルとの互換性が低い．
- `pacman` のリポジトリが Arch Linux ベースであり，Windows 固有のソフトウェアのパッケージは少ない．
- Visual Studio との連携がやや難しい．Visual Studio のプロジェクトと統合するには CMake や Ninja を活用する必要がある．


##  どの環境を選ぶべきか？
特に理由がなければ，`MINGW64` が最も一般的な選択肢となる．


| 開発用途 | 推奨環境 |
|---|---|
| Windows で 64bit の C/C++ アプリを作る | **MINGW64** |
| Windows で 32bit の C/C++ アプリを作る | **MINGW32** |
| 最新の Windows API に対応させたい | **UCRT64** |
| Clang で開発したい | **CLANG64** |
| ARM64 で Clang を用いた開発を行いたい | **CLANGRM64** |
| Unix ライクなシェルスクリプトを実行したい | **MSYS** |



## MSYS2 のインストール方法

### MSYS2 のダウンロード
公式サイトからインストーラをダウンロードします．

- [MSYS2 公式サイト](https://www.msys2.org/)
- `x86_64` 版を選択してダウンロード

### インストール
1. ダウンロードした `.exe` ファイルを実行．
2. インストール先を指定（デフォルトの `C:\msys64` 推奨）．
3. インストールが完了したら，**チェックボックスを外さずにそのまま起動**．

### 初期セットアップ
以下のコマンドを実行してパッケージデータベースを更新．

```sh
pacman -Syuu
```
- 再起動が求められた場合はターミナルを閉じ，MSYS2 を再起動し，再度 `pacman -Syuu` を実行．

### 必要なツールのインストール
用途に応じて以下の環境をインストール．

- **MSYS2 基本ツール:**
  ```sh
  pacman -S base-devel
  ```

- **MINGW 環境:**
  - `mingw-w64-x86_64-gcc`（64bit 用コンパイラ）
  - `mingw-w64-x86_64-make`（make コマンド）
  ```sh
  pacman -S mingw-w64-x86_64-toolchain mingw-w64-x86_64-make
  ```

### パスの設定（オプション）
Windows の環境変数 `PATH` に `C:\msys64\mingw64\bin` を追加．

### 確認
以下のコマンドを実行し，正常に動作するか確認．

```sh
gcc --version
make --version
```


## Summary

 - MSYS2 は Windows 上で Unix 環境を再現し，MinGW-w64 を活用した開発をサポート．
 - `pacman` によるパッケージ管理が可能で，GNU ツールや Clang を利用できる．
 - MINGW64 など複数の系列があり，開発用途に応じた環境を選択できる．
 - インストール後に `pacman -Syuu` でパッケージを更新し，必要なツールを導入．
 - Windows 環境との互換性には注意が必要だが，C/C++ や Rust などの開発に適している．


## References
[MSYS2 公式ドキュメント](https://www.msys2.org/)
[msys2.github.io](https://github.com/msys2/msys2.github.io)

