###############################################
## 3. docker build bioconductor_docker:devel

cd $GITHUB_WORKSPACE;

echo "*** Building systempipe/systempipe_docker *** \n"

## Git login
git config user.email "danicassol@gmail.com"
git config user.name "dcassol"

## Git commit
git commit -am "Weekly version bump and rebuild of bioconductor_docker:latest"

## docker build, login and push
docker build -t systempipe/systempipe_docker:latest .

docker login --username=$DOCKER_HUB_USERNAME --password=$DOCKER_HUB_ACCESS_TOKEN

docker push systempipe/systempipe_docker:latest

## Finish
echo "Done"

