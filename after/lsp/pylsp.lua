return {
	filetypes = { "python" },
	cmd = { "pylsp" },
	settings = {
		pylsp = {
			plugins = {
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				mccabe = { enabled = false },
				pylsp_mypy = { enabled = false },
				pylsp_isort = { enabled = false },
				pylsp_black = { enabled = false },
			},
			signature = { formatter = "ruff" },
		},
	},
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
}
