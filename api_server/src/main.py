from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import mariadb
import json

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


conn = mariadb.connect(user="root",
                       password="password",
                       host="mongodb",
                       port=3306,
                       database="mydatabase")


class ghgInput(BaseModel):
    technique_id: int
    quantity: int
    ghg_savings: float
    created_by: str


@app.post("/submit_savings/")
async def submit(item: ghgInput):
    cur = conn.cursor()
    q = "INSERT INTO warp_entry (technique_entry_id, quantity, ghg_savings, created_by) VALUES (?,?,?,?)"
    cur.execute(q, (item.technique_id, item.quantity, item.ghg_savings, item.created_by))
    item_id = cur.lastrowid
    conn.commit()
    cur.close()
    return {"id": item_id, **item.dict()}


@app.post("/get_savings/")
async def fetch():
    cur = conn.cursor()
    q = """SELECT
  B.id as id,
 	C.id as technique_id,
  A.id as device_id,
  D.id as device_type_id,
  C.name as technique_name,
  A.name as device_name,
  D.name as device_type_name,
  B.value as ghg_savings,
  E.quantity as quantity,
  E.created_at as created_at
from
  devices as A
  JOIN device_type AS D ON D.id = A.device_type
  JOIN warp_technique_entry AS B ON A.id = B.device_id
  JOIN warp_technique AS C ON C.id = B.technique_id
  JOIN warp_entry AS E on B.id = E.technique_entry_id
  LIMIT 20"""
    cur.execute(q)
    res = cur.fetchall()
    field_names = [i[0] for i in cur.description]
    conn.commit()
    cur.close()
    result = []
    for i in res :
      temp = {}
      for f,v in zip(field_names, i) :
        temp[f] = v
      result.append(temp)
    return result

@app.post("/test/")
async def test():
    return {"id": "hello" }