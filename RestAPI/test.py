import requests
import uuid
from datetime import datetime

timestamp = datetime.now().strftime("%d/%m/%Y-%H:%M:%S")
id = uuid.uuid4().hex

BASE = "http://localhost:5000/" 

#Insérer une donnée
response = requests.put(BASE + "pigarden/" + id, {"timestamp": timestamp, "temperature": 21, "pressure": 1011, "humidity": 204})
print(response.json())
input()
#Chercher une donnée
response = requests.get(BASE + "pigarden/" + id)
print(response.json())
input()
#Modifier une donnée
response = requests.patch(BASE + "pigarden/" + id, {"timestamp": timestamp, "temperature": 81, "pressure": 1032, "humidity": 215})
print(response.json())
input()
#Supprimer une donnée
response = requests.delete(BASE + "pigarden/" + id)
print(response)
