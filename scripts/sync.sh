#!/usr/bin/env bash
# 拉取 Max-skills 最新版，并把仓库里所有 max-* skill 安装到本机 skills 目录。
#
# 用法：
#   SKILLS_DIR=~/.claude/skills bash scripts/sync.sh
#   MODE=copy SKILLS_DIR=... bash scripts/sync.sh   # Agent 不支持软链接时，改为复制
#
# 默认 MODE=link：建软链接，以后在本地仓库改 skill 会立刻生效，不用重新安装。

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="${SKILLS_DIR:-$HOME/.claude/skills}"
MODE="${MODE:-link}"
BACKUP_DIR="$HOME/.max-skills-backup/$(date +%Y%m%d-%H%M%S)"

echo "仓库：$REPO_DIR"
echo "目标：$SKILLS_DIR（模式：$MODE）"

# 1. 拉取最新版。只做 fast-forward，本地有未提交的改动或分叉时直接报错，不覆盖本地内容
git -C "$REPO_DIR" pull --ff-only --quiet
echo "已更新到：$(git -C "$REPO_DIR" log -1 --format='%h %s')"

mkdir -p "$SKILLS_DIR"

# 2. 逐个安装 max-* skill
for src in "$REPO_DIR"/max-*/; do
  [ -f "${src}SKILL.md" ] || continue
  src="${src%/}"
  name="$(basename "$src")"
  dst="$SKILLS_DIR/$name"

  if [ "$MODE" = "link" ]; then
    # 已经是指向本仓库的软链接，说明之前装过，跳过
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
      echo "✓ $name（已链接）"
      continue
    fi
    # 目标位置有旧版本时，先移到 skills 目录之外备份，避免 Agent 同时加载到两份
    if [ -e "$dst" ] || [ -L "$dst" ]; then
      mkdir -p "$BACKUP_DIR"
      mv "$dst" "$BACKUP_DIR/"
      echo "  旧版已备份到：$BACKUP_DIR/$name"
    fi
    ln -s "$src" "$dst"
    echo "+ $name（新建链接）"
  else
    # 复制模式：用 rsync 同步，--delete 会删掉仓库里已经移除的文件
    rsync -a --delete --exclude '.DS_Store' "$src/" "$dst/"
    echo "✓ $name（已复制）"
  fi
done

echo "同步完成。"
