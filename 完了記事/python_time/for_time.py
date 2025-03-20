

from datetime import datetime

# 現在の日時を取得
time_datetime= datetime.now()
print(time_datetime) 
 


import time

# 現在の時刻（エポック秒）を取得
time_time = time.time()
print(time_time)  
print(f"{time_time:.3f}") 


# 現在の時刻をフォーマットして表示
local_time = time.localtime()
formatted_time = time.strftime("%Y-%m-%d %H:%M:%S", local_time)
print(formatted_time)  




from datetime import datetime
import pytz

# タイムゾーンを指定して現在時刻を取得
time_pytz = pytz.timezone("Asia/Tokyo")
tokyo_time = datetime.now(time_pytz)
print(tokyo_time)  




import arrow

# 現在の時刻を取得
time_arrow= arrow.now()
print(time_arrow)  




import timeit

# 現在の時刻をエポック秒で取得
timestamp = timeit.default_timer()
print(timestamp)  



import time

# 高精度な時刻取得
current_time = time.perf_counter()
print(current_time)  



r"""
conda create -n time_env python
pip install pytz arrow



(time_env) C:\Users\mosuk>python --version
Python 3.13.2
"""







