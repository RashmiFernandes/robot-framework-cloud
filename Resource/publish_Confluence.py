import requests
from requests.auth import HTTPBasicAuth

confluence_url = 'https://your-confluence-site/rest/api/content'
auth = HTTPBasicAuth('your-username', 'your-api-token')
headers = {
    'Content-Type': 'application/json'
}
data = {
    'type': 'page',
    'title': 'Robot Framework Test Report',
    'space': {'key': 'YOUR_SPACE_KEY'},
    'body': {
        'storage': {
            'value': open('report.md').read(),
            'representation': 'wiki'
        }
    }
}

response = requests.post(confluence_url, json=data, headers=headers, auth=auth)
if response.status_code == 200:
    print("Report published successfully!")
else:
    print(f"Failed to publish report: {response.status_code}")