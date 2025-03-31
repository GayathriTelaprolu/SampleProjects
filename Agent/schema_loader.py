# schema_loader.py

def load_schema_from_file(file_path):
    """Reads the schema from a file and returns it as a dictionary."""
    schema_dict = {}

    with open(file_path, 'r') as file:
        lines = file.readlines()

    current_table = None
    for line in lines:
        # Clean up the line and ignore empty lines or comments
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        
        # If the line starts with 'Table:', it's a table declaration
        if line.startswith('Table:'):
            # Extract table name
            current_table = line.split(':')[1].strip()
            schema_dict[current_table] = []
        elif line.startswith('Columns:') and current_table:
            # Add columns to the current table
            columns_line = line.split(':')[1].strip()
            columns = [column.strip() for column in columns_line.split(',')]
            schema_dict[current_table] = columns

    return schema_dict
def split_schema_into_chunks(schema_dict, chunk_size=3):
    """Splits the schema dictionary into smaller chunks based on the chunk size."""
    # List of table names
    table_names = list(schema_dict.keys())
    
    # Split the list of table names into chunks
    schema_chunks = [table_names[i:i + chunk_size] for i in range(0, len(table_names), chunk_size)]
    
    # Create a new dictionary for each chunk
    chunked_schema = []
    for chunk in schema_chunks:
        chunk_dict = {}
        for table in chunk:
            chunk_dict[table] = schema_dict[table]
        chunked_schema.append(chunk_dict)
    
    return chunked_schema