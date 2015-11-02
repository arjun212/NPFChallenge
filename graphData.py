#!/usr/bin/env python 

import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import datetime as dt
import numpy as np
import csv


path = "data/csv/"

forecastFiles = ["round1_forecast_1of2.csv", "round1_forecast_2of2.csv"]
trainingFiles = ["round1_training_1of2.csv", "round1_training_2of2.csv"]

var = {"Date" : 0, "Time" : 1, "Temp" : 2, "Cloud_Cover" : 3, "Wind_Speed" : 4, "Humidity" : 5, "Precip_Amt" : 6, "Solar_Rad" : 7}
var2 = {"Date" : 0, "Day_Type" : 1, "School_Holiday" : 2, "Winter" : 3, "Volume" : 4}

def read_datafile(filename):
  data = []
  cr = csv.reader(open(filename, "rb"))
  iterrows = iter(cr)
  next(iterrows)

  for row in iterrows:
    row[var["Date"]] = dt.datetime.strptime(row[var["Date"]], '%d/%m/%Y').date()
    #row[var["Time"]] = float(row[var["Time"]])
    #row[var["Temp"]] = float(row[var["Temp"]])
    #row[var["Cloud_Cover"]] = float(row[var["Cloud_Cover"]])
    #row[var["Wind_Speed"]] = float(row[var["Wind_Speed"]])
    #row[var["Humidity"]] = float(row[var["Humidity"]])
    #print row[var["Humidity"]]
    #row[var["Precip_Amt"]] = float(row[var["Precip_Amt"]])
    #row[var["Solar_Rad"]] = float(row[var["Solar_Rad"]])
    
    row[var2["Volume"]] = float(row[var2["Volume"]])
    
    data.append(row)
  return data

data = read_datafile(path + trainingFiles[0])

x = []
y = []
for col in data:
  x.append(col[var2["Date"]])
  y.append(col[var2["Volume"]])

print y

plt.plot(x, y)

plt.xlabel('Date')
plt.ylabel('variables');
plt.title('plotting all variables against date')
plt.grid(True)
#plt.savefig("trainingData.png")
plt.show()

