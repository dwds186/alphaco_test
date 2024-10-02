#파일명 alphaco_241002.py


import pandas as pd
from pandas import DataFrame

data = [
    ["037730", "3R", 1510],
    ["036360", "3SOFT", 1790],
    ["005670", "ACTS", 1185]
]

columns = ["종목코드", "종목명", "현재가"]
df = DataFrame(data=data, columns=columns)
df.set_index("종목코드", inplace=True)
#print(df)
#기본값은 ascending=True

#print(df.sort_values(by="현재가", ascending=False)) #ascending=False이면 내림차순 기본 default는 오름차순
#print(df.sort_values(by="현재가", ascending=True))

#print(df.sort_values(by="종목명", ascending=False)) #ascending=False이면 내림차순 기본 default는 오름차순
#print(df.sort_values(by="종목명", ascending=True))


#print(df.sort_index()) # 기본값
#print(df.sort_index(ascending=False)) # 역순


'''

#인덱스 연산
# 수학 시간 집합 개념으로 다루는 합집합, 교집합, 차집합의 원리를 이용해서
# , 나중에 데이터 병합할 때 사용함
idx1=pd.Index([1,2,3])
idx2=pd.Index([2,3,4])
print(idx1.union(idx2)) #합집합
print(idx1.intersection(idx2)) #교집합
print(idx1.difference(idx2)) #차집합

'''


'''

groupby 연산 사용할 일 정말 많아요...
주말에 연습해야 하는 것 : 주말 과제 
몇 명이 해오는지 보겠음ㅋㅋㅋ


'''



from pandas import DataFrame

data = [
    ["2차전지(생산)", "SK이노베이션", 10.19, 1.29],
    ["해운", "팬오션", 21.23, 0.95],
    ["시스템반도체", "티엘아이", 35.97, 1.12],
    ["해운", "HMM", 21.52, 3.20],
    ["시스템반도체", "아이에이", 37.32, 3.55],
    ["2차전지(생산)", "LG화학", 83.06, 3.75]
]

columns = ["테마", "종목명", "PER", "PBR"]
df = DataFrame(data=data, columns=columns)
#print(df)

result=df.groupby('테마')[['PER', 'PBR']].mean()

#print(result)
#print(type(result))


#print(df.groupby('테마').get_group("2차전지(생산)"))
#print(df.groupby('테마').get_group("시스템반도체"))
#print(df.groupby('테마').get_group("해운"))



'''
result를 내보내고 싶어
'''

#result.to_excel('datatouchedbyjaehyun.xlsx')


df = pd.read_excel("dataset/ss_ex_1.xlsx" , parse_dates=['일자'], index_col=0)
#print(df.head())


df=df.reset_index()
#print(df.head(1))
#print(df.info()) # 0   일자      127 non-null    datetime64[ns]

#print(df['일자'].dt.quarter)
#print(df['일자'].dt.year)
#print(df['일자'].dt.month)
#print(df['일자'].dt.day)

# 분기, 연도, 월, 일 전부 따로 뽑을 수 있음

#column을 추가하세요! 미션

df['분기']=df['일자'].dt.quarter
df['연도']=df['일자'].dt.year
df['월']=df['일자'].dt.month
df['일']=df['일자'].dt.day




print(df.head(1))

#result = df.groupby(['연도', '월']).get_group((2021,2))
#print(result)


result=df.groupby(['연도', '월'])['시가'].mean()
#print(result)

multiples ={
    "시가" : "first",
    "저가" : min,
    "고가" : max,
    "종가" : 'last'
}

result=df.groupby(['연도', '월']).agg(multiples)
print(result) #이렇게 하면 인덱스가 2개가 생겨서 control 하기가 어려워요...
print(result.reset_index())














