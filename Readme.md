# Termite Console

## Run on Docker

I have my Debian (10) Buster workstation. My local username is `anish`

My local UID=`1000` and my GID=`1000`

If I manually invoke the `termite` from docker it will start with `root` ownership. which I do not want.

So, I use the below command to run termite on my local.

```docker run --rm --user 1000 --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume="$HOME:/home/anish" trydock/dkr-termite termite```

## CORRECT Method

Create a new directory on your local workstation.

```mkdir local-termite```

Navigate to the newly created directory `local-termite`

```cd local-termite```

create a file named `Dockerfile` with below content.

```
FROM trydock/dkr-termite:latest

RUN groupadd -r -g 1000 anish && \
    useradd -r -u 1000 -g 1000 -c "anish.asokan" -s /bin/bash -d /home/anish anish
```

In the above `Dockerfile` I am using `anish` as the username, You can use any username as you like.
But ensure that you replace the UID and GID with correct ones from your local workstation.

The issue the below command:

```docker build -t local/termite .```

This will create a new docker image in your local name `local/termite`

now create a file on your workstation `/home/$USER/bin/termite` with below content.

```
#!/bin/bash
docker run --rm --user 1000 --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume="$HOME:/home/anish" local/termite termite
```

Add execute permissions:

```chmod +x /home/$USER/bin/termite```

Then you can invoke `termite` command from your local workstation, which will automatically create a docker comtainer and run termite instance.
