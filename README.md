# server control client

a client to control your server.

for the [server-control-api](https://github.com/3n3a/server-control-api)

## usage

copy the `scs.sh` to wherever you need it

### env variables

| name | description |
| ---- | ----------- |
| `SCC_BASE_URL` | Base Url for the Server control api |
| `SCC_KEY` | Server Control Api Key |
| `SCC_UA` | (OPTIONAL) Custom User Agent for Client |
| `SCC_EXTRA_HEADERS` | (OPTIONAL) Extra headers as a comma-separated string |

### commands

**pull image**

```sh
./scc.sh image_pull <image>
```

**restart container**

```sh
./scc.sh container_restart <container>
```

**restart systemd service**

```sh
./scc.sh service_restart <service>
```

