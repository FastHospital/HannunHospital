from fastapi import APIRouter
# from database.database import Dbconn
from pydantic import BaseModel
import pandas as pd
import joblib 
import pandas as pd
from sklearn import svm, metrics
from sklearn.ensemble import RandomForestClassifier


router = APIRouter()
	# 임신횟수	혈당	혈압	인슐린	BMI	가족력지표	나이	당뇨
rf = joblib.load('./ml_h5/stroke.h5')
class StrokeModel(BaseModel):
  age: str        # 혈당
  sex: str        # 혈압
  hypertension: str       # 임신횟수
  heart_disease: str    # 인슐린
  ever_married : str       # BMI
  work_type : str       # Age
  Residence_type : str       # Age
  avg_glucose_level : str       # Age
  bmi : str       # Age
  smoking_status : str       # Age

#data: Diabetes
@router.post('/result')
async def read_item(data:StrokeModel):
  print('------------------')
  print(data)
  # 계산해서 결과치 반환
  #['sex', 'age', 'hypertension', 'heart_disease', 'ever_married',
  #     'work_type', 'Residence_type', 'avg_glucose_level', 'bmi',
  #     'smoking_status'],
  df2 = pd.DataFrame(
     {
      'sex': [int(data.sex)],
      'age': [float(data.age)],     
      'hypertension': [int(data.hypertension)],
      'heart_disease':[int(data.heart_disease)],
      'ever_married':[int(data.ever_married)],
      'work_type':[int(data.work_type)],
      'Residence_type': [int(data.Residence_type)],
      'avg_glucose_level': [float(data.avg_glucose_level)],
      'bmi': [float(data.bmi)],
      'smoking_status':[int(data.smoking_status)]
    }
    # {
    #   'sex': [1],
    #   'age': [50],     
    #   'hypertension': [1],
    #   'heart_disease':[1],
    #   'ever_married':[1],
    #   'work_type':[3],
    #   'Residence_type': [1],
    #   'avg_glucose_level': [228.69],
    #   'bmi': [36.6],
    #   'smoking_status':[1]
    # }
  )
  print(f"추천하는 포지션은 {rf.predict(df2).item()} 입니다.")
  return {'result':rf.predict(df2).item()}