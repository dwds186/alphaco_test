# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns 
import plotly
import yfinance as yf
import plotly.graph_objects as go

# 서술형 문제 1
"""
답안 작성

github에서 repo 새로 만들기

(alphaco_test3 이런식으로, add a readme file 선택하고, gitignore도 python으로 선택)

git ignore을 해주어야 하는 이유는 파이썬 용량이 커서 그렇다 뭐 이런식으로 얘기하심… 나중에 검색해보자…

https://www.toptal.com/developers/gitignore

바탕화면에서 git bash 열고 나서

cd alphaco_test3(이게 그동안 git clone인 듯)

pwd(현재 경로 확인)

virtualenv venv (가상환경 하나 만들어짐)

source venv/Scripts/activate

vi requirements.txt → numpy, pansdas, jupyter lab → esc누르고 나가면 됨

pip install -r requirements.txt

(vi 편집기 사용하면 굳이 vs 코드랑 왔다갔다 하지 않고도 가상환경 설치할 수 있어서 편함)

jupyter lab (이제 가상환경 접속 완료!)

(이제 다음주부터는 이 작업 새로 할 필요 없음)

vs코드에서 왔다갔다 하는 거 번거로우니까 바탕화면에 있는 github repo 파일명이 있는 폴더에서 git bash 열고

source venv/Scripts/activate (가상환경 접속하기)

jupyter lab

다음에는 이런식으로 하면 됨

물론 mac 사용하는 사람은 해당 명령어 맞춰서 들어가 줘야 함

[deploy.sh](http://deploy.sh) 파일의 경우 chatgpt한테 물어봤더니

echo를 사용해서 commit message를 사용자로부터 직접 입력 받고 해당 커밋 메시지로 github에 push 하도록 자동 설정 가능합니다

#!/bin/bash

#Prompt user for commit message

echo "Enter your commit message: "
read commitMessage

#Add files, commit with the input message, and push

git add .
git commit -m "$commitMessage"
git push
"""




##################################################################################



'''
풀이 완료 1차
'''



# 코드 문제 1
result = []
for i in range(10):
    if i % 2 == 0:
        result.append(i * 2)
print(result)

# 답지
code_result1 = [i * 2 for i in range(10) if i % 2 == 0]
print(code_result1)



##################################################################################

'''
풀이 완료 1차
'''

# 코드 문제 2
my_dict = {'apple': 3, 'banana': 5, 'orange': 2}

# 답지
# 여기서부터 코드 작성

for key, value in my_dict.items():
    print(f"{key}: {value}")
##################################################################################

# 코드 문제 3
series = pd.Series([25, 35, 45, 60, 75])

# 답지
# np.where를 사용하여 조건 적용

temp = np.where((series > 30) & (series < 60), series + 10, series)
code_result3 = pd.Series(temp)

# 결과 출력
print(code_result3)

'''
풀이 완료 1차
'''


##################################################################################



# 코드 문제 4
iris = sns.load_dataset("iris")

# 답지
# 여기서부터 코드 작성
iris = sns.load_dataset('iris')


# CSV 파일
csv_file_path = 'output/code4_jaehyun.csv'
iris.to_csv(csv_file_path, index=True)

# Excel 파일
excel_file_path = 'output/code4_jaehyun.xlsx'
iris.to_excel(excel_file_path, index=True)

print(f"CSV 파일 저장 경로: {csv_file_path}")
print(f"Excel 파일 저장 경로: {excel_file_path}")





##################################################################################






# 코드 문제 5
data = [
    ["1,000", "1,100", '1,510'],
    ["1,410", "1,420", '1,790'],
    ["850", "900", '1,185'],
]
columns = ["03/02", "03/03", "03/04"]
df = pd.DataFrame(data=data, columns=columns)
df.info()

# 답지
# 여기서부터 코드 작성

# 사용자 정의 함수
def rm_comma(value):
    return int(value.replace(",", ""))

# apply()를 사용하여 특정 컬럼에 함수 적용
df["03/02"] = df["03/02"].apply(rm_comma)
df["03/03"] = df["03/03"].apply(rm_comma)

# 결과 출력
print(df)






##################################################################################








# 코드 문제 6
'''
apple = yf.download("AAPL", start="2020-01-01", end = "2024-09-30")
fig, ax = plt.subplots()
ax.plot(apple['Open'], label = "Apple")
ax.legend()
plt.show()
'''
# 답지
# 여기서부터 코드 작성
import yfinance as yf
import seaborn as sns
import matplotlib.pyplot as plt

# 주식 데이터 다운로드
apple = yf.download("AAPL", start="2020-01-01", end="2024-09-30")

# Seaborn 스타일 설정
sns.set(style="whitegrid")

# 데이터 시각화
plt.figure(figsize=(12, 6))
sns.lineplot(data=apple, x=apple.index, y='Open', label='Apple')

# 범례 추가
plt.legend()

# 이미지 저장
plt.savefig('output/code6_jaehyun.png')

# 시각화 출력
plt.show()




##################################################################################





# 코드 문제 7
tips = sns.load_dataset("tips")

# 답지
# 여기서부터 코드 작성

import matplotlib.pyplot as plt
import seaborn as sns
import os

# Load the Seaborn tips dataset
tips = sns.load_dataset("tips")

# Create a 3x3 grid of subplots
fig, axs = plt.subplots(3, 3, figsize=(8, 8))

# Plot only the center subplot with a scatter plot (similar to your image)
axs[1, 1].scatter(tips['total_bill'], tips['tip'])
axs[1, 1].set_title("Scatter Plot of Total Bill vs Tip")
axs[1, 1].set_xlabel("Total Bill")
axs[1, 1].set_ylabel("Tip")

# Hide the other plots
for i in range(3):
    for j in range(3):
        if (i, j) != (1, 1):
            axs[i, j].axis('off')

# Add a main title to the figure
fig.suptitle("Visualization example", fontsize=16)


# Save the figure to the specified path
output_path = "output/code7_jaehyun.png"
fig.savefig(output_path)
plt.show()

























##################################################################################

# 코드 문제 8
apple = yf.download("AAPL", start="2024-05-01", end="2024-09-30")

# 답지
# 여기서부터 코드 작성


import yfinance as yf
import plotly.graph_objects as go

# yfinance로 AAPL 주가 데이터 다운로드
apple = yf.download("AAPL", start="2024-05-01", end="2024-09-30")

# 캔들 차트 생성
fig = go.Figure(data=[go.Candlestick(
    x=apple.index,
    open=apple['Open'],
    high=apple['High'],
    low=apple['Low'],
    close=apple['Close'],
    name="AAPL",
    increasing_line_color='red',
    decreasing_line_color='blue'
)])

# 레이아웃 업데이트
fig.update_layout(
    title='AAPL Candlestick Chart',
    xaxis_title='Date',
    yaxis_title='Price (USD)',
    xaxis_rangeslider_visible=False,  # 범위 슬라이더 숨김
    template='plotly_dark'  # 다크 테마 설정
)

# 트레이스 업데이트
fig.update_traces(
    hoverinfo='x+y',  # 호버 정보 설정
    opacity=0.8  # 투명도 설정
)

# 차트 보여주기
fig.show()