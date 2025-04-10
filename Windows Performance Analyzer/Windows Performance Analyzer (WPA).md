以下の手順は、Windows 11環境で**Windows Performance Analyzer (WPA)**を利用してプロファイリングを行うための大まかな流れです。WPAはOS標準機能の「Windows Performance Toolkit (WPT)」に含まれている場合が多いですが、入っていない場合は**Windows ADK (Windows Assessment and Deployment Kit)**を使ってインストールできます。

---



## 1. Windows Performance Analyzer が既にインストールされているか確認

1. **スタートメニュー**を開いて「Windows Performance Analyzer」と入力する
   - 出てくる場合はすでにインストール済みなので、**特に追加の作業は不要**です。  
   - 見当たらない場合は、次の手順に沿ってWindows ADKからインストールします。

---

## 2. Windows ADKをインストールしてWPAを導入

1. 以下の公式サイトにアクセスして、Windows ADKをダウンロードします（無料）：  
   [Windows ADK (Windows 11 用)](https://learn.microsoft.com/ja-jp/windows-hardware/get-started/adk-install)

選択した・Windows ADK 10.1.26100.2454 (2024 年 12 月) をダウンロード

   > ※ 公式ドキュメントのURLやバージョン名は、環境・時期によって変わる可能性があります。  
2. ダウンロードした`adksetup.exe`を実行するとインストールウィザードが始まるので、指示に従って進めます。  
3. 「**Windows Performance Toolkit**」という項目にチェックを入れてインストールします。  
   - 他の機能をすべてインストールする必要はありません。最低限「Windows Performance Toolkit」にチェックを入れればOKです。  
4. インストールが完了すると、スタートメニューなどに「**Windows Performance Analyzer**」が追加されます。

---

## 3. プロファイリング（トレース）の取得手順

### 手順A: Windows Performance Recorder (WPR) のGUIを使う場合

1. **スタートメニュー**で「**Windows Performance Recorder**」を起動  
2. 「**Performance scenario**」や「**Recording**」などの設定画面が表示されます。  
   - CPUやシステムのベーシックな情報を取りたい場合は「**General profile**」「CPU usage」などにチェックを入れる  
   - 詳細な項目を指定したければ「More options」を開いて追加  
3. 「**Start**」を押して計測を開始する  
4. あなたのシミュレーションプログラムを通常通り実行  
5. シミュレーションが一段落したら、WPRに戻って「**Stop**」を押す → `.etl`ファイル（トレースログ）が生成  
6. 生成された`.etl`ファイルを「Windows Performance Analyzer」で開くと、CPU使用率やスレッドのタイムラインを可視化できます。

### 手順B: コマンドライン (WPR) で行う場合

1. **管理者権限**のあるPowerShellまたはコマンドプロンプトを起動  
2. 以下のように入力してCPU中心のプロファイルを開始
   ```powershell
   wpr -start CPU -filemode
   ```
   > `-start CPU`は、CPU性能解析向けの既定プロファイルを立ち上げる例です。  
   > ほかに`wpr -start "GeneralProfile"`等もあります。  
3. 次に、あなたのシミュレーションプログラムを通常通り実行  
4. 実行が完了したら、以下のコマンドでトレースを停止
   ```powershell
   wpr -stop MyTrace.etl
   ```
   これで`MyTrace.etl`というETLファイルが作成されます。  
5. 生成されたETLファイルを**Windows Performance Analyzer (WPA)**で開く  
   ```powershell
   wpa MyTrace.etl
   ```
   または、エクスプローラでETLファイルをダブルクリックしてもWPAが起動します。

---

## 4. Windows Performance Analyzerでの解析

1. `MyTrace.etl`（あるいはGUIで収集した`.etl`ファイル）をWPAで開く  
2. 左ペインや上部のツールバーなどから「**CPU Usage (Precise)**」「**CPU Usage (Sampled)**」「**Thread Timeline**」などのグラフを選択  
3. タイムライン上で**どのスレッドがいつ動いていたか**や、各スレッドのCPU使用時間の合計などを確認  
4. モジュールや関数名を解析するには、**PDBシンボルファイル**があるとより詳細が表示されます。  
   - ビルド時に`-g`相当（Visual C++なら`/DEBUG`）などデバッグシンボルを付与しておくと関数名などが表示されやすくなります  
5. スレッドIDごとに負荷状況を見れば、OpenMPスレッドの使用率やアイドル時間などが可視化できるので、**並列化のバランス**をざっくり把握するのに十分です。





```
# 1) WPR開始
wpr -start GeneralProfile -filemode


# 3) 記録停止
wpr -stop MyTrace.etl


```



PS C:\Users\mosuk\Downloads\cv2pdb-0.53> .\cv2pdb.exe
Convert DMD CodeView/DWARF debug information to PDB files, Version 0.53
Copyright (c) 2009-2012 by Rainer Schuetze, All Rights Reserved

License for redistribution is given by the Artistic License 2.0
see file LICENSE for further details

usage: C:\Users\mosuk\Downloads\cv2pdb-0.53\cv2pdb.exe [-D<version>|-C|-n|-e|-s<C>|-p<embedded-pdb>] <exe-file> [new-exe-file] [pdb-file]
PS C:\Users\mosuk\Downloads\cv2pdb-0.53>




---

## 5. 注意点 / ヒント

- **管理者権限**：WPRやWPAで一部のトレース情報を取得するには管理者権限が必要な場合があります。  
- **結果が膨大になる**：長時間のトレースはETLファイルが大きくなるので、まずは短めのテストで動作を確認すると良いでしょう。  
- **OS全体が対象**：WPAはOS全体のイベントを収集するため、他のプロセスの負荷も含めて表示されます。自分のシミュレーションプロセスだけにフィルタをかけることは可能なので、グラフ上で「Process Name = <あなたのexe>」に絞って見ると解析しやすいです。  
- **本番との環境差**：ETL収集のオーバーヘッドはそこまで大きくありませんが、本番環境での厳密な計測とは微妙な差が出る場合があります。しかし「どの部分（スレッド・関数）が大きくCPUを消費しているか」という傾向を見る目的には問題ありません。

---

## まとめ

1. **WPAの有無を確認**  
2. **なければWindows ADKをダウンロードし、「Windows Performance Toolkit」にチェックを入れてインストール**  
3. **WPRでトレースを開始 → シミュレーション実行 → 停止 → `.etl`ファイル作成**  
4. **WPAで`.etl`を開き、スレッドやCPU使用率を可視化**  

以上で基本的なセットアップと利用手順は完了です。これによって、マルチスレッド（OpenMP）コードを含むC++アプリケーションが、どこに負荷が集中しているか、スレッドが適切に分散されているかなど、全体的なバランスを把握できるようになります。