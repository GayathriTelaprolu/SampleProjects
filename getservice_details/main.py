from flask import Flask, request, jsonify
from google.cloud import bigquery
import os
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

project_id = os.environ.get("PROJECT_ID")
dataset_id = os.environ.get("DATASET_ID")
client = bigquery.Client()

@app.route("/", methods=["POST"])
def get_service_details():
    try:
        req = request.get_json()
        if not req:
            logging.error("No JSON body received.")
            return jsonify({"error": "Missing JSON body"}), 400

        category = req.get("category", "").strip().lower()
        if not category:
            logging.error("No category provided.")
            return jsonify({"error": "Missing category"}), 400

        logging.info(f"Received category: {category}")

        query = f"""
            SELECT name, description, price_usd
            FROM `{dataset_id}.service_details`
            WHERE LOWER(REPLACE(category, " ", "")) = @category
        """
        job_config = bigquery.QueryJobConfig(
            query_parameters=[
                bigquery.ScalarQueryParameter("category", "STRING", category.replace(" ", ""))
            ]
        )

        logging.info("Executing BigQuery query...")
        query_job = client.query(query, job_config=job_config)
        results = query_job.result()

        services = []
        for row in results:
            services.append({
                "name": row.name,
                "description": row.description,
                "price": row.price_usd
            })

        if services:
            logging.info("Services found and returned.")
            return jsonify({"services": services})
        else:
            logging.info("No services found for the category.")
            return jsonify({"message": "No services found for the given category."})

    except Exception as e:
        logging.exception("Unexpected error:")
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
