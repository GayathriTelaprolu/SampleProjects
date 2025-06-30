# Calendly Appointment Verification Webhook

This Flask-based webhook checks if a user has a confirmed appointment on Calendly for a given email and date. It is designed to be integrated with Dialogflow CX and deployed via Google Cloud Run using the Google Cloud SDK.

---

## 📁 Project Structure

```
.
├── Dockerfile
├── .dockerignore
├── main.py
├── requirements.txt
└── README.md
```

---

## ⚙️ Requirements

- Python 3.8+
- Google Cloud SDK installed and initialized
- Docker installed
- A Google Cloud project with billing enabled
- Calendly API Key and User URI

---

## 🔑 Environment Variables

Create a `.env` file or configure the environment in Cloud Run:

```env
CALENDLY_API_KEY=your_calendly_api_key
USER_URI=https://api.calendly.com/users/<your-user-id>
```

---

## 🚀 Deployment via Google Cloud SDK

### 1. Authenticate and Set Project

```bash
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

### 2. Build Docker Image

```bash
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/verify-webhook
```

### 3. Deploy to Cloud Run

```bash
gcloud run deploy verify-webhook \
  --image gcr.io/YOUR_PROJECT_ID/verify-webhook \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars CALENDLY_API_KEY=your_calendly_api_key,USER_URI=https://api.calendly.com/users/<your-user-id>
```

---

## 📬 Postman Test Guide

### ✅ URL

```
https://<your-cloud-run-url>/
```

### ✅ Method

```
POST
```

### ✅ Headers

```
Content-Type: application/json
```

### ✅ Body (Raw > JSON)

```json
{
  "sessionInfo": {
    "parameters": {
      "email": "test@example.com",
      "date": "2025-06-30"
    }
  }
}
```

---

## ✅ Possible Responses

- ✅ `"Appointment is confirmed for this date."`
- ❌ `"No matching appointment found for this email and date."`
- ❌ `"Missing email or date."`
- ❌ `"Error fetching events: ..."`

---

## 🧠 Dialogflow CX Integration

- Requires: `email` and `date` parameters
- Tag is not required — works on POST with valid parameters

---

## 📦 Tech Stack

- Python (Flask)
- Calendly REST API
- Google Cloud Run
- Dialogflow CX (optional)

---

## 📝 License

MIT License
