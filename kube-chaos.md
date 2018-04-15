%title: KubeCon CloudNativeCon 2018 - Chaos Engineering in Practice
%author: @paulwilljones
%date: 2018-05-01

-> # Chaos Engineering in Practice <-

-> KubeCon CloudNativeCon 2018 <-
-> May 1 2018 <-

-> ───────────────▄████████▄──────── <-
-> ─────────────▄█▀───────▀██▄────── <-
-> ───────────▄█▀───────────██────── <-
-> ─────────▄█▀──────▄──────▐█▌───── <-
-> ────────▄█────────▀█─────▐█▌───── <-
-> ───────▄█──────────▀█───▄██────── <-
-> ──────▄█────────────▀█─▄█▀█▄───── <-
-> ─────▄█──────────────██▀───█▄──── <-
-> ────▄█──────────────────────█▄─── <-
-> ───▄█────────────────────────█▄── <-
-> ──▄█───▄██████▄────▄█████▄────█── <-
-> ──█───█▀─────▀█────█▀────▀█───█── <-
-> ──█───█──▄────▀████▀───▄──█───█── <-
-> ▄███▄─█▄─▐▀▄─────────▄▀▌─▄█─▄███▄ <-
-> █▀──█▄─█─▐▐▀▀▄▄▄─▄▄▄▀▀▌▌─█─▄█──▀█ <-
-> █────█─█─▐▐──▄▄─█─▄▄──▌▌─█─█────█ <-
-> █─▄──█─█─▐▐▄─▀▀─█─▀▀─▄▌▌─█─█──▄─█ <-
-> █──█─█─█──▌▄█▄▄▀─▀▄▄█▄▐──█─█─█──█ <-
-> █▄─█████████▀──▀▄▀──▀█████████─▄█ <-
-> ─██▀──▄▀──▀──▀▄───▄▀──▀──▀▄──▀██ <-
-> ██─────────────────────────────██ <-
-> █───────────────────────────────█ <-
-> █─▄───────────────────────────▄─█ <-
-> █─▀█▄───────────────────────▄█▀─█ <-
-> █──█▀███████████████████████▀█──█ <-
-> █──█────█───█───█───█───█────█──█ <-
-> █──▀█───█───█───█───█───█───█▀──█ <-
-> █───▀█▄▄█▄▄▄█▄▄▄█▄▄▄█▄▄▄█▄▄█▀───█ <-
-> ▀█───█──█───█───█───█───█──█───█▀ <-
-> ─▀█──▀█▄█───█───█───█───█▄█▀──█▀─ <-
-> ──▀█───▀▀█▄▄█───█───█▄▄█▀▀───█▀── <-
-> ───▀█─────▀▀█████████▀▀─────█▀─── <-
-> ────▀█─────▄─────────▄─────█▀──── <-
-> ─────▀██▄───▀▀▀▀▀▀▀▀▀───▄██▀───── <-
-> ────────▀██▄▄───────▄▄██▀──────── <-
-> ───────────▀▀███████▀▀─────────── <-


-> *Paul Jones* <-
-> *@paulwilljones* <-

---

## Intro

---

## Chaos Monkey

```
go get github.com/netflix/chaosmonkey/cmd/chaosmonkey
```

```
$ cat chaosmonkey.toml
[chaosmonkey]
enabled = true
schedule_enabled = true
leashed = false
accounts = ["production", "test"]

[database]
host = "dbhost.example.com"
name = "chaosmonkey"
user = "chaosmonkey"
encrypted_password = "securepasswordgoeshere"

[spinnaker]
endpoint = "http://spinnaker.example.com:8084"
```

---

## Latency Monkey

---

## Conformity Monkey

---

## Doctor Monkey

---

## Janitor Monkey

---

## Security Monkey
https://github.com/Netflix/security_monkey

---

## Chaos Gorilla

---

## kube-monkey
https://github.com/asobti/kube-monkey

