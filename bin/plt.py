import matplotlib.pyplot as plt
import pandas as pd
import sys
if len(sys.argv) != 2:
    print("Usage: python plt.py <arg1> ")
    sys.exit(1)

arg1 = sys.argv[1]
input_data=f"result_{arg1}"
output_plot = f"output_{arg1}_plot.png"

# 读取包含数据的文件，假设是CSV格式
data = pd.read_csv(input_data)

# 提取第一列和第三列数据
x = data.iloc[:, 0]
y = data.iloc[:, 2]

# 创建折线图
plt.figure(figsize=(10, 6))  # 设置图形大小
plt.plot(x, y, marker='o', linestyle='-', color='b', label='折线图标题')

# 设置图形标签
plt.xlabel('X轴标签')
plt.ylabel('Y轴标签')
plt.title('折线图标题')

# 添加图例
plt.legend()

# 显示图形
plt.grid(True)  # 添加网格线
#plt.show()
plt.savefig(output_plot)
