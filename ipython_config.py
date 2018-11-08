c = get_config()
c.IPCompleter.use_jedi = False

c.InteractiveShellApp.exec_lines = [
    '%load_ext autoreload',
    '%autoreload 2',
]
