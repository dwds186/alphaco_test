# -*- coding: utf-8 -*-
import streamlit as st
import pandas as pd

# 캐시 메모리는 대용량 데이터는 불러오면 안 돼! 주의 사항
# 현업(에서는) : sql 데이터 가공을 일부 진행할 필요 있음
# 쉽게 말하면 raw데이터는 그대로 끌고 오면 안 됨
@st.cache_data
def load_data():
    train = pd.read_csv("./data/train.csv")
    return train

def main():
    st.title("여기에서부터 시작")
    train = load_data()
    print(train.head())
    st.dataframe(train)
    st.data_editor(train)
    ### table
    #st.table(train) # 가급적 사용하지 말자
    # table은 사용하지 않는 것을 추천 랙 걸린 것처럼 정적으로 딱 찍혀서 보기 안 예쁨 용량도 많이 차지

########################                             st.column_config
    data_df = pd.DataFrame(
    {
        "sales": [
            [0, 4, 26, 80, 100, 40],
            [80, 20, 80, 35, 40, 100],
            [10, 20, 80, 80, 70, 0],
            [10, 100, 20, 100, 30, 100],
        ],
    }
)

    st.data_editor(
    data_df,
    column_config={
        "sales": st.column_config.BarChartColumn(
            "Sales (last 6 months)",
            help="The sales volume in the last 6 months",
            y_min=0,
            y_max=100,
        ),
    },
    hide_index=True,
)

if __name__ == "__main__":
    main()


