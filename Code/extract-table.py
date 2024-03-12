#!/usr/bin/env python
# Extract the table from modelData.xls sheet Comparative OFs
import pandas as pd
file = '/home/Oscar/Git/PstKB/Data/modelData.xls'
hoja = 'Comparative OFs'
Data = pd.read_excel(file,sheet_name=hoja)
file_csv = '/home/Oscar/Git/PstKB/Data/Comparative-OFs.csv'
Data.to_csv(file_csv,index=False)
print('Datos Guardados en Data/Comparative-OFs.csv')