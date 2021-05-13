
#!/usr/bin/python

import bme280
import requests
import json
from datetime import datetime

timestamp = datetime.now().strftime('%d/%m/%Y-%H:%M:%S')
temperature,pressure,humidity = bme280.readBME280All()

BASE = 'http://localhost:5000/'

#Inserer une donnee
print('Inserer une donnee :')
response = requests.put(BASE + 'pigarden/', {'timestamp': timestamp, 'temperature': temperature, 'pressure': pressure, 'humidity': humidity})
print(response.json())
