import psycopg2
import configparser
import csv
import pandas as pd

config = configparser.ConfigParser()
config.read("../config.cfg")

def main(query, número):
    # Conectar com o Banco de Dados
    conn = psycopg2.connect("host={} dbname={} user={} password={}".format(*config['DW2'].values()))
    conn.set_session(autocommit=True)
    cur = conn.cursor()
    
    # Executar a Query
    with open(query, 'r') as fd:
        sql = fd.read()
  
    # data = cur.execute(sql)
    df = pd.read_sql(sql, conn)
    # data = cur.fetchall()
    print(df)

    # Guardar os Dados em um Arquivo .parquet
    df.to_csv('Q{}.parquet'.format(número), encoding='utf-8', index=False)

    # Fechar a Conexão
    conn.close()

queries = [
    "../Etapa2/Q1.sql",
    "../Etapa2/Q2.sql",
    "../Etapa2/Q3.sql",
    "../Etapa2/Q4.sql"
]

for i in range(len(queries)):
    print("Começando a salvar query: Q{}".format(i+1))
    main(queries[i], i + 1)
