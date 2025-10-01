# Steps Explained:
# Parse the Robot Framework output XML: The parse_robot_output function reads the XML file and extracts the test names and their statuses.
# Convert to JSON: The write_to_json function writes the extracted data to a JSON file.
# Make sure you have the necessary permissions to read the XML file and write to the JSON file. You can run this script after your Robot Framework tests have completed to automatically update the test status in a JSON file.



import json
import xml.etree.ElementTree as ET
from datetime import datetime

def parse_robot_output(xml_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    tests = []

    current_time = datetime.now().isoformat()

    for suite in root.findall('.//suite'):
        for test in suite.findall('.//test'):
            name = test.get('name')
            status = test.find('status').get('status')
            test_info = {
                'name': name,
                'testKey': 'MNO-145223',
                'start': current_time,
                'finish': current_time,
                'status': status
            }
            tests.append(test_info)

    return {'tests': tests}

def write_to_json(data, json_file):
    with open(json_file, 'w') as f:
        json.dump(data, f, indent=4)

if __name__ == "__main__":
    xml_file = r'C:\RobotResults\Results_Sprints_PREDEV\output-20241213-130209.xml'  # Path to your Robot Framework output XML file
    json_file = r'C:\RobotResults\Results_Sprints_PREDEV\test_status.json'  # Path to the JSON file to be created

    test_status = parse_robot_output(xml_file)
    write_to_json(test_status, json_file)
    print(f"Test status has been written to {json_file}")

