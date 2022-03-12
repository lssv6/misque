"""
              _                                    _ __           
   ____ ___  (_)________ ___  _____ _      _______(_) /____  _____
  / __ `__ \/ / ___/ __ `/ / / / _ \ | /| / / ___/ / __/ _ \/ ___/
 / / / / / / (__  ) /_/ / /_/ /  __/ |/ |/ / /  / / /_/  __/ /    
/_/ /_/ /_/_/____/\__, /\__,_/\___/|__/|__/_/  /_/\__/\___/_/     
                    /_/                                           

Write all the the fields of the archive of the <path>.
All the records will be written in the postgres described in <connection_options>.

"""
import csv
import os
import copy
from tqdm import tqdm
import asyncpg
import asyncio
path = "/home/davi/Downloads/MICRODADOS_ENEM_2019/DADOS/MICRODADOS_ENEM_2019.csv"
connection_options = {
    "user":"enem",
    "password":"catapimbas",
    "host":"127.0.0.1",
    "port":5432
}

def read_row(file):
    reader = csv.reader(file, delimiter=';')
    reader.__next__()
    for line_vals in reader:
        yield line_vals

count_lines = lambda file: sum([1 for line in file])

with open(path,"r",encoding="ISO-8859-1") as f:
    number_of_lines = count_lines(f)
    print(f"number of lines = {number_of_lines}")


async def get_connection(**options):
    return await asyncpg.connect(**options)

async def write():
    conn = await get_connection(**connection_options)
    print("connected")
    typelist = [
        int,int,int,str,int,str,int,bool,int,int,int,int,str,int,str,int,int,int,
        int,bool,int,int,str,int,str,int,str,int,bool,bool,bool,bool,bool,bool,
        bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,
        bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,
        bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,
        bool,bool,bool,int,str,int,str,int,int,int,int,int,int,int,int,float,
        float,float,float,list,list,list,list,bool,list,list,list,list,int,int,
        int,int,int,int,int,str,str,str,str,int,str,str,str,str,str,str,str,str,
        str,str,str,str,str,str,str,str,str,str,str,str,
    ]
    def convert(lis):
        counter = 0
        result = []
        for item in lis:
            #print(item,end="\n\n\n")
            if item:
                if counter == 7:
                    result.append(typelist[counter](lis[counter] == "M"))
                elif typelist[counter] == bool:
                    result.append(typelist[counter](lis[counter] == "1"))
                else:
                    result.append(typelist[counter](lis[counter]))
            else:
                result.append(typelist[counter]())
            counter += 1
        return result
    dollar_signs = lambda x : "".join(map(lambda x: f"${x}, ",range(1,x)))[:-2]
    QUERY = "INSERT INTO INSCRITOS VALUES(" + dollar_signs(136+1) + ");"
    print(QUERY)
    with open(path,"r",encoding="ISO-8859-1") as f:
        x = read_row(f)
        buff = []
        pks_repetidas = 0
        for line in tqdm(x, total=number_of_lines , unit=' rows'):
            buff.append(line)
            if len(buff) > 2048:
                try:
                    await conn.executemany(QUERY,[convert(i) for i in buff])
                except asyncpg.exceptions.UniqueViolationError as e:
                    pks_repetidas += 1
                buff = []
        if buff:
            await conn.executemany(QUERY, [convert(i) for i in buff])
        print(f"{pks_repetidas=}")


asyncio.run(write())
