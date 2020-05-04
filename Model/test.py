import requests

url = "https://canarado-lyrics.p.rapidapi.com/lyrics/my%2520way%2520Frank%2520Sinatra"

headers = {
    'x-rapidapi-host': "canarado-lyrics.p.rapidapi.com",
    'x-rapidapi-key': "a15f1160a8msh188ccf9361b9a47p18d92ajsn26031d598a4b"
    }

response = requests.request("GET", url, headers=headers)

print(response.text)