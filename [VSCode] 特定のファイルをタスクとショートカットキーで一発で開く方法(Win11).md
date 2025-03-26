

## In a nutshell





## はじめに

Visual Studio Code（VSCode）では、毎回同じファイルを手動で開くのが面倒…という場面がありますよね。  
そこで、**作業時に特定のファイルをまとめて一発で開けるタスクを設定し、ショートカットキーで呼び出す**方法を紹介します。

この設定により、例えば「ConfigParam.h」と「cell_div.cpp」を一瞬で開くことが可能になります。





## 具体的な手順
### プロジェクト構成

作業ディレクトリの例：

```
C:\Users\username\Downloads\Turgor_Python\
├── ConfigParam.h
├── cell_div.cpp
└── .vscode\
    └── tasks.json
```



### ステップ 1：タスクファイルを作成（tasks.json）


- `"cwd": "${workspaceFolder}"` により、タスクの実行位置をプロジェクトルートに設定
- `"code -g"` は VSCode の CLI コマンドで、ファイルをエディタで開く
- `"dependsOn"` により、複数ファイルを一括で開くタスクを構成

`.vscode/tasks.json` を以下の内容で作成します：



```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Open ConfigParam.h",
      "type": "shell",
      "command": "code",
      "args": ["-g", "ConfigParam.h"],
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "problemMatcher": []
    },
    {
      "label": "Open cell_div.cpp",
      "type": "shell",
      "command": "code",
      "args": ["-g", "cell_div.cpp"],
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "problemMatcher": []
    },
    {
      "label": "Open both source files",
      "dependsOn": [
        "Open ConfigParam.h",
        "Open cell_div.cpp"
      ],
      "dependsOrder": "sequence"
    }
  ]
}
```





### ステップ 2：ショートカットキーを割り当てる

1. `Ctrl + Shift + P` を押してコマンドパレットを開く  
2. `Open Keyboard Shortcuts (JSON)` と入力し、選択する  
3. 開いた `keybindings.json` に以下を追加：


- `"args"` は `tasks.json` の `"label"` に**完全一致**させる必要があります
- `"key"` は自由にカスタマイズ可能（例：`ctrl+shift+1` など）


```json
[
  {
    "key": "ctrl+alt+o",
    "command": "workbench.action.tasks.runTask",
    "args": "Open both source files"
  }
]
```





### ステップ 3：実行してみる

`Ctrl + Alt + O` を押すだけで、設定した2ファイルが即座にエディタで開かれます。



## Summary

このように、VSCodeのタスク機能とショートカットキーを活用することで、よく使うファイルへのアクセスを効率化できます。  
プロジェクトごとに設定することで、開発開始時の「定型準備作業」を大幅に短縮可能です。


## References

