def fun1():
	
	file_name1 = "out_11.txt"
	file_name2 = "output_2.txt"
	file_name3 = "output_3.txt"
	process = "COMMAND"
	vrr = "VIRT"
	vss = "RES"
	
	#Read fron output_1
	f1 = open(file_name1)
	f1_lines = f1.readlines()
	search_phase = "VIRT"
	line_num_1 = 0
	first_line = 0
	output_1 = []
	for line in f1_lines:
		line_num_1 += 1
		if search_phase in line:
			if first_line == 0:
				output_1.append(line)
				first_line = 1
			for j in range(0,10):
				output_1.append(f1_lines[line_num_1+j])			
	f1.close()

	#Save files to output_2
	f2 = open(file_name2,'w')
	for x in output_1:
		f2.writelines(x)
		#print x
	f2.close()
	
	#find process, vrr, vss places in output_2
	f3 = open(file_name2)
	f3_first_line = f3.readline().split()
	line_num_2 = -1
	vrr_num = -1
	vss_num = -1
	process_num = -1
	
	#find numbers
	for i in f3_first_line:
		line_num_2 += 1
		if i == process:
			process_num = line_num_2
		elif i == vrr:
			vrr_num = line_num_2
		elif i == vss:
			vss_num = line_num_2

	#make dictionary
	f3_lines = f3.readlines()
	d={}
	for i in f3_lines:
		process_value = i.split()[process_num]
		vss_value = i.split()[vss_num]
		vrr_value = i.split()[vrr_num]
		if process_value in d.keys():
			d[process_value][0].append(vss_value)
			d[process_value][1].append(vrr_value)
		else:
			d[process_value] = [vss_value],[vrr_value]
	f3.close()
	
	#find average and write to output_3
	f4 = open(file_name3,'w')
	for key in d:
		avg_vss=0
		for i in d[key][0]:
			avg_vss += int(i)
		avg_vss = float(avg_vss/len(d[key][0]))
		avg_vrr=0
		for i in d[key][1]:
			avg_vrr += int(i)
		avg_vrr = float(avg_vss/len(d[key][1]))
		
		if (avg_vss != 0)&(avg_vrr != 0):
			f4.write("cpu= ")
			f4.write(key)

			#f4.write("\n\tvss values=   ")
			#for x in (d[key][0]):
			#	f4.write(x)
			#	f4.write(" ")

			f4.write("\n\tvss avgerage= ")
			f4.write("%d"%avg_vss)

			#f4.write("\n\tvrr values=   ")
			#for x in (d[key][1]):
			#	f4.write(x)
			#	f4.write(" ")

			f4.write("\n\tvrr avgerage= ")
			f4.write("%d"%avg_vrr)
			f4.write("\n")
	f4.close()

				
	
	









































if __name__=="__main__":
	fun1()
