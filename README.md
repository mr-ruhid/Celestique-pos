# 🚀 Update Server & Central Admin Panel

![Laravel](https://img.shields.io/badge/Laravel-11.x-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-8.2+-777BB4?style=for-the-badge&logo=php&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)

**Update Server** is a centralized management system designed for POS systems, desktop software, and web applications. It facilitates **Over-the-Air (OTA) updates**, real-time notifications, and remote resource management (images, icons, translations) through a secure RESTful API.

---

## 🌟 Support & Donate

If this system helps your business, consider supporting the development!

<a href="https://kofe.al/ruhidjavadoff">
  <img src="https://img.shields.io/badge/Support%20on-Kofe.al-6f4e37?style=for-the-badge&logo=buy-me-a-coffee&logoColor=white" alt="Support on Kofe.al" height="40">
</a>
<a href="https://paypal.me/ruhidjavadoff">
  <img src="https://img.shields.io/badge/Donate%20via-PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white" alt="Donate via PayPal" height="40">
</a>

---

## 🚀 Key Features

### 📊 Dashboard & Analytics
* **System Overview:** Real-time stats on active subscribers and system health.
* **Version Tracking:** Monitor the latest deployed version versus client usage.

### ☁️ Update Management (OTA)
* **Version Control:** Upload new software versions (ZIP format) directly to the server.
* **Auto-Deployment:** Generates automatic download links for client applications.
* **Release Notes:** Attach change logs to every update.

### 📢 Notification Center
* **Push Broadcasts:** Send instant messages to all connected client devices.
* **Actionable Links:** Include target URLs (Redirects) within notifications for promotions or announcements.

### 👥 Subscriber Manager
* **Device Tracking:** Log unique Device IDs and IP addresses.
* **Access Control:** Manually **Block** or **Activate** specific clients/devices.

### 🎨 Resource Management
* **🖼️ Product Images:** Remotely update and manage product images used within the client app.
* **🎨 Icon Repository:** Upload and serve UI assets (SVG/PNG) for dynamic menu customization.

### 🌍 Localization Hub
* **Multi-language Support:** Manage translations (AZ, EN, RU) from a central database.
* **Dynamic Sync:** Client apps fetch the latest language strings without needing an app update.

---

## 🛠 Tech Stack

| Category | Technology |
| :--- | :--- |
| **Backend** | Laravel (PHP) |
| **Frontend** | HTML, CSS (Bootstrap), Blade Engine |
| **Database** | MySQL |
| **API** | RESTful JSON API |

---

## ⚙️ Installation Guide

Follow these steps to deploy the server:

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/your-username/update-server.git](https://github.com/your-username/update-server.git)
    cd update-server
    ```

2.  **Install Dependencies**
    ```bash
    composer install
    ```

3.  **Environment Setup**
    Copy the example file and configure your database credentials:
    ```bash
    cp .env.example .env
    ```
    *Open `.env` and edit:*
    ```env
    DB_DATABASE=update_server_db
    DB_USERNAME=root
    DB_PASSWORD=your_password
    ```

4.  **Database Migration**
    ```bash
    php artisan migrate
    ```

5.  **Filesystem**
    Create the symbolic link for public storage:
    ```bash
    php artisan storage:link
    ```

6.  **Run Server**
    ```bash
    php artisan serve
    ```

---


## 🌐 Update & Plugins Center (Live Demo)

You can access the active system via the link below:

### 👉 **[www.rjpos.ruhidjavadov.site](https://www.rjpos.ruhidjavadov.site/)**

---

## 🌟 Support & Donate
...


## 📡 API Usage

The system provides a RESTful API for client applications to communicate with the server.

### Check for Updates
Endpoint to verify if a new version is available.

* **URL:** `/api/check-update`
* **Method:** `GET`
* **Query Param:** `current_version` (e.g., `1.0.0`)

**Request Example:**
```http
GET /api/check-update?current_version=1.0.0
Response Example (JSON):

JSON

{
  "update_available": true,
  "latest_version": "1.1.0",
  "download_url": "[https://yoursite.com/storage/updates/v1.1.0.zip](https://yoursite.com/storage/updates/v1.1.0.zip)",
  "release_notes": "Fixed login bug and added dark mode.",
  "force_update": false
}
📞 Contact & Support
For custom integration or support:

Email: ruhidjavadoff@gmail.com

Phone: +994 50 663 60 31

Developer: Ruhid Javadov

🛡 License
This project is proprietary software. All rights reserved. Copyright © 2026 Update Server.


