import json

# Path to the JSON file
json_file_path = r'C:\RobotSource\Robot_TestdataWithJson\Testdata\GlobalData.json'

# Read the JSON file and convert to dictionary
with open(json_file_path, 'r') as file:
    data = json.load(file)

# Now 'data' is a dictionary containing the JSON data
print(data)