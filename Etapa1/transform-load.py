import json
import configparser
import pandas as pd
import pyarrow
from sqlalchemy import create_engine
from pandas.io.json import json_normalize

# Uma boa maneira de começar é tratar e transformar os dados em DataFrames. 
# Assim fica mais fácil de visualizar depois da transformação e fácil de inserir no PostreSQL.

# LEMBRE-SE DE MUDAR O DATATYPE DOS DFs PARA QUE SEJA MAIS FÁCIL FAZER O ANALYTICS DEPOIS.

config = configparser.ConfigParser()
config.read("../config.cfg")

def transformJSON(file):
    df = pd.read_json(file)
    return df

def transformGZIP(file):
    df = pd.read_parquet(file, engine='pyarrow')
    return df

def transformCSV(file):
    df = pd.read_csv(file, encoding='utf-16', sep="|", index_col=0)
    return df

# Falta resolver o trailing whitespace entre os números.
def transformTXT(file):
    df = pd.read_fwf("C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/peso_unitario.txt", header=None, encoding='utf-16', sep=' ', names = ["sku", "peso_unitario"])
    # df = pd.read_csv(file, header=None, encoding='utf-16', sep=' ', names = ["sku", "peso_unitario"])
    df = df.apply(pd.to_numeric, errors="ignore")
    return df.dtypes

def load(df, tabela):
    print(" >>>> Começamos a Conexão")
    engine = create_engine('postgresql+psycopg2://{}:{}@{}:{}/{}'.format(*config['DW'].values()))
    df.to_sql(tabela, engine, if_exists='append', index=False, chunksize=1000)
    engine.dispose()
    print(" >>>> Terminou de Enviar os Dados!")

def main():
    df = transformGZIP(tabelas[0][0])
    print(df.head(1000).max())
    # load(df, tabelas[0][1])

    df = transformJSON(tabelas[1][0])
    print(df.head(1000).max())
    # load(df, tabelas[1][1])

    df = transformTXT(tabelas[2][0])
    print(df.head(1000).max())
    # load(df, tabelas[2][1])

    df = transformCSV(tabelas[3][0])
    print(df.head(1000).max())
    # load(df, tabelas[3][1])
    

tabelas = [
    ["C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/faturamento.parquet.gzip", "faturamento"],
    ["C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/familiasetor.json", "familiasetor"],
    ["C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/peso_unitario.txt", "peso_unitario"],
    ["C:/Users/Israel Mendes/Desktop/Coisas/Programação/teste-data-analytics/dados/frete2.csv", "frete"],
]

main()
