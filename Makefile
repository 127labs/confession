default:
	@mix run --no-halt --no-compile
dev:
	@iex -S mix
setup:
	@mix deps.get
	@mix clean
	@mix compile
docker.build.base:
	@gcloud docker -- build -t asia.gcr.io/labs-127/confession:base -f ./Dockerfile.base .
docker.push.base:
	@gcloud docker -- push asia.gcr.io/labs-127/confession:base
docker.deploy.base: docker.build.base docker.push.base
