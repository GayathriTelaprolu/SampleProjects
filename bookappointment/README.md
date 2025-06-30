# Calendly Link Generator Webhook

This is a simple Flask-based webhook that generates a pre-filled Calendly booking link using a user's name and email. It is designed for use with Dialogflow CX and can be deployed on Google Cloud Run using the Google Cloud SDK.

---

## 📁 Project Structure

```
.
├── Dockerfile
├── .env
├── main.py
├── requirements.txt
└── README.md
```

---

## ⚙️ Requirements

- Python 3.8+
- Google Cloud SDK installed and initialized
- Docker installed
- Google Cloud project with billing enabled

---

## 🔑 Environment Variables

Create a `.env` file or configure these in Cloud Run:

```env
FLASK_ENV=production
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
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/calendly-link-webhook
```

### 3. Deploy to Cloud Run

```bash
gcloud run deploy calendly-link-webhook \
  --image gcr.io/YOUR_PROJECT_ID/calendly-link-webhook \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
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
  "fulfillmentInfo": {
    "tag": "GenerateCalendlyLink"
  },
  "sessionInfo": {
    "parameters": {
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
}
```

---

## ✅ Expected Response

```json
{
  "fulfillment_response": {
    "messages": [
      {
        "text": {
          "text": [
            "👉 Click to confirm your slot: https://calendly.com/telaprolugayathri911/haircut?name=John+Doe&email=john@example.com"
          ]
        }
      }
    ]
  }
}
```

---

## 🧠 Dialogflow CX Integration

- Tag: `GenerateCalendlyLink`
- Parameters: `name`, `email`

---

## 📦 Tech Stack

- Python (Flask)
- Calendly URL Prefill
- Google Cloud Run
- Dialogflow CX (optional)

---

## 📝 License

MIT License
