raw_all_vcf=$1
chr=$2
start_pos=$3
end_pos=$4
kind_name=${chr}_${start_pos}_${end_pos}
mkdir result/$kind_name

./bin/vcftools_0.1.13/bin/vcftools --vcf $raw_all_vcf  --chr $chr --from-bp $start_pos --to-bp $end_pos --recode --out ${chr}_${start_pos}_${end_pos}
work_file=${chr}_${start_pos}_${end_pos}.recode.vcf

vcf2csv(){
	work_file=$1
        perl  ./bin/convertIndelVcfToCSV.pl $work_file #将切割好的vcf文件转化
        sed "s/\t/ /g" $work_file.csv >${work_file}_new.csv
        rm $work_file.csv
        mv ${work_file}_new.csv ${work_file}.csv
 }
 vcf2csv $work_file

 get_k(){
 	work_file=$1
 	sed 's/ /\t/g' ${work_file}.csv >temp1_${work_file}.csv
 	sed 's/^[^\t]*\t//' temp1_${work_file}.csv > temp2_${work_file}.csv #去除第一列
 	sed 's/\bA\b/8/g; s/\bT\b/6/g; s/\bC\b/4/g; s/\bG\b/2/g; s/-/10/g; s/\bN\b/12/g' temp2_${work_file}.csv >temp3_${work_file}.csv
 	sed 's/\t/,/g' temp3_${work_file}.csv >${work_file}_fig.csv
 	python ./bin/t.py ${work_file}_fig.csv
 	sed  '1,2d' t_${work_file}_fig.csv >temp4_t_${work_file}_fig.csv
 	sed 's/,/\t/g' temp4_t_${work_file}_fig.csv >temp5_t_${work_file}_fig
 	cp temp5_t_${work_file}_fig test_file
 	sh ./bin/go_Test.sh ${work_file}
 	python ./bin/plt.py ${work_file}
 	sed 's/,/\t/g' result_${work_file} >temp1_result_${work_file}
 	cut -f3 temp1_result_${work_file} | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
}
get_k $work_file


Makeheatmap(){
	work_file=$1
	k=$(cut -f3 temp1_result_${work_file} | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
	Rscript ./bin/MakeHeatmap.R -f ${work_file}.csv  -k ${k} -s $(pwd) -t  ${work_file}.pdf  -o ${work_file}_out.csv
}
Makeheatmap $work_file

get_order(){
	work_file=$1
	sed 's/,/\t/g' ${work_file}_out.csv >${work_file}_out.csv_new
        #sh ./bin/vlookup.sh new_class ${work_file}_out.csv_new
        cp ${work_file}_out.csv_new ${work_file}_out.csv_new.extracted
	awk '{ print FNR"\t"$0}' ${work_file}_out.csv_new.extracted >${work_file}_out.csv_new.extracted_new 
        mv ${work_file}_out.csv_new.extracted_new ${work_file}_out
        rm ${work_file}_out.csv ${work_file}_out.csv_new ${work_file}_out.csv_new.extracted
        rm ${work_file}_out.csv_new.extracted_new
}
get_order $work_file

rm get_a test_file out_file temp* t_*
mv ${work_file}* ./result/$kind_name/
mv output* ./result/$kind_name/
mv *log  ./result/$kind_name/
mv result_* ./result/$kind_name/
