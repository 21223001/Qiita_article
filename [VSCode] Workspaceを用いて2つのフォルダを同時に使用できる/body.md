
## In a nutshell
VSCodeのMulti-root Workspace機能を使うと，複数のフォルダを同時に開いて管理できる．
これにより，Gitの管理を維持しつつ，異なるプロジェクトを一元的に扱える．
この記事では，Multi-root Workspaceの設定方法やGitとの相互作用について解説する．



## VSCodeとは
VSCodeとは Visual Studio Code (VSCode) は，Microsoftが開発する無料の軽量なコードエディタ．
拡張機能を追加することで，さまざまなプログラミング言語や開発環境に対応可能．
Git連携，デバッグ機能，ターミナル統合などを備え，開発の効率を向上させる．

## 本記事の記述理由
VSCodeでは，作業フォルダを1つずつ開く必要があると思っていたが，複数のフォルダを同時に開く(**Multi-root Workspace**機能)ことができると知った．Git管理に影響を与えることなく，複数のプロジェクトを並行して扱えるため，作業効率が大幅に向上する．個人的だが，これがないとフォルダを行き来するのが面倒な為に作業効率が大きく下がると感じる．この記事では，VSCodeの機能の中でも特にMulti-root Workspaceに焦点を当て，その設定方法やGitとの相互作用について記述した．


## Multi-root Workspaceとは？

**Multi-root Workspace** では，単に複数のフォルダを開くのとは異なり，1つのWorkspace内で複数のrepositoryやプロジェクトを統合的に管理できる機能．

通常，VSCodeでは「作業ディレクトリを開く(Open Folder)」ことで，1つのプロジェクトを個別に開く．しかし，**Multi-root Workspace** を使用すると，Gitのrepositoryをフォルダ単位で独立させながら，一元的に扱うことが可能となる．つまり，単に複数のフォルダを開くだけではなく，エディタの設定やGit管理を統合できる点が大きな違いである．


例えば，フロントエンド(Vue.js)とバックエンド(Node.js)のrepositoryを分けて管理しつつ，同じWorkspaceで開発を行うことができる．これにより，エディタの設定を統一でき，Gitのブランチ管理やコミット作業もスムーズに行える．

また，Mono-repo構成(1つのrepository内に複数のプロジェクトを持つ)でも，各フォルダごとにGitの履歴やブランチを独立して管理できるため，不要な変更が誤って別プロジェクトに影響を与えることを防げる．

さらに，`.code-workspace` ファイルを利用すれば，開発環境の設定や拡張機能を統一し，Workspace単位でカスタマイズできる．よってGit操作，デバッグ，ターミナルの利用がスムーズとなる．




## 作業ディレクトリを複数開く方法
複数のフォルダを左側のExplorerで扱える(**Multi-root Workspace**)．
これは，Workspace と呼ばれる作業テーブルに，複数のフォルダを追加する事で利用する．
設定したWorkspaceは，ファイル > `Save Workspace As...` から `.code-workspace` として保存可能．次回以降，ファイルを開くだけで同じフォルダ構成を復元できる．

#### 具体的な手順
開いた時点での画面
![01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/dd7bc0b0-8159-49e8-bfb8-d117638e479d.png)


Open folderより，1つ目のフォルダを開く
![02.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/c22e94e5-df0d-4812-a5e0-3e898769b116.png)


上部のFileタブより，Add Folder to Workspace を選択
![03.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/eddb3f38-012f-4fa7-ad78-c100ad232952.png)


2つ目のフォルダを開く
![04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/ebff6b60-c8ee-4106-a68e-07911bed4e7c.png)


これにより，2つのフォルダが Workspace に存在する
![05.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/f5cbedc0-5a46-4373-afba-0a7ddb467d64.png)


Workspace からフォルダを削除する場合には，Remove Folder from Workspace を選択
![06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/aad83c5f-f67b-4aa6-b50d-6468753e6f9b.png)



## Git との相互作用について

### Gitの履歴やコミットが重複管理されるか？

結論: 重複管理されません．

 - それぞれのフォルダに .git フォルダが存在し，Gitの管理範囲や履歴はフォルダ単位で独立している．
 - VSCode の「ソース管理 (Source Control)」ビューを開くと，各repositoryごとに分かれて表示されるはず．
