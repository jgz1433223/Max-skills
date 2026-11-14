# max skills

一组持续更新的 AI Agent Skill，统一以 `max-` 开头。每个 Skill 都是一个独立文件夹，里面有一份 `SKILL.md`，可以直接放进 Claude Code、WorkBuddy 等支持 SKILL.md 格式的 Agent 里使用。

## Skill 列表

| Skill | 用来做什么 | 版本 |
|---|---|---|
| [max-experience-deepdive](max-experience-deepdive/) | 深挖一段项目经历：按面试官身份决定讲法，产出带钩子的初次介绍和应对追问的深度知识库 | v1.2 |

## 安装与自动同步

```bash
git clone https://github.com/jgz1433223/Max-skills.git ~/Max-skills
SKILLS_DIR=~/.claude/skills bash ~/Max-skills/scripts/sync.sh   # SKILLS_DIR 换成你所用 Agent 的 skills 目录
```

`sync.sh` 会先拉取最新版，再把仓库里所有 `max-*` skill **软链接**到 skills 目录。链接建好以后：
- 在本地仓库里改 skill，立刻生效；
- 仓库在 GitHub 上更新后，再跑一次 `sync.sh` 就能同步，新增的 skill 也会自动链接上。

如果你的 Agent 不认软链接，在命令前加 `MODE=copy`，改为复制。

## 更新记录

- **v1.2** max-experience-deepdive：项目介绍不再要求写清背景和原因，只要说了做的是什么事就能开始；素材太少时，先输出一份挖掘问题清单。新增 `scripts/sync.sh`。
- **v1.1** max-experience-deepdive：增加输入关卡，项目介绍和面试官身份都必须提供；术语审计改为按面试官身份判断。
- **v1.0** max-experience-deepdive：首个版本。

## License

[MIT](LICENSE)
