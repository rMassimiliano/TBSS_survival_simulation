scenario_list = c('Scenario1', 'Scenario2', 'Scenario3', 'ScenarioPS1', 'ScenarioPS2', 'ScenarioPS3', 'ScenarioH1', 'ScenarioH2', 'ScenarioH3')
method_list = c( 'bernoulliTBSS', 'coxTBSS', 'poissonSTBSS', 'poissonTBSS', 'robustTBSS')

for(s in scenario_list)
{
	results = matrix(0,20000,length(method_list))
	pm = 1
 for(m in method_list)
 {
	 c_path = sprintf("%s/results/%s",s,m)
	 c_files = list.files(c_path)
	 pf  =1
	 for(f in c_files)
	{
		c_dat = readRDS(sprintf('%s/%s',c_path,f))
                results[pf,pm]=  c_dat$exec_time[3]
		pf = pf+1
	}
	 pm = pm+1
	 sprintf("Done %s/%s \r",s,m)  |> cat()
 }
 write.csv(results, file = sprintf('%s_comp_time.csv',s))
}

                 

	
