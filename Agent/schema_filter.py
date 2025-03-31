# schema_filter.py

def filter_relevant_schema(schema_dict, user_query):
    """Filter schema to include only relevant tables and columns based on user query."""
    relevant_schema = {}

    # Example: If the query contains the word 'calendar', include calendar-related tables
    if "calendar" in user_query.lower():
        if "_Archive_CalendarOffDates" in schema_dict:
            relevant_schema['_Archive_CalendarOffDates'] = schema_dict['_Archive_CalendarOffDates']
        if "_Archive_Calendars" in schema_dict:
            relevant_schema['_Archive_Calendars'] = schema_dict['_Archive_Calendars']
    
    # Add more conditions for different keywords as needed
    if "enrollment" in user_query.lower():
        if "_Archive_Enrollments" in schema_dict:
            relevant_schema['_Archive_Enrollments'] = schema_dict['_Archive_Enrollments']
    
    # Add other filters for other keywords
    return relevant_schema
