# TODO App

SwiftUIで作成したシンプルなiOS用TODOアプリケーションです。

## 機能

- TODOの追加・編集・削除
- 完了/未完了の切り替え
- データの永続化（UserDefaults）
- スワイプ削除対応

## 必要環境

- macOS 14.0+
- Xcode 15.0+
- iOS 17.0+

## セットアップ

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd todo
```

### 2. Xcodeプロジェクトの生成

[xcodegen](https://github.com/yonaskolb/XcodeGen)を使用してプロジェクトファイルを生成します。

```bash
# xcodegenのインストール（未インストールの場合）
brew install xcodegen

# プロジェクト生成
xcodegen generate
```

### 3. プロジェクトを開く

```bash
open TodoApp.xcodeproj
```

### 4. ビルド・実行

Xcodeでシミュレーターまたは実機を選択し、`Cmd + R`で実行します。

実機で実行する場合は、Signing & CapabilitiesでDevelopment Teamを設定してください。

## プロジェクト構成

```
todo/
├── project.yml              # xcodegen設定ファイル
├── README.md
└── TodoApp/
    ├── TodoAppApp.swift     # アプリエントリーポイント
    ├── ContentView.swift    # メイン画面
    ├── Models/
    │   └── TodoItem.swift   # TODOデータモデル
    ├── ViewModels/
    │   └── TodoViewModel.swift  # ビジネスロジック
    ├── Views/
    │   ├── TodoListView.swift   # リスト表示
    │   ├── TodoRowView.swift    # 各行の表示
    │   ├── AddTodoView.swift    # 追加画面
    │   └── EditTodoView.swift   # 編集画面
    └── Assets.xcassets/     # アセット
```

## 技術スタック

- SwiftUI
- Swift 5.9
- Observation framework (@Observable)

## ライセンス

MIT License
