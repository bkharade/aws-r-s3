rm -r demo-r-ecs.tar.gz
docker build --no-cache -t demo-r-ecs:latest -f Dockerfile .
docker save demo-r-ecs:latest | gzip > demo-r-ecs.tar.gz
docker rmi $(docker images -f "dangling=true" -q)