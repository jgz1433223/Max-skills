# max skills

一组持续更新的 AI Agent Skill，统一以 `max-` 开头。每个 Skill 都是一个独立文件夹，里面有一份 `SKILL.md`，可以直接放进 Claude Code、WorkBuddy 等支持 SKILL.md 格式的 Agent 里使用。

## Skill 列表

| Skill | 用来做什么 | 版本 |
|---|---|---|
| [max-experience-deepdive](max-experience-deepdive/) | 深挖一段项目经历：按面试官身份决定讲法，产出带钩子的初次介绍和应对追问的深度知识库 | v1.1 |

## 安装

```bash
git clone https://github.com/jgz1433223/Max-skills.git
cp -r max-skills/<skill 名称> ~/.claude/skills/   # 或你所用 Agent 的 skills 目录
```

## 更新记录

- **v1.1** max-experience-deepdive：增加输入关卡，项目介绍和面试官身份都必须提供；术语审计改为按面试官身份判断。
- **v1.0** max-experience-deepdive：首个版本。

## License

[MIT](LICENSE)
