# 🌐 Token-Analysis-in-Query-Parameters

---

## 📑 Project Overview
This laboratory project demonstrates a critical web security flaw: the transmission of sensitive authentication data (Session Tokens and User IDs) via the **HTTP GET** method. The goal is to prove how easily these "secrets" can be leaked through browser history, proxy logs, and unauthorized visual access.

---

## 🛠 Project Architecture & Setup
The project simulates a corporate authentication gateway with a specialized "Vulnerability Audit" dashboard.

| Component | Technology | Role |
| :--- | :--- | :--- |
| **Frontend** | HTML5 / CSS3 (Dark Theme) | User Interface |
| **Logic** | JavaScript (ES6) | Client-side Auth & Token Generation |
| **Analysis Platform** | Firefox Developer Edition (Kali Linux) | Forensic Inspection |

---

## 🛠 Technical Execution (Proof of Concept)

### 1. The Vulnerable Gateway (`login.html`)
The gateway was configured with a specific administrative credential set for testing purposes:
* **Target User:**
* **Target Pass:**

Upon successful authentication, the script generates a **Base64-encoded Session Token** and appends it directly to the URL string.



### 2. Forensic Evidence Capture (Screenshots)

#### **A. Authentication Phase**
The login portal was used to initiate a secure session. This is the starting point of the data flow.
![Login Interface](assets/01_login_page.png)

#### **B. The "Smoking Gun" (URL Leak)**
As seen in the dashboard, the entire session state is visible in the address bar. An attacker with access to the browser history or server logs can hijack this session instantly.
!https://www.proofpoint.com/us/threat-reference/data-leak(assets/02_url_disclosure_proof.png)

#### **C. Persistent Leak (Browser History)**
Even after the user logs out, the sensitive token remains stored in the browser's persistent history database.
![Browser History Vulnerability](assets/03_browser_history_leak.png)

---

## 🔍 Security Analysis & Findings

### 1. Root Cause Analysis
The application utilizes the **URL Query String** to maintain state. Because URLs are not considered "private" by browsers or network infrastructure (proxies/firewalls), this constitutes a massive data leak.

### 2. Threat Vector: Session Hijacking
A malicious actor could use "Shoulder Surfing" or "Log Analysis" to steal the `session_token`. Since the token is tied to the `ADMIN_FULL_ACCESS` level, this would result in a full system compromise.

---

## 🛡 Remediation Strategy (How to Fix)

To secure this application, the following industry-standard practices must be implemented:

1.  **Switch to HTTP POST:** Sensitive data must be sent in the **Request Body**, not the URL.
2.  **Secure Cookies:** Use `Set-Cookie` with `HttpOnly`, `Secure`, and `SameSite=Strict` flags to store tokens.
3.  **HSTS Implementation:** Enforce HTTPS to prevent Man-in-the-Middle (MitM) attacks during transmission.
4.  **Cache Control:** Use the following headers to prevent browser indexing:
    ```http
    Cache-Control: no-store, no-cache, must-revalidate
    Pragma: no-cache
    ```
