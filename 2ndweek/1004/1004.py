'''
현재 프로젝트  폴더(최상위 폴더) 기준, abc 폴더를 생성하고 abc 폴더 내 아래 데이터프레임을 내보내기 하세요.
CSV / Excel 파일 모두
실행 파일명 : 20241004.py
today_stock.csv, today_stock.xlsx

from pandas import DataFrame

data = {
    "종목명": ["3R", "3SOFT", "ACTS"],
    "현재가": [1510, 1790, 1185],
    "등락률": [7.36, 1.65, 1.28],
}

df = DataFrame(data, index=["037730", "036360", "005760"])
df
'''

from pandas import DataFrame

data = {
    "종목명": ["3R", "3SOFT", "ACTS"],
    "현재가": [1510, 1790, 1185],
    "등락률": [7.36, 1.65, 1.28],
}

df = DataFrame(data, index=["037730", "036360", "005760"])
df

df.to_csv("today_stock.csv", index=True)
df.to_excel("today_stock.xlsx", index=True)

# 실행할 때 타이핑 하지 말고, tab으로 해
