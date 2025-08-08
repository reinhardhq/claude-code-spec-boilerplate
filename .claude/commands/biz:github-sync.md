---
description: タスクリストをGitHub Issues/Projectsと同期し、プロジェクト管理を効率化
allowed-tools: Bash, Read, Write, Grep, Glob
---

# GitHub Task Synchronizer

タスクリストをGitHub Issues化し、Project boardsやMilestonesと連携して、チーム開発を円滑に進めるためのツールです。

**入力パラメータ**:
- リポジトリ: $REPO (owner/repo形式)
- タスクリスト: $TASKS

## Environment Check

### GitHub CLI Status
- CLI確認: !`which gh && gh --version || echo "GitHub CLI not installed"`
- 認証状態: !`gh auth status 2>&1 || echo "Not authenticated"`
- リポジトリ確認: !`[ -d .git ] && git remote -v | grep origin || echo "No git repository"`

## Task: GitHub同期の実行

### 1. タスクリストの解析

#### A. タスク形式の理解
入力されたタスクリストから以下を抽出：
- **タスク名**: Issue titleとして使用
- **カテゴリ**: Labelとして使用
- **優先度**: Priority labelとして使用
- **担当者**: Assigneeとして使用
- **見積時間**: Project fieldとして使用
- **依存関係**: Issue本文に記載

#### B. GitHub要素へのマッピング
- タスク → Issue
- カテゴリ → Label
- マイルストーン → Milestone
- 依存関係 → Issue links
- 見積もり → Custom fields

### 2. Issue作成の準備

#### A. Label管理
```yaml
必要なLabel:
  カテゴリ:
    - backend
    - frontend
    - infrastructure
    - design
    - testing
    - documentation
  優先度:
    - P0-critical
    - P1-high
    - P2-medium
    - P3-low
  ステータス:
    - todo
    - in-progress
    - review
    - done
```

#### B. Milestone設定
- スプリント/イテレーション単位
- リリースバージョン単位
- 四半期目標単位

#### C. Project Board設定
- カンバンボード形式
- 自動化ルールの設定
- カスタムフィールドの定義

### 3. Issue テンプレートの生成

#### A. Issue本文の構造
1. **概要**: タスクの目的と背景
2. **詳細**: 実装内容の具体的説明
3. **受入条件**: Definition of Done
4. **技術仕様**: 必要に応じた技術詳細
5. **依存関係**: 他のIssueとの関連
6. **参考資料**: 関連ドキュメントへのリンク

#### B. メタデータの付与
- Labels
- Assignees
- Milestone
- Projects
- Estimate (custom field)

### 4. 自動化スクリプトの生成

#### A. Bash スクリプト生成
- gh CLIを使用したIssue作成
- 一括作成用のループ処理
- エラーハンドリング
- 進捗レポート

#### B. GitHub Actions設定
- Issue作成時の自動化
- ステータス更新の連携
- 通知設定

### 5. チーム連携の最適化

#### A. 通知設定
- Slackとの連携
- メール通知のカスタマイズ
- Webhook設定

#### B. レポーティング
- 進捗ダッシュボード
- バーンダウンチャート
- ベロシティ追跡

## Output: GitHub同期設定

### 🔗 GitHub Issue 同期設定

**Repository**: $REPO
**Total Tasks**: [タスク総数]
**Estimated Total Hours**: [総見積時間]

### 📋 タスク一覧と Issue マッピング

