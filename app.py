import yfinance as yf

apple=yf.download("AAPL", start="2020-01-01",end='2024-09-30')
nvidia=yf.download("NVDA", start="2020-01-01",end='2024-09-30')
intel=yf.download("INTC", start="2020-01-01",end='2024-09-30')


fig,ax=plt.subplots()
ax.plot(apple['Open'], label = "Apple")
ax.plot(nvidia['Open'], label = "Nvidia")
ax.legend()
ax.set_title("Stocks")

plt.show()

fig, ax = plt.subplots(nrows=2,ncols=2,figsize=(10,4))


ax[0][0].set_title("Apple Stocks")
ax[0][1].set_title("Nvidia Stocks")
ax[1][0].set_title("Intel Stocks")

ax[0][0].plot(apple['Open'], label = "Apple")
ax[0][1].plot(nvidia['Open'], label = "Nvidia")
ax[1][0].plot(intel['Open'], label = "Intel")

fig.tight_layout() # 그래프가 겹치지 않도록 약간씩 알아서 자동으로 띄워줌

ax[0][0].legend()
ax[0][1].legend()
ax[1][0].legend()

plt.savefig("myStocks.png")
plt.show()