# notes

TensorBoard as a docker image


By default the folder `/tmp/tensorboard/0` will be used:
```
make docker-run
```

Specify the folder explicitly:
```
TB_FOLDER=/tmp/tb make docker-run
```