| Task | Category | Priority | Assignee | Hours | Issue Template |
|------|----------|----------|----------|-------|----------------|
| [タスク1] | backend | P0 | @dev1 | 16h | [See below](#issue-1) |
| [タスク2] | frontend | P1 | @dev2 | 8h | [See below](#issue-2) |
| ... | ... | ... | ... | ... | ... |

### 🏷️ 必要な Label 設定

#### 作成が必要な Labels
```bash
# カテゴリ Labels
gh label create "backend" --description "Backend development" --color "0052CC"
gh label create "frontend" --description "Frontend development" --color "5319E7"
gh label create "infrastructure" --description "Infrastructure & DevOps" --color "1D76DB"
gh label create "design" --description "UI/UX Design" --color "FBCA04"

# 優先度 Labels
gh label create "P0-critical" --description "Critical priority" --color "B60205"
gh label create "P1-high" --description "High priority" --color "D93F0B"
gh label create "P2-medium" --description "Medium priority" --color "FBCA04"
gh label create "P3-low" --description "Low priority" --color "0E8A16"
```

### 🎯 Milestone 設定

```bash
# Milestone 作成
gh api repos/$REPO/milestones \
  --method POST \
  --field title="Sprint 1 - Core Implementation" \
  --field description="Initial core features" \
  --field due_on="2024-02-01T00:00:00Z"
```

### 📝 Issue Templates

#### <a name="issue-1"></a>Issue #1: [タスク1の名前]

```markdown
## 概要
[タスクの目的と背景]

## 詳細仕様
[実装すべき内容の詳細]

### 実装内容
- [ ] [サブタスク1]
- [ ] [サブタスク2]
- [ ] [サブタスク3]

## 受入条件
- [ ] [条件1]
- [ ] [条件2]
- [ ] テストが全てパス
- [ ] コードレビュー完了

## 技術仕様
- 使用技術: [技術スタック]
- API仕様: [必要に応じて]
- DB変更: [必要に応じて]

## 依存関係
- Blocks: #[Issue番号]
- Blocked by: #[Issue番号]

## 参考資料
- [設計書](link)
- [関連PR](link)

---
**Estimate**: 16 hours
**Category**: backend
**Priority**: P0-critical
```

### 🚀 一括作成スクリプト

```bash
#!/bin/bash
# GitHub Issues 一括作成スクリプト

REPO="$REPO"
MILESTONE_NUMBER=1  # 事前に作成したMilestone番号

# Issue作成関数
create_issue() {
    local title="$1"
    local body="$2"
    local labels="$3"
    local assignee="$4"
    
    echo "Creating issue: $title"
    
    gh issue create \
        --repo "$REPO" \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --assignee "$assignee" \
        --milestone "$MILESTONE_NUMBER"
}

# タスクごとにIssue作成
create_issue "[Backend] APIエンドポイント実装" \
"$(cat <<'EOF'
## 概要
RESTful APIエンドポイントの実装

## 実装内容
- [ ] ユーザー認証API
- [ ] データCRUD API
- [ ] エラーハンドリング

## 受入条件
- [ ] 全エンドポイントのテスト完了
- [ ] APIドキュメント作成
- [ ] セキュリティレビュー完了

**Estimate**: 16 hours
EOF
)" \
"backend,P0-critical" \
"@backend-dev"

# 他のタスクも同様に作成...

echo "✅ 全てのIssueを作成しました"
```

### 📊 Project Board 設定

```bash
# Project作成
gh api graphql -f query='
mutation {
  createProjectV2(input: {
    ownerId: "PROJECT_OWNER_ID",
    title: "Development Tasks",
    readme: "Project board for tracking development tasks"
  }) {
    projectV2 {
      id
      number
    }
  }
}'

# カスタムフィールド追加（見積時間）
gh api graphql -f query='
mutation {
  createProjectV2Field(input: {
    projectId: "PROJECT_ID",
    dataType: NUMBER,
    name: "Estimate (hours)"
  }) {
    projectV2Field {
      id
    }
  }
}'
```

### 🔔 自動化設定

#### GitHub Actions Workflow
`.github/workflows/issue-automation.yml`:

```yaml
name: Issue Automation

on:
  issues:
    types: [opened, closed, labeled]

jobs:
  update-project:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/github-script@v6
        with:
          script: |
            // Issue作成時にProjectに自動追加
            // ステータス更新の自動化
            // 通知の送信
```

---

### 🔍 次のステップ

**1. 環境準備**
```bash
# GitHub CLI インストール（未インストールの場合）
brew install gh  # macOS
# or
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg

# 認証
gh auth login
```

**2. Label作成**
- 上記のLabel作成コマンドを実行

**3. Milestone作成**
- Milestoneコマンドを実行し、番号を記録

**4. Issue一括作成**
```bash
# スクリプトを保存して実行
chmod +x create_issues.sh
./create_issues.sh
```

**5. Project Board設定**
- GitHub UIからProject作成
- カスタムフィールド追加
- 自動化ルール設定

### 📈 進捗トラッキング

**確認コマンド**:
```bash
# Open Issues一覧
gh issue list --repo $REPO --state open

# Milestone進捗
gh api repos/$REPO/milestones/$MILESTONE_NUMBER

# Project進捗（要Project ID）
gh project-v2 list
```

**ダッシュボードURL**:
- Issues: `https://github.com/$REPO/issues`
- Project: `https://github.com/orgs/[ORG]/projects/[NUMBER]`
- Insights: `https://github.com/$REPO/pulse`

---

## Instructions

1. **正確なマッピング** - タスク情報を漏れなくIssueに反映
2. **自動化の活用** - 手作業を最小限に
3. **チーム連携** - 通知とレポートの最適化
4. **継続的改善** - ワークフローの定期的な見直し
5. **ドキュメント化** - プロセスの明文化

このツールにより、タスク管理をGitHubに統合し、開発チームの生産性を向上させます。