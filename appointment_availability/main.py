from flask import Flask, request, jsonify
import requests
import os
from datetime import timedelta
from dateutil import parser as dt_parser
import pytz

app = Flask(__name__)

CALENDLY_API_KEY = os.getenv("CALENDLY_API_KEY")

HEADERS = {
    "Authorization": f"Bearer {CALENDLY_API_KEY}",
    "Content-Type": "application/json"
}

USER_URI = "https://api.calendly.com/users/ee22c9d8-79c2-4442-af3c-cd606566dcec"  # Your Calendly user URI

@app.route("/", methods=["POST"])
def webhook():
    req = request.get_json()
    tag = req.get("fulfillmentInfo", {}).get("tag")

    if tag == "CheckAppointmentAvailability":
        return check_availability(req)

    return jsonify({
        "fulfillment_response": {
            "messages": [{"text": {"text": ["Unknown tag."]}}]
        }
    })

def check_availability(req):
    params = req.get("sessionInfo", {}).get("parameters", {})
    date_str = params.get("date")
    time_str = params.get("time")
    duration = int(params.get("duration", 30))

    try:
        # Parse and convert to EST
        naive_dt = dt_parser.parse(f"{date_str} {time_str}")
        est = pytz.timezone("America/New_York")
        if naive_dt.tzinfo is None:
            local_dt = est.localize(naive_dt)
        else:
            local_dt = naive_dt.astimezone(est)

        start_time_utc = local_dt.astimezone(pytz.utc).isoformat()
        end_time_utc = (local_dt + timedelta(minutes=duration)).astimezone(pytz.utc).isoformat()

        is_free = is_slot_free(start_time_utc, end_time_utc)

        if is_free:
            message = f"Yes, the slot at {time_str} on {date_str} is available. Shall I confirm it?"
        else:
            suggestions = suggest_alternate_times(local_dt)
            if suggestions:
                message = f"That time is booked. Try these: {', '.join(suggestions)}"
            else:
                message = "All nearby slots are booked. Please try a different time."

        return jsonify({
            "fulfillment_response": {
                "messages": [{"text": {"text": [message]}}]
            }
        })

    except Exception as e:
        return jsonify({
            "fulfillment_response": {
                "messages": [{"text": {"text": [f"Error: {str(e)}"]}}]
            }
        })

def is_slot_free(start_time, end_time):
    url = "https://api.calendly.com/scheduled_events"
    params = {
        "user": USER_URI,
        "min_start_time": start_time,
        "max_start_time": end_time
    }
    response = requests.get(url, headers=HEADERS, params=params)
    if response.status_code == 200:
        events = response.json().get("collection", [])
        return len(events) == 0
    else:
        print("Calendly API Error:", response.status_code, response.text)
        return False

def suggest_alternate_times(base_time):
    suggestions = []
    for delta in [-60, -30, 30, 60]:
        alt_time = base_time + timedelta(minutes=delta)
        start = alt_time.astimezone(pytz.utc).isoformat()
        end = (alt_time + timedelta(minutes=30)).astimezone(pytz.utc).isoformat()
        if is_slot_free(start, end):
            suggestions.append(alt_time.strftime("%I:%M %p"))
        if len(suggestions) >= 2:
            break
    return suggestions

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
