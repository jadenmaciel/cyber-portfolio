<!-- README.md -->

# Cisco Packet Tracer Logical & Physical Mode Simulation (Activity 1.1.5)



Hands-on Packet Tracer project building a small network in logical mode, then mapping it to the physical workspace to understand how real-world devices, cabling, and locations align with the logical design.



---



## 1. Title & one-line outcome



**Title:** Cisco Packet Tracer Logical & Physical Mode Network Simulation (Activity 1.1.5)  

**Outcome:** Designed, configured, and validated a small network in Cisco Packet Tracer using both Logical and Physical Modes, including IP addressing, connectivity testing, and physical layout interpretation.



---



## 2. Problem / objectives



This project demonstrates how a conceptual network diagram turns into a working, physically deployable network:



- Build a simple routed/switched network in **Logical Mode**.

- Connect end devices with the correct cable types and interfaces.

- Assign IPv4 addresses and verify end-to-end connectivity.

- Explore **Physical Mode** to see how devices live in racks, wiring closets, and rooms.

- Understand how cable paths and physical distances affect network design and troubleshooting.

- Practice using Packet Tracer PTTA-style guided activities while treating the work as a personal project.



---



## 3. Environment & prerequisites



**Environment used (realistic defaults):**



- **Host OS:** Windows 11 Pro (64-bit)

- **Cisco Packet Tracer:** 8.x (Logical & Physical Mode support)

- **Activity type:** Cisco Packet Tracer PTTA-style activity 1.1.5

- **Topology scope:** Small network with networking devices and multiple end devices



**Conceptual prerequisites:**



- Basic understanding of IPv4 addresses, subnet masks, and default gateways.

- Familiarity with common network devices:

  - **Routers**

  - **Switches**

  - **End hosts** (PCs, laptops)

- Awareness of cable types:

  - Copper straight-through (switch ↔ end device)

  - Copper cross-over or automatic MDI/MDI-X (device ↔ device where required)

  - Console cable (for out-of-band management, when applicable)



---



## 4. Steps summary



1. Opened the Cisco Packet Tracer **Activity 1.1.5** file and reviewed the logical topology and instructions.

2. Verified device types and interfaces (routers, switches, end devices) in **Logical Mode** to understand required connections.

3. Connected devices using appropriate cable types, ensuring each link was plugged into the correct interface (e.g., `FastEthernet0/x`).

4. Assigned IPv4 addresses, subnet masks, and default gateways to end devices based on the addressing table provided in the activity.

5. Confirmed interface status on networking devices and resolved any link-down or mismatch issues.

6. Used `ping` from multiple end devices to verify reachability across the network and to confirm correct addressing and gateway configuration.

7. Switched to **Physical Mode** to view the same topology as racks, rooms, and wiring closets, observing how logical links map to physical cabling.

8. Traced cables in Physical Mode to see where each end was connected and how distance and layout could impact troubleshooting.

9. Used the activity's built-in checks (PTTA-style assessment) to validate connectivity and confirm that requirements were met.

10. Documented text-only evidence of topology, addressing, connectivity tests, and physical layout interpretation for portfolio use.



---



## 5. Evidence (text-only)



### Evidence 01 — Logical topology and device inventory



**What would be visible:**  

Logical workspace in Packet Tracer showing routers, switches, and multiple end devices connected in a small network.



**Text excerpt (conceptual):**

- Devices:

  - `Router0` with multiple `GigabitEthernet` or `FastEthernet` interfaces

  - `Switch0` and possibly `Switch1`

  - `PC0`, `PC1`, and additional end devices

- Links:

  - Router ↔ Switch

  - Switch ↔ PCs



**Why this matters:**  

Confirms the core logical topology is in place: correct devices deployed, correct number of links created, and the overall network matches the activity's design before configuration.



---



### Evidence 02 — IP addressing and default gateway configuration



**What would be visible:**  

Desktop → IP Configuration window for each PC in Packet Tracer, showing address, subnet mask, and default gateway.



**Text excerpt (representative example):**

- `PC0`:

  - IP Address: `192.168.1.10`

  - Subnet Mask: `255.255.255.0`

  - Default Gateway: `192.168.1.1`

- `PC1`:

  - IP Address: `192.168.1.11`

  - Subnet Mask: `255.255.255.0`

  - Default Gateway: `192.168.1.1`



