# Calendly Slot Availability Webhook

This project is a Flask-based webhook that checks appointment slot availability using the Calendly API. It is designed to integrate with Dialogflow CX or external tools, and can be deployed on Google Cloud Run using the Google Cloud SDK.

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
- Calendly API Key

---

## 🔑 Environment Variables

Create a `.env` file or configure the environment in Cloud Run:

```env
CALENDLY_API_KEY=your_calendly_api_key
PORT=8080
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
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/appointment-availability
```

### 3. Deploy to Cloud Run

```bash
gcloud run deploy appointment-availability \
  --image gcr.io/YOUR_PROJECT_ID/appointment-availability \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars CALENDLY_API_KEY=your_calendly_api_key
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
    "tag": "CheckAppointmentAvailability"
  },
  "sessionInfo": {
    "parameters": {
      "date": "2025-06-30",
      "time": "10:00 AM",
      "duration": 30
    }
  }
}
```

---

## ✅ Expected Success Response

```json
{
  "fulfillment_response": {
    "messages": [
      {
        "text": {
          "text": [
            "Yes, the slot at 10:00 AM on 2025-06-30 is available. Shall I confirm it?"
          ]
        }
      }
    ]
  }
}
```

---

## 🧠 Dialogflow CX Integration

- Tag: `CheckAppointmentAvailability`
- Parameters: `date`, `time`, `duration (optional)`

---

## 📦 Tech Stack

- Python (Flask)
- Calendly REST API
- Google Cloud Run
- Dialogflow CX (optional)

---

## 📝 License

MIT License
