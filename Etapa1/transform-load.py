import json
import configparser
import pandas as pd
import pyarrow
from sqlalchemy import create_engine
from pandas.io.json import json_normalize
import fileinput

# Uma boa maneira de começar é tratar e transformar os dados em DataFrames. 
# Assim fica mais fácil de visualizar depois da transformação e fácil de inserir no PostreSQL.

# Leitura do código para acesso ao BD
config = configparser.ConfigParser()
config.read("config.cfg")

def transformJSON(file):
    print(" >>>> Puxando os dados.")
    df = pd.read_json(file, names = ["sku", "setor"])
    return df

def transformGZIP(file):
    print(" >>>> Puxando os dados.")
    df = pd.read_parquet(file, engine='pyarrow')
    return df

def transformCSV(file):
    print(" >>>> Puxando os dados.")
    df = pd.read_csv(file, encoding='utf-16', sep="|", index_col=0)
    return df

def transformTXT(file):
    print(" >>>> Puxando os dados.")
    df = pd.read_csv(file, header=None, encoding='utf-8', sep=' ', names = ["sku", "peso_unitario"], error_bad_lines=False)
    return df

def load(df, tabela):
    print(" >>>> Começamos a Conexão.")
    engine = create_engine('postgresql+psycopg2://{}:{}@{}:{}/{}'.format(*config['DW'].values()))
    df.to_sql(tabela, engine, if_exists='append', index=False, chunksize=1000)
    engine.dispose()
    print(" >>>> Terminou de Enviar os Dados!")

def main():
    df = transformGZIP(tabelas[0][0])
    df = df.apply(pd.to_numeric, errors="ignore")
    df['dia_emissao_nota'] = pd.to_datetime(df['dia_emissao_nota'])
    load(df, tabelas[0][1])
    
    df = transformJSON(tabelas[1][0])
    load(df, tabelas[1][1])

    df = transformTXT(tabelas[2][0])
    df = df.apply(pd.to_numeric, errors="ignore")
    load(df, tabelas[2][1])
 
    df = transformCSV(tabelas[3][0])
    df['custo_frete'] = df['custo_frete'].str.replace(",",'.')
    df = df.apply(pd.to_numeric, errors="ignore")
    df['dia'] = pd.to_datetime(df['dia'])
    load(df, tabelas[3][1])
    

tabelas = [
    ["../dados/faturamento.parquet.gzip", "faturamento"],
    ["../dados/familiasetor.json", "familiasetor"],
    ["../dados/peso_unitario.txt", "peso_unitario"],
    ["../dados/frete2.csv", "frete"],
]

main()
