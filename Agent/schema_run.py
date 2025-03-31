import re

# Read your schema file
with open("Kap_schema.sql", 'r') as file:
    schema_content = file.read()

# Initialize variables to hold the schema
tables = {}
current_table = None
current_columns = []

# Split the content into lines and process each line
lines = schema_content.splitlines()

for line in lines:
    line = line.strip()

    if line.startswith('CREATE TABLE'):
        if current_table:
            tables[current_table] = current_columns  # Save previous table's columns
        # Extract table name
        table_name_match = re.search(r'`([^`]+)`', line)
        if table_name_match:
            current_table = table_name_match.group(1)
            current_columns = []  # Reset columns for new table
    elif line.startswith('`'):
        # Extract column names
        current_columns.append(line.replace("`", "").split(" ")[0].strip())

# Save the last table after parsing
if current_table:
    tables[current_table] = current_columns

# Print the schema
for table, columns in tables.items():
    print(f"Table: {table}")
    print(f"Columns: {', '.join(columns)}")
