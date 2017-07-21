# CFMIP_LowCloudDistribution
NCL script : Comparison of vertical distribution of non-overlapped low level clouds from CFMIP Calipso simulator and CALIPSO-GOCCP.

The plots show the frequency in which tropical low-level clouds below 4km are vertically distributed in
shallow cumulus and stratocumulus regimes under non-overlapped, subsiding cloud conditions; more
specifically, when omega500hPa and omega700hPa is greater than 10 hPa day-1 and high- and mid-level cloud
cover is less than 5%.


# References
1) Nam, C., S. Bony, J.-L. Dufresne, and H. Chepfer, The "too few, too bright" tropical low-cloud problem in CMIP5 models, Geophys. Res. Lett., 39, L21801, doi:10.1029/2012GL053421, 2012.


# Model Input Variables
The code makes use of the following data, all of which are available at https://github.com/chriscnam/CFMIP_LowCloudDistribution/tree/master/data , except for the observed 3D Cloud Fraction due to file size limitations.


| Frequency |	Variable |	Variable labels |	Unit |	Example File |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Monthly | Surface pressure | ps | Pa | ps_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Surface temperature | ts | K | ts_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Temperature | ta | K | ta_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Vertical Velocity | wap | Pa s-1 | wap_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | High-level Cloud Fraction COSP lidar simulator | clhcalipso | % | clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Mid-level Cloud Fraction COSP lidar simulator | clmcalipso | % | clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Low-level Cloud Fraction COSP lidar simulator | cllcalipso | % | cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | 3D Cloud Fraction COSP lidar simulator | clcalipso | % | clcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Cloud Reflectance PARASOL | parasolRefl | 1 | parasolRefl_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc

# Era Interim Re-analysis Input Variables
| Frequency |	Variable |	Variable labels |	Unit |	
| ------------- | ------------- | ------------- | ------------- | 
| Monthly | Surface pressure | sp | Pa |
| | 2 metre temperature | t | K |
| | Temperature | t | K |
| | Vertical velocity | w | Pa s-1 |

# Obs4MIPS Input Variables
| Frequency |	Variable |	Variable labels |	Unit |	
| ------------- | ------------- | ------------- | ------------- | 
| Monthly | High-level Cloud fraction CALIPSO-GOCCP |	clhcalipso |	% 	|
| | Mid-level Cloud fraction CALIPSO-GOCCP | clmcalipso |	% 	|
| |	Low-level Cloud Fraction CALIPSO-GOCCP |	cllcalipso |	% |
| | 3D Cloud Fraction CALIPSO-GOCCP |	clcalipso |	% | 
 
# Output
This script processes and draws the figure 'VertDist_LowCld_Metrics_CNam.png'
