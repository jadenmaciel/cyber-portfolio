# Windows Domain Deployment — Active Directory, DNS & DHCP Setup

## 1. Title & Outcome

**Windows Domain Deployment**

Deployed a functional Windows Server 2025 domain controller with integrated DNS and DHCP, created a secure domain forest, and successfully joined a Windows 11 client system.

---

## 2. Problem / Objectives

Demonstrate the process of building a complete Windows domain environment — including server promotion, DNS and DHCP configuration, and client domain integration — to replicate enterprise-level identity management and authentication in a lab setting.

Objectives:

- Promote Windows Server 2025 to a **Domain Controller**.

- Configure **DNS** and **DHCP** roles.

- Join a Windows 11 client to the new domain.

- Create and manage **Active Directory users and groups**.

- Validate proper authentication and domain communication.

---

## 3. Environment & Prerequisites

- **Host platform:** VirtualBox on Windows 11 Pro host

- **Server VM:** Windows Server 2025 Desktop (DC01)

- **Client VM:** Windows 11 Enterprise (Win11Client)

- **CPU/RAM:** 2 vCPU | 4 GB RAM per VM

- **Network:** Internal Network (`intnet`)

- **Static IP:** 192.168.12.1 / 24

- **Administrator credentials:** `Administrator / !QAZ1qaz!QAZ1qaz`

- **User template passwords:** `#EDC3edc#EDC3edc`

---

## 4. Steps Summary

1. Powered on `Windows Server 2025 Desktop` VM.

2. Configured `Internal Network` adapter → `intnet`.

3. Set static IP `192.168.12.1` and renamed host to `DC01`.

4. Installed **Active Directory Domain Services**, **DNS**, and **DHCP** roles.

5. Promoted DC01 to Domain Controller → created forest `jmaciel.com`.

6. Configured DHCP scope `192.168.12.6–192.168.12.249`.

7. Joined Windows 11 VM to the domain.

8. Created AD group **Office Workers** and two user accounts.

9. Logged in as a new user → password change prompt.

10. Verified domain membership via `whoami /fqdn`.

---

## 5. Evidence (Text-Only)

### **Evidence 01 — Server Roles Installed**

*What would be visible:* Server Manager "Installation Progress" summary.

*Text excerpt:*

```text

Configuration succeeded: Active Directory Domain Services, DNS Server, DHCP Server.

```

*Why this matters:* Confirms DC01 successfully installed all roles required for domain promotion.

---

### **Evidence 02 — Domain Login Screen**

*What would be visible:* Windows Server login screen displaying domain context.

*Text excerpt:* `Sign in to: JMACIEL \ Administrator`

*Why this matters:* Shows the server has been promoted and joined to its own Active Directory domain.

---

### **Evidence 03 — DHCP Scope Created**

*What would be visible:* DHCP Manager → Address Pool pane.

*Text excerpt:*

```text

Address Pool: 192.168.12.6 – 192.168.12.249 (Active)

Router: 192.168.12.1    DNS Server: 192.168.12.1

```

*Why this matters:* Validates the scope is active and ready to lease IP addresses to clients.

---

### **Evidence 04 — Client Joined to Domain**

*What would be visible:* Dialog box: "Welcome to the jmaciel.com domain."

*Text excerpt:* `Welcome to the jmaciel.com domain`

*Why this matters:* Confirms domain trust and successful Active Directory authentication.

---

### **Evidence 05 — AD Users and Computers**

*What would be visible:* Active Directory Users and Computers showing the client PC.

*Text excerpt:* `Computers → WIN11CLIENT  Status: Enabled`

*Why this matters:* Verifies the client object is registered in Active Directory.

---

### **Evidence 06 — Group Membership**

*What would be visible:* "Office Workers" group → Members tab.

*Text excerpt:* `Members: jsmith, adoe`

*Why this matters:* Confirms user accounts were added to the new group successfully.

---

### **Evidence 07 — User Password Change**

*What would be visible:* Windows login prompt → password reset screen.

*Text excerpt:* `User must change password at next login`

*Why this matters:* Demonstrates Group Policy and password complexity enforcement.

---

### **Evidence 08 — Domain Identity Verification**

*What would be visible:* Command Prompt output of `whoami /fqdn`.

*Text excerpt:*

```text

whoami /fqdn

CN=jsmith, OU=Office Workers, DC=jmaciel, DC=com

```

*Why this matters:* Proves the user is authenticated and resolved within the domain's directory hierarchy.

---

## 6. Results & Validation

* DC01 operates as a fully functional Domain Controller with DNS and DHCP services.

* The Windows 11 client successfully joined the domain and received a DHCP lease.

* User logins and password policies function as expected.

* AD Users and Computers shows both the client and users under the domain.

---

## 7. Timeline / Activity Dates

* **2025-10-27 —** Configured DC01 network and installed roles

* **2025-10-28 —** Promoted server to domain controller (`jmaciel.com`)

* **2025-10-29 —** Created DHCP scope and joined Windows 11 client

* **2025-10-30 —** Added Office Workers group and new users

* **2025-10-31 —** Validated domain logins and policy enforcement

---

## 8. What I Learned

* Deployed Active Directory Domain Services and configured domain trusts.

* Managed DNS and DHCP integration to support client address leasing.

* Used Server Manager and PowerShell for role installation and promotion.

* Understood user authentication flows within AD and Group Policy enforcement.

* Practiced administrative principles of least privilege and password complexity enforcement.

---

## 9. Troubleshooting Notes

* **DHCP role warnings:** Ignored "no static IP" warning and set manual address.

* **DNS delegation:** Warning was expected for first domain controller.

* **Network adapter issues:** Resolved by disconnecting/reconnecting `intnet` adapter.

* **User creation errors:** Ensured password met complexity policy (#, upper/lower, digit).

---

## 10. Author / Ownership

This project was performed hands-on by **Jaden Maciel-Shapiro** between **2025-10-27 and 2025-10-31**.

It demonstrates domain controller deployment, DHCP/DNS integration, and Active Directory user management in a virtual lab environment.

Repository published for professional portfolio use.
