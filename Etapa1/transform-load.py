import json
from pandas.io.json import json_normalize

# Uma boa maneira de começar é tratar e transformar os dados em DataFrames. 
# Assim fica mais fácil de visualizar depois da transformação e fácil de inserir no PostreSQL.

def transformJSON(file):
    with open(file) as file_json:
        data = json.loads(file_json)
        data_normalize = json_normalize(data['results'])
        return data_normalize

def transformGZIP():
    asdasda = 1

def transformCSV():
    asdasda = 1

def transformTXT():
    asdasda = 1

def load(file):
    file = 1

print(transformJSON('/dados/familiasetor.json'))
