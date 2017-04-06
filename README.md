# DMPOnline_v4 Docker

Install MySQL 5.7. Set the root password to [123](https://en.wikipedia.org/wiki/All_your_base_are_belong_to_us).


Build the docker container:
```bash
docker build . -t dmp-online
```

Run the docker container:
```bash
docker run -p 3000:3000 -it dmp-online /bin/bash
```

Make sure that your MySQL accepts connections from your running docker container.

From inside the running dmp-online docker container, on the bash prompt, run the following commands:
```bash
rake db:setup
rails server
```