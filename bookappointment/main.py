from flask import Flask, request, jsonify
import urllib.parse

app = Flask(__name__)

@app.route("/", methods=["POST"])
def webhook():
    req = request.get_json()
    tag = req.get("fulfillmentInfo", {}).get("tag")

    if tag == "GenerateCalendlyLink":
        return generate_calendly_link(req)

    return jsonify({
        "fulfillment_response": {
            "messages": [{"text": {"text": ["❌ Unknown tag."]}}]
        }
    })

def generate_calendly_link(req):
    params = req.get("sessionInfo", {}).get("parameters", {})
    name = params.get("name", "Guest")
    email = params.get("email", "guest@example.com")

    calendly_base_url = "https://calendly.com/telaprolugayathri911/haircut"

    query_params = {
        "name": name,
        "email": email
    }
    encoded_params = urllib.parse.urlencode(query_params)
    prefilled_url = f"{calendly_base_url}?{encoded_params}"

    return jsonify({
        "fulfillment_response": {
            "messages": [{"text": {"text": [f"👉 Click to confirm your slot: {prefilled_url}"]}}]
        }
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
