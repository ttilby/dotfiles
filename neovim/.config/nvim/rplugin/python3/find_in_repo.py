import neovim
import pathlib


@neovim.plugin
class FindInGit:

    def __init__(self, nvim: neovim.Nvim):
        self.nvim = nvim

    @neovim.function("FindInGit")
    def func_handler(self, args):
        local_path = self.nvim.current.buffer.name
        root_path, git_path = self.find_git_repo(local_path)

        if not git_path:
            self.say("Not a git repository")
            return

        url = self.find_url_in_git_config(git_path)
        if not url:
            self.say("Unable to parse git url")
            return

        remote_path = f"{url}/-/tree/master{local_path[len(root_path):]}"
        self.say(f"Found it: {remote_path}")

    def say(self, msg):
        self.nvim.command(f'echo "{msg}"')

    def find_git_repo(self, base):
        for p in pathlib.Path(base).parents:
            git_path = p / ".git" / "config"
            if git_path.exists():
                return str(p), str(git_path)
        return None, None

    def find_url_in_git_config(self, path):

        def parse_url(line):
            val = line.split("=")[-1].strip()
            if val.startswith("git@"):
                val = val.split("@")[-1]
                host, path = val.split(":")
                val = f"https://{host}/{path}"
            return val.rstrip('.git')

        def find_url(line):
            if line.startswith("\turl"):
                return None
            return find_url

        def find_origin(line):
            if line != '[remote "origin"]\n':
                return find_origin
            return find_url

        state = find_origin

        with open(path, "r") as fd:
            for i, line in enumerate(fd):
                state = state(line)
                if state is None:
                    return parse_url(line)
        return None