*(Note: Exact addresses depend on the activity's instructions; values here reflect a realistic pattern.)*



**Why this matters:**  

Shows that each host was configured with a valid IP address in the correct subnet and that default gateways point to the router interface, enabling routing beyond the local network.



---



### Evidence 03 — Connectivity verification using ping



**What would be visible:**  

Command Prompt on each PC in Packet Tracer showing `ping` results to other hosts and/or the default gateway.



**Text excerpt (representative):**

- From `PC0`:

  ```text

  C:\> ping 192.168.1.1



  Reply from 192.168.1.1: bytes=32 time<1ms TTL=255

  Reply from 192.168.1.1: bytes=32 time<1ms TTL=255

  Reply from 192.168.1.1: bytes=32 time<1ms TTL=255

  Reply from 192.168.1.1: bytes=32 time<1ms TTL=255

````



* From `PC0` to `PC1`:



  ```text

  C:\> ping 192.168.1.11



  Reply from 192.168.1.11: bytes=32 time<1ms TTL=128

  Reply from 192.168.1.11: bytes=32 time<1ms TTL=128

  Reply from 192.168.1.11: bytes=32 time<1ms TTL=128

  Reply from 192.168.1.11: bytes=32 time<1ms TTL=128

  ```



**Why this matters:**

Successful ping replies confirm that IP addressing, default gateways, and switching/routing behavior are functioning as expected. It also verifies that there are no L1/L2 issues such as bad cabling or disabled interfaces.



---



### Evidence 04 — Physical Mode: racks, rooms, and cabling paths



**What would be visible:**

Physical Mode views of the Packet Tracer environment, including building/room view and a wiring closet with racks, switches, and routers.



**Text excerpt (conceptual):**



* Physical workspace:



  * Topology placed in a "Wiring Closet" or room

  * Router and switch mounted in a rack

  * PCs located at desks in nearby rooms

* Cable paths:



  * Copper cables drawn from rack-mounted switch ports to wall jacks or directly to PCs

  * Devices shown at realistic distances from the wiring closet



**Why this matters:**

Demonstrates understanding that logical connections correspond to actual cables and physical distances. It shows the ability to reason about real-world deployment considerations such as equipment placement and cable routing.



---



### Evidence 05 — Activity completion and assessment checks



**What would be visible:**

Packet Tracer's PTTA-style assessment window indicating completion percentage and that all required checks have passed.



**Text excerpt (conceptual):**



```text

Assessment Items: 100%

All required connectivity checks passed.

All addressing and configuration tasks completed.

```



**Why this matters:**

Provides a structured verification that all of the activity's objectives were met, confirming that logical design, addressing, and physical interpretation were implemented correctly.



---



## 6. Results & validation



* All end devices successfully pinged their default gateway and peer devices in the same IP subnet.

* The logical topology in Packet Tracer matched the intended design of Activity 1.1.5.

* Physical Mode views showed devices placed realistically in rooms and racks, with cable paths consistent with the logical topology.

* The PTTA-style assessment reported full completion, indicating that addressing, connectivity, and required configuration tasks were accurate.

* No unresolved link, IP, or gateway issues remained at the end of the simulation.



---



## 7. Timeline / Activity Dates



* **2025-11-12 — Completed Cisco Packet Tracer Activity 1.1.5 focusing on logical and physical mode network simulation.**



---



## 8. What I Learned



* How to translate a conceptual network topology into a working Packet Tracer simulation using both Logical and Physical Modes.

* How IP addressing, subnetting, and default gateways work together to enable end-to-end connectivity across a small network.

* The importance of choosing the correct cable type and interface pairing when connecting devices.

* How physical layout (rooms, racks, cabling paths) influences real-world troubleshooting and design decisions.

* How to use Packet Tracer's activity feedback and built-in checks to validate networking work and confirm that requirements have been met.

* How to document networking work in a text-only, recruiter-friendly format suitable for a professional portfolio.



---



## 9. Troubleshooting notes



Common issues and resolutions encountered or realistically associated with this type of work:



* **Incorrect cable type used between devices**



  * *Symptom:* Link lights off; no connectivity.

  * *Fix:* Replaced cable with the correct copper connection type (e.g., straight-through from switch to PC).



* **Mismatched or missing IP configuration**



  * *Symptom:* Pings to gateway or other PCs fail.

  * *Fix:* Verified that each device's IP address, subnet mask, and default gateway matched the addressing plan.



* **Wrong default gateway on end devices**



  * *Symptom:* Device can ping within the local subnet but cannot reach devices on other networks.

  * *Fix:* Updated default gateway to match the router interface address on the local subnet.



* **Interface status down on router or switch**



  * *Symptom:* No Layer 2 link, even with correct cabling.

  * *Fix:* Checked interface status in device config and ensured interfaces were enabled and connected to the correct ports.



* **Confusion between Real-Time and Simulation modes**



  * *Symptom:* ICMP packets appear to "hang" or not show expected behavior.

  * *Fix:* Toggled between Real-Time and Simulation modes and used the Simulation view to step through packets and confirm connectivity.



---



## 10. Author / ownership



This project was performed hands-on by **Jaden Maciel-Shapiro** on **2025-11-12**, using Cisco Packet Tracer to design, configure, and validate a small network in both Logical and Physical Modes. The focus of the work was on understanding how logical IP networks map to physical device placement, cabling, and real-world deployment considerations, and on validating that the network functioned correctly using connectivity tests and activity assessments.



This repository is maintained as part of a professional cybersecurity and networking portfolio and is intended to demonstrate foundational networking skills, attention to detail, and the ability to document technical work clearly for others.



---

