from flask import Flask, request, jsonify
import os
import requests
from dotenv import load_dotenv

load_dotenv()
app = Flask(__name__)

CALENDLY_API_KEY = os.getenv("CALENDLY_API_KEY")
USER_URI = os.getenv("USER_URI")  # e.g. https://api.calendly.com/users/ee22...

@app.route("/", methods=["POST"])
def check_booking():
    data = request.get_json()
    params = data.get("sessionInfo", {}).get("parameters", {})

    email = params.get("email")
    date_str = params.get("date")  # Format: YYYY-MM-DD

    if not email or not date_str:
        return jsonify({"fulfillment_response": {
            "messages": [{"text": {"text": ["❌ Missing email or date."]}}]
        }})

    # Step 1: Get events on that date
    list_url = (
        f"https://api.calendly.com/scheduled_events"
        f"?user={USER_URI}&min_start_time={date_str}T00:00:00Z&max_start_time={date_str}T23:59:59Z"
    )
    headers = {"Authorization": f"Bearer {CALENDLY_API_KEY}"}
    resp = requests.get(list_url, headers=headers)

    if resp.status_code != 200:
        return jsonify({"fulfillment_response": {
            "messages": [{"text": {"text": [f"❌ Error fetching events: {resp.text}"]}}]
        }})

    events = resp.json().get("collection", [])
    for event in events:
        invitees_url = event.get("uri") + "/invitees"
        invitee_resp = requests.get(invitees_url, headers=headers)
        invitees = invitee_resp.json().get("collection", [])
        for invitee in invitees:
            if invitee.get("email") == email:
                return jsonify({"fulfillment_response": {
                    "messages": [{"text": {"text": ["✅ Appointment is confirmed for this date."]}}]
                }})

    return jsonify({"fulfillment_response": {
        "messages": [{"text": {"text": ["❌ No matching appointment found for this email and date."]}}]
    }})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
