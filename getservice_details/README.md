# Salon Service Details Webhook (BigQuery)

This Flask-based webhook retrieves salon service information (name, description, price) for a given category using Google BigQuery. Designed for Dialogflow CX integration and deployed on Google Cloud Run.

---

## 📁 Project Structure

```
.
├── Dockerfile
├── main.py
├── requirements.txt
└── README.md
```

---

## ⚙️ Requirements

- Python 3.8+
- Google Cloud SDK
- BigQuery dataset with `service_details` table
- Google Cloud credentials (service account with BigQuery read access)

---

## 🔑 Required Environment Variables

These must be set in `.env` or via Cloud Run environment settings:

```env
PROJECT_ID=your-gcp-project-id
DATASET_ID=your-bigquery-dataset
PORT=8080
GOOGLE_APPLICATION_CREDENTIALS=path-to-service-account.json (for local testing)
```

---

## 🧠 BigQuery Table Schema (`service_details`)

| Column Name   | Type     | Description                     |
|---------------|----------|---------------------------------|
| name          | STRING   | Name of the service             |
| description   | STRING   | Description of the service      |
| price_usd     | FLOAT    | Price in USD                    |
| category      | STRING   | Category of the service         |

---

## 🚀 Deploy via Google Cloud SDK

### 1. Authenticate and Set Project

```bash
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

### 2. Build Docker Image

```bash
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/service-webhook
```

### 3. Deploy to Cloud Run

```bash
gcloud run deploy service-webhook \
  --image gcr.io/YOUR_PROJECT_ID/service-webhook \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars PROJECT_ID=your-gcp-project-id,DATASET_ID=your-bigquery-dataset
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
  "category": "Hair Cut"
}
```

---

## ✅ Sample Response

```json
{
  "services": [
    {
      "name": "Basic Haircut",
      "description": "Simple trim and style",
      "price": 25.0
    },
    {
      "name": "Deluxe Haircut",
      "description": "Includes shampoo and massage",
      "price": 40.0
    }
  ]
}
```

If no match:

```json
{
  "message": "No services found for the given category."
}
```

---

## 📦 Tech Stack

- Python (Flask)
- Google BigQuery
- Google Cloud Run
- Dialogflow CX (optional)

---

## 📝 License

MIT License
