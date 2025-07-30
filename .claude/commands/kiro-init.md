# kiro:init - Claude Code Spec-Driven Development セットアップ

このコマンドは、Claude Code Spec-Driven Developmentのファイルを現在のプロジェクトにセットアップします。

## 実行内容

1. **`.claude/commands/kiro/`ディレクトリの作成とコマンドのコピー**
   - claude-code-specプロジェクトから全てのkiroコマンドをコピー

2. **CLAUDE.mdファイルのコピー**
   - claude-code-specからCLAUDE.mdをコピー（既存ファイルがある場合はバックアップ）

3. **初期ディレクトリ構造の作成**
   - `.kiro/steering/` - ステアリング文書用
   - `.kiro/specs/` - 機能仕様用

## 使用方法
```
/kiro:init
```

## 処理フロー

1. 現在のプロジェクトディレクトリを確認
2. claude-code-specプロジェクトの場所を確認（`/Users/reinhardhq/app-projects/claude-code-spec`）
3. 必要なディレクトリを作成
4. コマンドファイルをコピー
5. CLAUDE.mdをコピー（既存の場合はバックアップ）
6. セットアップ完了メッセージを表示

## 注意事項
- 既存のCLAUDE.mdは`CLAUDE.md.backup`として保存されます
- 既存のkiroコマンドは上書きされます