# -*- coding: utf-8 -*-
# 파일명 : 08_seaborn.py
import pandas as pd 
import seaborn as sns
import streamlit as st
import matplotlib.pyplot as plt

@st.cache_data
def load_data():
    df = sns.load_dataset('tips')
    return df

def main():
    st.title("Streamlit with Seaborn")   
    tips = load_data()

    # 데이터가공
    m_tips = tips.loc[tips['sex'] == 'Male', :]
    f_tips = tips.loc[tips['sex'] == 'Female', :]

    # 시각화 차트
    fig, ax = plt.subplots(ncols=2, figsize=(10, 6), sharex=True, sharey=True)
    sns.scatterplot(data=m_tips, x = 'total_bill', y = 'tip', ax=ax[0])
    ax[0].set_title('Male')
    sns.scatterplot(data=f_tips, x = 'total_bill', y = 'tip', ax=ax[1])
    ax[0].set(xlabel=None, ylabel=None)
    ax[1].set_title('Female')
    ax[1].set(xlabel=None, ylabel=None)

    # 중요포인트
    # plt.show()
    st.pyplot(fig)

if __name__ == "__main__":
    main()