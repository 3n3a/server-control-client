# server control client

a client to control your server.

for the [server-control-api](https://github.com/3n3a/server-control-api)

## github action

### basic example

use the following as a basic example:

```yaml
on: [push]

jobs:
  server_control_client_job:
    runs-on: ubuntu-latest
    name: A job to control your server
    steps:
      - uses: actions/checkout@v4
      - id: scc-pull-image
        uses: 3n3a/server-control-client@v1
        with:
          key: ${{ secrets.SCC_KEY }}
          base_url: ${{ secrets.SCC_BASE_URL }}
          command: image_pull
          option: docker.io/library/busybox
```

**container_restart**

```yaml
      - id: scc-restart-container
        uses: 3n3a/server-control-client@v1
        with:
          key: ${{ secrets.SCC_KEY }}
          base_url: ${{ secrets.SCC_BASE_URL }}
          command: container_restart
          option: busybox
```

**service_restart**

```yaml
      - id: scc-restart-container
        uses: 3n3a/server-control-client@v1
        with:
          key: ${{ secrets.SCC_KEY }}
          base_url: ${{ secrets.SCC_BASE_URL }}
          command: service_restart
          option: sample.service
```

### advanced example

use the following for additional options:
* user_agent
* extra_headers

```yaml
on: [push]

jobs:
  server_control_client_advanced_job:
    runs-on: ubuntu-latest
    name: A job to control your server (Advanced)
    steps:
      - uses: actions/checkout@v4
      - id: scc-pull-image
        uses: 3n3a/server-control-client@v1
        with:
          key: ${{ secrets.SCC_KEY }}
          base_url: ${{ secrets.SCC_BASE_URL }}
          command: image_pull
          option: docker.io/library/busybox
      
          # advanced
          user_agent: "your-custom-user-agent/1.0"
          extra_headers: "-H 'Tracking-Id: 1234'"    
```

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

