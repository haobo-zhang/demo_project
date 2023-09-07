import pandas as pd
import sys
if len(sys.argv) != 2:
    print("Usage: python t.py <arg1> ")
    sys.exit(1)
arg1 = sys.argv[1]
inputfile=arg1
outputfile=f"t_{arg1}"
# 读取CSV文件
df = pd.read_csv(arg1)

# 使用T方法进行转置
transposed_df = df.T

# 保存转置后的数据到新的CSV文件
transposed_df.to_csv(outputfile, index=False)

