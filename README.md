# Corgi
Corgi is a automatic project to install software and config environment in Ubuntu operation system.

## Usage

Change file mode.
```bash
chmod u+x corgi.sh
```
Run script.
```bash
sh corgi.sh
```

#### Using Docker for tests

You can run the tests in a Docker container to guarantee a clean test environment.

```bash
docker build -t corgi:v1 .
docker run --rm -it corgi:v1
```



## Installed packages


| name | type | installed |
| ------- | ----- | ------------ |
| wget| deb| :ballot_box_with_check: |
|curl|deb|:ballot_box_with_check:|
|vim |deb|:ballot_box_with_check:|
|zsh|deb|:ballot_box_with_check:|
|oh-my-zsh|source|:ballot_box_with_check:|
|tmux|deb|:ballot_box_with_check:|
|git|deb|:ballot_box_with_check:|
|teamviewer|tar package|:ballot_box_with_check:|
|jdk|deb|:ballot_box_with_check:|
|maven|tar package|:ballot_box_with_check:|
|chromium-browser|deb|:ballot_box_with_check:|
|gradle|zip package|:ballot_box_with_check:|



## Todo

1. Format print log.
2. Add more packages into `Corgi`. (such as `Jetbrains Apps`.)
3. Easy terminal command.




## License

This project is MIT licensed.

```bash
                     _ 
                    (_)
  ___ ___  _ __ __ _ _ 
 / __/ _ \| '__/ _` | |
| (_| (_) | | | (_| | |
 \___\___/|_|  \__, |_|
                __/ |  
               |___/   
```
