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

Principles of Chaos Engineering

[Chaos Engineering is the discipline of experimenting on a distributed system in order to build confidence in the system’s capability to withstand turbulent conditions in production](https://principlesofchaos.org)

Run disciplined chaos experiments to identify weak points in your system and fix them before they become a problem.

^

-> I. Plan an experiment <-
-> Create a hypothesis. What could go wrong? <-

^

-> II. Contain the blast radius <-
-> Execute the smallest test that will teach you something. <-

^

-> III. Scale or squash
-> Find an issue? Job well done. Otherwise increase the blast radius until you’re at full scale. <-

---

## kube-monkey
https://github.com/asobti/kube-monkey

-> An implementation of Netflix's Chaos Monkey for Kubernetes clusters <-

-> It randomly deletes Kubernetes pods in the cluster encouraging and validating the development of failure-resilient services. <-

`$ go get github.com/asobti/kube-monkey`


~~~ {.15}
$ cat kube-monkey-config-map.yaml
apiVersion: v1
kind: ConfigMap
metadata:
	name: kube-monkey-config-map
	namespace: kube-system
data:
	config.toml: |
		[kubemonkey]
		dry_run = true                           # Terminations are only logged
		run_hour = 8                             # Run scheduling at 8am on weekdays
		start_hour = 10                          # Don't schedule any pod deaths before 10am
		end_hour = 16                            # Don't schedule any pod deaths after 4pm
		blacklisted_namespaces = ["kube-system"] # Critical apps live here
		time_zone = "America/New_York"           # Set tzdata timezone example. Note the field is time_zone not timezone
~~~

`$ kubectl apply -f km-monkey-config-map.yaml`


~~~ {.26}
$ cat kube-monkey-deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
	name: kube-monkey
	namespace: kube-system
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: kube-monkey
    spec:
      containers:
        - name: kube-monkey
          command:
            - "/kube-monkey"
          args: ["-v=5", "-log_dir=/var/log/kube-monkey"]
          image: kube-monkey:v0.1.0
          volumeMounts:
            - name: config-volume
              mountPath: "/etc/kube-monkey"
      volumes:
        - name: config-volume
          configMap:
            name: kube-monkey-config-map
~~~

`$ kubectl create -f kube-monkey-deployment.yaml`

---

## kube-monkey
https://github.com/asobti/kube-monkey

`$ go get github.com/asobti/kube-monkey`


~~~ {.19}
$ cat victim-deployment.yaml
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
[...]
~~~

`$ kubectl create -f victim-deployment.yaml`

---

## Chaos Monkey for Spring Boot
https://github.com/codecentric/chaos-monkey-spring-boot

-> This project provides Chaos Monkey for Spring Boot and will try to attack your running Spring Boot App. <-

```
$ cat pom.xml
<dependency>
    <groupId>de.codecentric</groupId>
    <artifactId>chaos-monkey-spring-boot</artifactId>
    <version>1.0.1</version>
</dependency>
```

```
$ cat application.properties
spring.profiles.active=chaos-monkey
chaos.monkey.enabled=true
chaos.monkey.assaults.latencyActive=true
chaos.monkey.watcher.controller=true
chaos.monkey.assaults.level=3
```

---

## Chaos Monkey for Spring Boot
https://github.com/codecentric/chaos-monkey-spring-boot

~~~ {.12}
package com.example.chaos.monkey.chaosdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ChaosDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChaosDemoApplication.class, args);
	}
}
~~~~~~~~~~~~~~


~~~ {.21}
package com.example.chaos.monkey.chaosdemo;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author Benjamin Wilms
 */
@Controller
public class HelloController {

		@GetMapping("/hello")
		public ResponseEntity<String> sayHello() {
				return ResponseEntity.ok(sayHelloPlease());
		}

		private String sayHelloPlease() {
				return "Hello!";
		}
}
~~~~~~~~~~~~~~

```
$ java -jar your-app.jar --spring.profiles.active=chaos-monkey
```

---

## PowerfulSeal
https://github.com/bloomberg/powerfulseal

`$ pip install powerfulseal`

-> Interactive mode <-

`$ powerfulseal --interactive --kube-config ~/.kube/config --inventory-kubernetes -v`

^

-> Autonomous mode <-

~~~ {.49}
$ cat example_config.yml
config:
  minSecondsBetweenRuns: 60
  maxSecondsBetweenRuns: 360

# the scenarios describing actions on nodes
nodeScenarios:
  - name: "scenario1"
    match:
      - property:
        name: "name"
        value: "minion-*"
      - property:
        name: "ip"
        value: "127.0.0.1"
      - property:
        name: "group"
        value: "minion"

  # time of execution filters
  # to restrict the actions to work days, you can do
  - dayTime:
    onlyDays:
      - "monday"
      - "tuesday"
      - "wednesday"
      - "thursday"
      - "friday"
    startTime:
      hour: 10
      minute: 0
      second: 0
    endTime:
      hour: 17
      minute: 30
      second: 0

    # The actions will be executed in the order specified
    actions:
      - stop:
          force: false
      - wait:
          seconds: 30
      - start:
      - execute:
          cmd: "sudo service docker restart"
...
~~~

---

~~~ {.50}
...
# the scenarios describing actions on kubernetes pods
podScenarios:
  - name: "delete random pods"
    match:
      - namespace:
        name: "doomsday"
      - deployment:
          name: "doomsday"
          namespace: "example"
      - labels:
          namespace: "something"
          selector: "app=true,something=1"
    filters:
      - property:
        name: "name"
        value: "application-X-*"
      - property:
        name: "state"
        value: "Running"

      # time of execution filters
      # to restrict the actions to work days, you can do
      - dayTime:
          onlyDays:
            - "monday"
            - "tuesday"
            - "wednesday"
            - "thursday"
            - "friday"
          startTime:
            hour: 10
            minute: 0
            second: 0
          endTime:
            hour: 17
            minute: 30
            second: 0

    # The actions will be executed in the order specified
    actions:
      - kill:
          probability: 0.5
          force: true
      - wait:
          seconds: 5
      - kill:
          probability: 1
          force: true
~~~

---

## Takeaways

-> In order to prevent failures from happening, there is a need to be proactive in our efforts to learn from failure. <-

-> Chaos Engineering is accessible and easy to implement <-

-> Start testing today <-

---

## Resources

[awesome-chaos-engineering](https://github.com/dastergon/awesome-chaos-engineering)
[Simian Army Quick-Start-Guide](https://github.com/Netflix/SimianArmy/wiki/Quick-Start-Guide)
[Software Engineering Daily - Chaos Engineering with Kolton Andrus](https://softwareengineeringdaily.com/2018/02/02/chaos-engineering-with-kolton-andrus/)
[O'Reilly Choas Engineering](http://www.oreilly.com/webops-perf/free/chaos-engineering.csp)
[Chaos Toolkit - Getting Started](https://www.katacoda.com/chaostoolkit/courses/01-chaostoolkit-getting-started)
[Openshift Learning Portal - Fault Injection](https://learn.openshift.com/servicemesh/6-fault-injection)

[kube-monkey](https://github.com/asobti/kube-monkey)
[Spring Boot Chaos Monkey](https://github.com/codecentric/chaos-monkey-spring-boot)
[PowerfulSeal](https://github.com/bloomberg/powerfulseal)

---

## Thanks

-> [@paulwilljones](https://twitter.com/paulwilljones)

-> Slides can be found [here](https://github.com/paulwilljones/kubecon-chaos-2018)
