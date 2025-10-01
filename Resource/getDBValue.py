import oracledb 
# oracledb.init_oracle_client(lib_dir="C:/Python/instantclient_21_10")  # Path to Oracle Client eg: oracledb.init_oracle_client(lib_dir=r"C:\oracle21c")

import StatusGroup

# Fetch single value     # connection_string=usercad/usercad@DB16S02.integration.ssp:1523/RDMPRDEV
def fetch_value_from_db(connection_string, dbquery):
    try:
        with oracledb.connect(connection_string) as connection:
            with connection.cursor() as cursor:
                cursor.execute(fr"{dbquery}")
                row = cursor.fetchall()
                if not row:  # Check if row is None or empty
                    raise ValueError("Query returned no results")
                if len(row) == 1 and len(row[0]) == 1:
                    # return row[0][0]  # Return single value
                    temp = row[0]
                    return temp[0]  # Return single value
                return row
    except oracledb.DatabaseError as e:
        raise Exception(f"Error while fetching data: {e}")

   
#Fetch all rows from sql query
def getDBValue_listofvalues(dbconnect,dbquery):   
    
    con = oracledb.connect(dbconnect)    
    cursor = con.cursor()
    queryresult = cursor.execute(f"{dbquery}")    
    QueryResults = []
           
    for row in queryresult:
        print(row)
        QueryResults.append(row)
    con.close()
    return QueryResults  #returns a list of records

# Get list of records with Status from StatusGroup
def getDBValue_StatusGroup_listofvalues(dbconnect,dbquery): 
    
    con = oracledb.connect(dbconnect)    
    cursor = con.cursor()
    queryresult = cursor.execute(f"{dbquery}")    
    QueryResults = []
           
    for row in queryresult:
        # print(row)
        QueryResults.append(row)   
    
    # Inherit properties of StatusGroup
    processor = StatusGroup(QueryResults)
    processor.initStatusGroup()
    no_of_status = processor.getNumberOfStatus     # return no_of_status
    con.close()



# Examples
# temp = get_DB_Value('usercad/usercad@DB16S02.integration.ssp:1523/RDMQC',"select Agency_code from ISR where isr_no='EPB-20071205-00649'")
# print(temp)