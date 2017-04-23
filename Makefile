default:
	@mix run --no-halt --no-recompile
dev:
	@iex -S mix
setup:
	@mix deps.get
	@mix clean
	@mix compile
