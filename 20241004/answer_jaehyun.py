import pandas as pd
import matplotlib.pyplot as plt
import seaborn
#import plotly

#문제1.
'''
개발환경 설정 및 깃허브 push하는 전 과정 서술
(이건 그냥 문제 공개ㅋㅋㅋ 지난주에만 5번 넘게 함, 틀린 사람 커피 사야 해ㅋㅋㅋㅋㅋ)
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


'''

#문제2.

#시각화 이미지 내보내기

#데이터 프레임 내보내기

'''
내보내기 경로는 output으로 잡으면 됨
어렵다고 하지 말고 열심히 공부하세요!
'''

'''
실행하는 법

$ cd 20241004/


'''

#정답
text=[1,2,3]
print(text)

'''
그동안 배웠던 자주 쓰는 기본 문법 위주로 꼭 공부 열심히 하세요

시각화 배웠던 것 중에서 중요한거 
하나는 완전 똑같이 출제
하나는 응용해서 출제


'''


#정답은 주석처리 이런식으로 하고 
#text=[1,2,3]

#문제2번 풀러 가세요!