# One line scripts

## Git

### Troubleshooting

Used to troubleshoot slowness with git commands. This will enabled full debug
logs for git over ssh and print the time for each command.

```bash
GIT_SSH_COMMAND="ssh -vvv" GIT_TRACE=1 git fetch 2>&1 \
| gawk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0 }'
```
