setup-vscode:
	@code --install-extension ms-python.python
	@code --install-extension ms-python.mypy-type-checker
	@code --install-extension charliermarsh.ruff
	@code --install-extension mhutchie.git-graph
	@code --install-extension GitHub.copilot
	@code --install-extension ms-toolsai.jupyter

setup-poetry:
	@poetry config virtualenvs.in-project true
	@poetry install