n=$(awk '{print NF; exit}' test_file)

# 随机选择1到5列
rand_cols=$(shuf -i 1-$n -n $1)  # 选择1到5之间的五个随机数，表示要选择的列号
echo $rand_cols
# 提取选定列并计算不重复行的数量和每种不重复行的重复次数
awk -v cols="$rand_cols" 'BEGIN {
    split(cols, selected_cols)  # 将随机选择的列号分割成数组
}
{
    row = ""
    for (i = 1; i <= length(selected_cols); i++) {
        row = row $selected_cols[i] "\t"  # 构建包含选定列的行
    }
    a[row]++  # 统计每种不重复行的重复次数
} END {
    print "不重复行数量:", length(a)
    for (key in a) {
        print "行:", key, "重复次数:", a[key]  # 输出不重复行的值和重复次数
    }
}' test_file >out_file

awk -v cols="$rand_cols" 'BEGIN {
    split(cols, selected_cols)  # 将随机选择的列号分割成数组
}
{
    row = ""
    for (i = 1; i <= length(selected_cols); i++) {
        row = row $selected_cols[i] "\t"  # 构建包含选定列的行
    }
    a[row]++  # 统计每种不重复行的重复次数
} END {
    for (key in a) {
        print a[key]  # 输出不重复行的值和重复次数
    }
}' test_file >get_a

#未限定的len_a
len_a=$(awk -v cols="$rand_cols" 'BEGIN {
    split(cols, selected_cols)  # 将随机选择的列号分割成数组
}
{
    row = ""
    for (i = 1; i <= length(selected_cols); i++) {
        row = row $selected_cols[i] "\t"  # 构建包含选定列的行
    }
    a[row]++  # 统计每种不重复行的重复次数
} END {
    print length(a)
}' test_file)
echo "不重复行数量: $len_a"

#全部材料设定阈值
c=$(wc -l < test_file)
threshold=$(($c / 20))

a=$(cat get_a)
# 找到重复次数少于阈值的不重复行数量
count=0
for a in `cat get_a`
do
	if (($a>$threshold)); then
        ((count++))
	fi
done
echo $1,$len_a,$count >>result_$2

#echo "重复次数多余原文件全行数百分之十的不重复行数量: $count"
