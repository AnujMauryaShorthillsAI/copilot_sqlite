import sqlite3
import json
import subprocess
import hashlib
 
QUERY = '''SELECT LoanType, COUNT(LoanType) AS 'Number of Loans'
FROM SAM
GROUP BY LoanType
ORDER BY COUNT(LoanType) DESC;'''

FILEPATH = 'results.json'

if __name__ == '__main__':
    # Establish connection
    conn = sqlite3.connect('black_night.db') # Will be create if not present

    # Create cursor
    cursor = conn.cursor()

    # Execute query
    cursor.execute(QUERY)

    # Fetch results
    results = cursor.fetchall()



    if cursor.description:
        # Get column names
        columns = [desc[0] for desc in cursor.description]

        # Convert rows to a list of dictionaries
        result_list = [dict(zip(columns, row)) for row in results]

        print("Result Length: ", len(result_list))

        # Write results to file
        with open(FILEPATH, 'w') as f:
            json.dump(result_list, f, indent=4)

        subprocess.call(['code', FILEPATH])
    
    # Commit changes
    conn.commit()
    # Close connection
    conn.close()



