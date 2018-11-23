%title: Docker London - Chaos Engineering in Practice
%author: @paulwilljones    sli.do -> #chaosenginpractice
%date: 2018-11-22

# What is Chaos Engineering?

^

-> Thoughtful, planned experiments designed to reveal the weaknesses in our systems - Kolton Andrus (cofounder and CEO of Gremlin Inc)

-> Chaos isn’t done to cause problems; it is done to reveal them - Nora Jones (Netflix)


-> [Chaos Engineering is the discipline of experimenting on a distributed system in order to build confidence in the system’s capability to withstand turbulent conditions in production](https://principlesofchaos.org)


---

# Principles of Chaos Engineering
^

-> I. Plan an experiment <-
-> Create a hypothesis. What could go wrong? <-

---

# Principles of Chaos Engineering

-> II. Contain the blast radius <-
-> Execute the smallest test that will teach you something. <-

---

# Principles of Chaos Engineering

-> III. Scale or squash
-> Find an issue? Job well done. Otherwise increase the blast radius until you’re at full scale. <-

---

# Why Should We Care?
^

-> Failure is inevitable
^

-> As distributed systems have grown more complex, failures have become more difficult to predict
^

-> A reliance on managed services takes away control to ensure resiliency

---

# Chaos Engineering tools
^

## Istio
^

-> Open source service mesh that layers transparently onto existing distributed applications.
^


-> ## Traffic Management
^

-> ## Security
^

-> ## Observability

---

# Istio Fault Injection
^

-> Istio enables protocol-specific fault injection into the network, instead of killing pods or delaying or corrupting packets at the TCP layer.
^

-> *Key Terms
^
-> A VirtualService defines the rules that control how requests for a service are routed within an Istio service mesh.
^

-> A DestinationRule configures the set of policies to be applied to a request after VirtualService routing has occurred.

---

-> Demo <-

---

# chaostoolkit
^

-> [The Chaos Toolkit aims to be the simplest and easiest way to explore building, and automating, your own Chaos Engineering Experiments.](chaostoolkit.org)
^

-> * Core features
^
-> Steady State Hypothesis
^
-> Probes
^
-> Actions
^
-> Rollback
^

-> * Drivers:
->  Kubernetes
->  AWS
->  GCE
->  Azure
->  Spring
->  Cloud Foundry
->  Prometheus

---

# chaostoolkit-kubernetes
^

-> The Chaos Toolkit driver extension for Kubernetes.

-> Exposes a set of activities to interact and query your Kubernetes system.

-> Run chaos engineering experiments against applications that live inside your Kubernetes clusters.
^

-> *Actions:
-> start_microservice
-> kill_microservice
-> scale_microservice
-> terminate_pods
-> remove_service_endpoint
-> create_node
-> cordon_node
-> uncordon_node
-> drain_node
-> delete_nodes
^

-> *Probes:
-> all_microservices_healthy
-> microservice_available_and_healthy
-> microservice_is_not_available
-> service_endpoint_is_initialized
-> deployment_is_not_fully_available
-> read_pod_logs
-> pods_in_phase
-> count_pods
-> get_nodes

---

-> Demo

---

# Takeaways
^

-> Increased complexity in systems has caused failures to be more difficult to predict <-
^

-> In order to prevent failures from happening, there is a need to be proactive in our efforts to learn from failure <-
^

-> Chaos engineering addresses all aspects of the sociotechnical system of software development <-
^

-> Start causing (controlled) chaos today <-

---

# Resources

[awesome-chaos-engineering](https://github.com/dastergon/awesome-chaos-engineering)

[Simian Army Quick-Start-Guide](https://github.com/Netflix/SimianArmy/wiki/Quick-Start-Guide)
[Software Engineering Daily - Chaos Engineering with Kolton Andrus](https://softwareengineeringdaily.com/2018/02/02/chaos-engineering-with-kolton-andrus/)
[O'Reilly Chaos Engineering](http://www.oreilly.com/webops-perf/free/chaos-engineering.csp)

[Istio Fault Injection](https://istio.io/docs/concepts/traffic-management/#fault-injection)
[Chaos Toolkit](https://chaostoolkit.org/)

[Istio Fault Injection - Katacoda](https://katacoda.com/courses/istio/increasing-reliability/simulating-failures-between-microservices)
[Chaos Toolkit - Katacoda](https://www.katacoda.com/chaostoolkit/courses/01-chaostoolkit-getting-started)
[Openshift Learning Portal - Fault Injection](https://learn.openshift.com/servicemesh/6-fault-injection)

[CNCF Chaos Engineering](https://github.com/chaoseng/wg-chaoseng)

---

# Thanks

-> [@paulwilljones](https://twitter.com/paulwilljones)

-> Slides can be found https://github.com/paulwilljones/chaos-eng-in-practice
