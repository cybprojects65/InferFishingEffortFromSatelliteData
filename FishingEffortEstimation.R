cat("#FISHING EFFORT ESTIMATION STARTED#\n")
#estimate sampling period:

if ("reconstruction_log_probability" %in% colnames(vessel_data)){
  upper_fishing_thr<-as.numeric(quantile(vessel_data$reconstruction_log_probability)[3])
  fishing_idx<-which(vessel_data$reconstruction_log_probability<=upper_fishing_thr)
}else if ("fishing" %in% colnames(vessel_data)){
  fishing_idx<-which(vessel_data$fishing)
}
vae_zones<-vessel_data[fishing_idx,]

sumvae<-sum(vae_zones$density,na.rm=T)
cat(" total times vessels have been in the fishing zones:",sumvae,"\n")
#25perc of ratio between AIS data and all data
fraction_of_abundance_observation_lower_bound=as.numeric(properties["fraction_of_abundance_observation_lower_bound"])
#75perc of ratio between AIS data and all data
fraction_of_abundance_observation_upper_bound=as.numeric(properties["fraction_of_abundance_observation_upper_bound"])

if (fraction_of_abundance_observation_lower_bound==-1 || fraction_of_abundance_observation_upper_bound==-1){
  #permanence depends on the sampling frequency of the dataset
  upper_hours<-sumvae*(low_sampling_period+0.5*low_sampling_period)
  lower_hours<-sumvae*(low_sampling_period-0.5*low_sampling_period)
  average_hours<-sumvae*(low_sampling_period)
}else{
  max_fishing_hours_per_cell<-365*10 #10 hours per day
  observation_time = format(original_data$time, format = "%Y-%m-%d-%H")
  observation_hours_in_one_year_u<-unique(observation_time)
  observation_hours_in_one_year<-length(observation_hours_in_one_year_u)
  #calculate the fraction between observed and potentially unobserved fishing activity
  #observation bias=hours observed/maximum unobserver
  observation_fraction<-observation_hours_in_one_year/max_fishing_hours_per_cell
  fraction_of_abundance_observation_low<-fraction_of_abundance_observation_lower_bound
  fraction_of_abundance_observation_high<-fraction_of_abundance_observation_upper_bound
  #upper hours = (total hours/observation bias)/lower bound of AIS data wrt to other observations (which might be AIS data unrecognized by the satellite)
  upper_hours<-sumvae/(observation_fraction*fraction_of_abundance_observation_low)
  lower_hours<-sumvae/(observation_fraction*fraction_of_abundance_observation_high)
  average_hours<-((upper_hours+lower_hours)/2.0)
}

cat(" Lower number of hours spent in the area:",lower_hours,"\n")
cat(" Upper number of hours spent in the area:",upper_hours,"\n")

vessel_data_fishing<-vessel_data
vessel_data_fishing$lower_fishing_effort_estimate<-lower_hours*vessel_data_fishing$density/sumvae
vessel_data_fishing$lower_fishing_effort_estimate[-fishing_idx]<-0

vessel_data_fishing$average_fishing_effort_estimate<-average_hours *vessel_data_fishing$density/sumvae
vessel_data_fishing$average_fishing_effort_estimate[-fishing_idx]<-0

vessel_data_fishing$upper_fishing_effort_estimate<-upper_hours*vessel_data_fishing$density/sumvae
vessel_data_fishing$upper_fishing_effort_estimate[-fishing_idx]<-0

cat("#FISHING EFFORT ESTIMATION FINISHED#\n")