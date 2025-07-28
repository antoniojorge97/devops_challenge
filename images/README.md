# Images

This directory is destined to construct docker images.

# Useful commands:
`docker build -f images/Dockerfile -t <name_of_application> .`
`docker run -d -p 8080:80 <name_of_application>`
`docker logs <container_id>`
`docker ps` 
`docker stop <container_id>`