import requests
import json
from datetime import datetime

timestamp = datetime.now().strftime("%d/%m/%Y-%H:%M:%S")

BASE = "http://localhost:5000/" 

#Insérer une donnée
print("Insérer une donnée :")
response = requests.put(BASE + "pigarden/", {"timestamp": timestamp, "temperature": 21, "pressure": 1011, "humidity": 204})
print(response.json())
id = response.json()[0]['id']
input()

#Afficher toutes les données
print("Afficher toutes les données :")
response = requests.get(BASE + "pigarden/")
print(response.json())
input()

#Chercher une donnée
print("Chercher la donnée :")
response = requests.get(BASE + "pigarden/" + id)
print(response.json())
input()

#Modifier une donnée
print("Modifier la donnée :")
response = requests.patch(BASE + "pigarden/" + id, {"timestamp": timestamp, "temperature": 81, "pressure": 1032, "humidity": 215})
print(response.json())
input()

#Supprimer une donnée
print("Supprimer la donnée :")
response = requests.delete(BASE + "pigarden/" + id)
print(response)
