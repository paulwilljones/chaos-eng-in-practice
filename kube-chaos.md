%title: CloudNative London 2018 - Chaos Engineering in Practice
%author: @paulwilljones
%date: 2018-05-01

-> # Chaos Engineering in Practice <-

-> CloudNative London 2018 <-
-> September 28 2018 <-

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
-> *github/paulwilljones/chaos-eng-in-practice* <-


---

# What is Chaos Engineering?

---

# What is Resilience Engineering?

---

# Principles of Chaos Engineering

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

# Why Should We Care?

Failure will happen
^

As distributed systems have grown much more complex, failures have become much more difficult to predict.
^

-> Fallacies of distributed computing:
^
-> 1. The network is reliable.
^
-> 2. Latency is zero.
^
-> 3. Bandwidth is infinite.
^
-> 4. The network is secure.
^
-> 5. Topology doesn't change.
^
-> 6. There is one administrator.
^
-> 7. Transport cost is zero.
^
-> 8. The network is homogeneous.

---

# Examples of Chaos Tooling
^

## Istio

What is it?

Why is it necessary?

How does it do it?

What does it enable us to do?

---

# Istio Fault Injection
^

A VirtualService defines the rules that control how requests for a service are routed within an Istio service mesh.
^

A DestinationRule configures the set of policies to be applied to a request after VirtualService routing has occurred.
^

This facilitates fault injection by intercepting traffic destined for pods

---

-> Demo <-

---

# Istio Fault Injection

When would you use this?

---

# Istio Circuit Breaking

---

# chaostoolkit

^
-> [The Chaos Toolkit aims to be the simplest and easiest way to explore building, and automating, your own Chaos Engineering Experiments.](chaostoolkit.org)
^

- Usage
* Drivers:
  - Kubernetes
  - AWS
  - GCE
  - Azure
  - Spring
  - Cloud Foundry
  - Prometheus

---

# chaostoolkit-kubernetes

Driver for interfacing with the kube api to translate experiments into procedural actions

Actions:
- terminate_pod
- remove_service_endpoint
- delete_nodes

---

# chaostoolkit-google-cloud

Driver to call GCE api to perform experiment actions

Actions:
- swap_nodepool
- delete_nodepool

---

# chaostoolkit + Istio

Use kubernetes driver (or impl) to create istio resources?

- delete istio resources

^
Demo

---

# CNCF WG

---

# Takeaways

-> In order to prevent failures from happening, there is a need to be proactive in our efforts to learn from failure. <-
^
-> Chaos Engineering is accessible and easy to implement <-
^
-> Start testing today <-
^

---

# Resources

[awesome-chaos-engineering](https://github.com/dastergon/awesome-chaos-engineering)

[Simian Army Quick-Start-Guide](https://github.com/Netflix/SimianArmy/wiki/Quick-Start-Guide)
[Software Engineering Daily - Chaos Engineering with Kolton Andrus](https://softwareengineeringdaily.com/2018/02/02/chaos-engineering-with-kolton-andrus/)
[O'Reilly Chaos Engineering](http://www.oreilly.com/webops-perf/free/chaos-engineering.csp)

[Istio Fault Injection](https://istio.io/docs/concepts/traffic-management/#fault-injection)
[Chaos Toolkit](https://chaostoolkit.org/)
[Chaos Toolkit - Katacoda](https://www.katacoda.com/chaostoolkit/courses/01-chaostoolkit-getting-started)
[Openshift Learning Portal - Fault Injection](https://learn.openshift.com/servicemesh/6-fault-injection)
[kube-monkey](https://github.com/asobti/kube-monkey)
[Spring Boot Chaos Monkey](https://github.com/codecentric/chaos-monkey-spring-boot)
[PowerfulSeal](https://github.com/bloomberg/powerfulseal)

---

# Thanks

-> [@paulwilljones](https://twitter.com/paulwilljones)

-> Slides can be found https://github.com/paulwilljones/chaos-eng-in-practice
