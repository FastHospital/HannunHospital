from fastapi import FastAPI
from router.items import router as items_router
# from database.database import Dbconn

app = FastAPI()
app.include_router(items_router,prefix='/items',tags=['items'])



if __name__ == "__main__" :
  import uvicorn
  uvicorn.run(app,host='172.16.250.187',port=8000)