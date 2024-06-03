rm -r demo-r-s3.tar.gz
docker build --no-cache -t demo-r-s3 -f Dockerfile .
docker save demo-r-s3 | gzip > demo-r-s3.tar.gz
#docker rmi $(docker images -f "dangling=true" -q)