```
$ go get github.com/asobti/kube-monkey

$ cat deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: monkey-victim
  namespace: app-namespace
  labels:
    kube-monkey/enabled: enabled
    kube-monkey/identifier: monkey-victim
    kube-monkey/mtbf: '2'
    kube-monkey/kill-mode: "fixed"
    kube-monkey/kill-value: 1
spec:
  template:
    metadata:
      labels:
        kube-monkey/enabled: enabled
        kube-monkey/identifier: monkey-victim
[... omitted ...]
```

```
$ cat config.toml
[kubemonkey]
dry_run = true                           # Terminations are only logged
run_hour = 8                             # Run scheduling at 8am on weekdays
start_hour = 10                          # Don't schedule any pod deaths before 10am
end_hour = 16                            # Don't schedule any pod deaths after 4pm
blacklisted_namespaces = ["kube-system"] # Critical apps live here
time_zone = "America/New_York"           # Set tzdata timezone example. Note the field is time_zone not timezone
```

`kubectl create configmap km-config --from-file=config.toml=km-config.toml` or `kubectl apply -f km-config.yaml`

---

## Chaos Monkey for Spring Boot
https://github.com/codecentric/chaos-monkey-spring-boot

```
<dependency>
    <groupId>de.codecentric</groupId>
    <artifactId>chaos-monkey-spring-boot</artifactId>
    <version>1.0.1</version>
</dependency>
```

```
java -jar your-app.jar --spring.profiles.active=chaos-monkey
```

---

## Chaos Toolkit
http://chaostoolkit.org
[Getting Started](https://www.katacoda.com/chaostoolkit/courses/01-chaostoolkit-getting-started)


---

## Blockade
https://github.com/worstcase/blockade

```
$ cat blockade.yml
containers:
  c1:
    # run commands under tini, so signals are correctly proxied
    image: krallin/ubuntu-tini:trusty
    hostname: c1
    command: ["sh", "-c", "echo I am $HOSTNAME; /bin/sleep 300"]
    volumes: {"/tmp": "/mnt"}

  c2:
    image: krallin/ubuntu-tini:trusty
    hostname: c2
    command: ["sh", "-c", "echo I am $HOSTNAME; /bin/sleep 300"]

  c3:
    image: krallin/ubuntu-tini:trusty
    hostname: c3
    command: ["sh", "-c", "echo I am $HOSTNAME; /bin/sleep 300"]
```

---

## PowerfulSeal
https://github.com/bloomberg/powerfulseal

```
$ cat example_config.yml
```

---

# Muxy
## Proxy for simulating real-world distributed system failures to improve resilience in your applications.
https://github.com/mefellows/muxy

`$ brew install https://raw.githubusercontent.com/mefellows/muxy/master/scripts/muxy.rb`
`$ go get github.com/mefellows/muxy`

```
$ cat config.yml
# Configures a proxy to forward/mess with your requests
# to/from www.onegeek.com.au. This example adds a 5s delay
# to the response.
proxy:
  - name: http_proxy
    config:
      host: 0.0.0.0
      port: 8181
      proxy_host: www.onegeek.com.au
      proxy_port: 80

# Proxy plugins
middleware:
  - name: http_tamperer
    config:
      request:
        host: "www.onegeek.com.au"

  # Message Delay request/response plugin
  - name: delay
    config:
      request_delay: 1000
      response_delay: 500

  # Log in/out messages
  - name: logger
```

`$ muxy proxy --config ./config.yml`

```
$ docker pull mefellows/muxy
$ docker run \
	-d \
	-p 80:80 \
	-v "$PWD/conf":/opt/muxy/conf \
	--privileged \
	mefellows/muxy
```


[Demo](https://asciinema.org/a/121081)


---

## Resources

[awesome-chaos-engineering](https://github.com/dastergon/awesome-chaos-engineering)
[Quick-Start-Guide](https://github.com/Netflix/SimianArmy/wiki/Quick-Start-Guide)
[chaos-engineering-with-kolton-andrus](https://softwareengineeringdaily.com/2018/02/02/chaos-engineering-with-kolton-andrus/)

---

## Thanks

-> [@paulwilljones](https://twitter.com/paulwilljones)

-> Slides can be found [here](https://github.com/paulwilljones/kubecon-chaos-2018)
