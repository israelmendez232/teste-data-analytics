import json
import configparser
import pandas as pd
from pandas.io.json import json_normalize

# Uma boa maneira de começar é tratar e transformar os dados em DataFrames. 
# Assim fica mais fácil de visualizar depois da transformação e fácil de inserir no PostreSQL.

# LEMBRE-SE DE MUDAR O DATATYPE DOS DFs PARA QUE SEJA MAIS FÁCIL FAZER O ANALYTICS DEPOIS.

config = configparser.ConfigParser()
config.read("../config.cfg")

def transformJSON(file):
    df = pd.read_json(r"C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/familiasetor.json")
    return df

# Nem comecei a abrir o arquivo.
def transformGZIP():
    df = pd.read_csv(r"C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/faturamento-parquet.gzip", compression='gzip')
    # df = pd.read_fwf(r"C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/faturamento.parquet.gzip")
    return df

def transformCSV():
    df = pd.read_csv(r"C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/frete2.csv", encoding='utf-16', sep="|", index_col=0)
    return df

#Falta resolver o trailing whitespace entre os números.
def transformTXT():
    df = pd.read_fwf(r"C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/peso_unitario.txt", header=None, encoding='utf-16', sep=" ")
    df.columns = ["sku", "peso_unitario"]
    df = df.apply(pd.to_numeric, errors="ignore")
    return df

def load(file, tabela):
    print(" >>>> Começamos a Conexão")
    engine = create_engine('postgresql+psycopg2://{}:{}@{}:{}/{}'.format(*config['DW'].values()))
    file.to_sql(tabela, engine, if_exists='append', index=False, chunksize=1000)
    engine.dispose()
    print(" >>>> Terminou de Enviar os Dados!")

jsons = "C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/familiasetor.json"
print(transformGZIP())

tabelas = {
    "faturamento.parquet",
    "familiasetor",
    "peso_unitario",
    "frete"
}