例: Repo A / Repo B のようにrepository単位でコミット履歴やブランチを切り替えられる．
 - したがって，あるフォルダでコミットした変更や履歴が，別フォルダのGit repositoryに誤って紐づくことは無い．


### 「先に開いたフォルダ」が優先されるような挙動はあるか？

結論: 通常の運用においては，先に開いたフォルダが優先されるような問題は起こらない．

 - VSCodeは「Workspaceにある複数のフォルダ」を認識し，それぞれ独立したGitrepositoryとして処理する．先に読み込まれたかどうかで，Git機能の挙動が変わることはない．
 - 仮に両方のフォルダに変更がある場合でも，ソース管理ビューの中でそれぞれの変更内容が別々に表示され，好きな順番でコミットできる．



### Git の設定をカスタマイズする

#### デフォルトのrepositoryパスを指定する (`git.defaultRepositoryPath`)

VSCodeでは `git.defaultRepositoryPath` を設定することで，新規にクローンする際のデフォルトディレクトリを指定できる．
複数のWorkspaceを扱う場合，適切なrepositoryのパスを設定すると管理が楽になる．

設定方法:
1. `Ctrl + Shift + P` でコマンドパレットを開く．
2. 「Preferences: Open User Settings (JSON)」を選択．
3. `settings.json` に以下を追加:

   ```json
   "git.defaultRepositoryPath": "C:\\Users\\YourName\\Projects"
   ```
これにより，新規repositoryのクローン時にデフォルトで指定のディレクトリが開くようになる．

#### `.git` の自動認識 (`git.autoRepositoryDetection`)

VSCode では `git.autoRepositoryDetection` の設定により，Workspace内の `.git` フォルダを自動認識できる．
デフォルトでは `true` になっており，Workspaceに含まれるrepositoryを自動で識別しますが，手動で管理したい場合は `open` や `subFolders` に変更するとよい．

##### 設定オプション:
- `true`(デフォルト): すべての `.git` フォルダを自動認識．
- `"open"`: 現在開いているフォルダ直下の `.git` フォルダのみ認識．
- `"subFolders"`: サブフォルダの `.git` も認識(必要に応じて変更)．

##### 設定方法:
1. `Ctrl + Shift + P` でコマンドパレットを開く．
2. 「Preferences: Open User Settings (JSON)」を選択．
3. `settings.json` に以下を追加:
   ```json
   "git.autoRepositoryDetection": "open"


#### 特定のGit設定やVS Code拡張機能
 - まれに拡張機能によっては，複数のrepositoryを同時に扱う際に動作が不安定になることもある．
 - そのような挙動があった場合は，拡張機能を無効にしてみる，あるいはVSCodeの設定で `git.autoRepositoryDetection` を調整することも検討すると良い．




### 注意が必要な場合

#### フォルダがネストしている場合

 - もし「フォルダA」の中にサブフォルダとして「フォルダB」が入っており，両方とも `.git` を持つような入れ子状態になっていると，Gitの管理範囲が重複する場合がある．
 - この場合は，「親repositoryが子フォルダの変更を取り込む」といった競合が発生しやすいので注意が必要．
 - 完全に別々のパス(兄弟関係のフォルダ)であれば問題ない．



## Summary

 - Multi-root Workspace は複数のフォルダを統合管理でき，Gitリポジトリの独立性を保つ．
 - `.code-workspace` を保存することで，作業環境を簡単に復元可能．
 - Gitはフォルダ単位で管理されるため，履歴やコミットが混在しない．
 - `git.defaultRepositoryPath` や `git.autoRepositoryDetection` を設定すると，Gitの管理がより便利になる．
 - フォルダのネスト構造には注意が必要で，Gitの管理範囲が重複する可能性がある．


## References

 - Microsoft. "Multi-root Workspaces in Visual Studio Code." Visual Studio Code Documentation. [https://code.visualstudio.com/docs/editor/workspaces/multi-root-workspaces](https://code.visualstudio.com/docs/editor/workspaces/multi-root-workspaces)

 - Microsoft. "Using Version Control in VS Code." Visual Studio Code Documentation. [https://code.visualstudio.com/docs/sourcecontrol/overview](https://code.visualstudio.com/docs/sourcecontrol/overview)

 - Stack Overflow. "How to properly use Multi-root Workspaces in VS Code with Git?"  [https://stackoverflow.com/](https://stackoverflow.com/) 