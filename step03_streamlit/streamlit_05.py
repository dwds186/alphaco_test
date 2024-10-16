# -*- coding: utf-8 -*-
import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

def cal_sales_revenue(price, total_sales): #사용자정의함수
    revenue = price * total_sales
    return revenue



def main():
    st.title("여기에서부터 시작")
    price=st.slider("단가",1000,10000,value=5000)
    #print(price)
    total_sales=st.slider("판매갯수",1,1000,value=500)
    print(price, total_sales)

    # 출력 값 표시 chat gpt
    st.write(f"**선택된 단가**: {price} 원")
    st.write(f"**선택된 판매 갯수**: {total_sales} 개")
    #revenue = cal_sales_revenue(price, total_sales)
    #st.write(f"### 총 매출액: {revenue} 원")

    # 강사님
    st.write("단가:", price, "판매갯수:", total_sales)
    st.write(print(price))
    st.write(print(total_sales))
    #print(type(price)) #int 정수로 나올것이야

    if st.button("매출액 계산"):
        revenue = cal_sales_revenue(price, total_sales)
        st.write(revenue)


    st.title("check box control")
    x=np.linspace(0,10,100)
    y=np.sin(x)
    z=np.cos(x)
    show_plot=st.checkbox("시각화 보여주기")
    print(show_plot) #show_plot의 기본값은 false임


    if show_plot:
        fig, ax = plt.subplots()
        ax.plot(x,y)
        ax.plot(x,z)
        st.pyplot(fig)



if __name__ == "__main__":
    main()