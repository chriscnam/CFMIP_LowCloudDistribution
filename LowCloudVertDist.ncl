load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

;===============================================================
; This script contains a panel of 2 plots of:
; 1) Shallow Cumulus and Stratocumulus mask (ERA-Interim & Model)
; 2) Vertical Distribution of clooud below 4km (CALIPSO observations & Model with Calipso simulator)
; for tropical (30N to 30S) non-verlapped low-level cloud conditions (where high and mid level clouds are less than 5%).
;
; This NCL script has been made for example data 2008. Variable names follow CMIP5 convention.
; 
; You need to make the following changes (find 'Metric'): 
; 1)File format of output file (example: pdf or eps) & Choose color table
; 2)Title of output file
; 3)Directories of input files and working directory
; 4)Input files
;
; Christine Nam
;    Laboratoire de Météorologie Dynamique
;    Institut Pierre Simon Laplace
;    Centre National de la Recherche Scientifique
;    Paris, France
;    Nov. 2012
; 
; Support of this work came from the EUCLIPSE project - European Union, Seventh Framework Programme (FP7/2007–2013) grant 244067. 
;
;===============================================================
; FILE INFORMATION
; --------------------------------------------------------------
; example: wks = gsn_open_wks("Metric1","Metric2")
  wks_type = "pdf"
  wks_type@wkOrientation = "landscape"

  wks = gsn_open_wks(wks_type,"IPSL5B_Low3DVertDist_2008")  ;file type: "x11";"pdf";"eps"

  plot = new(4,graphic)              ; create plot array

  cmap = RGBtoCmap("RGBmatlab.txt")     ; CNam: using personalized color table
  gsn_define_colormap(wks, cmap) 	
;  gsn_define_colormap(wks,"matlab_jet"); CNam: uncomment for NCL predefined table
  
;===============================================================
; MODELS with COSP Calipso and Parasol satellite simulators
; --------------------------------------------------------------
; example: directoryA = "/Metric3/" ; Directory of CRE data
;	   directoryB = "/Metric3/" ; Directory of COSP simulator
;	   directoryC = "/Metric3/" ; Working Directory
  directoryA = "/prodigfs/esg/CMIP5/merge/IPSL/IPSL-CM5B-LR/amip/mon/atmos/Amon/r1i1p1/v20120526/"
  directoryB = "/prodigfs/esg/CMIP5/merge/IPSL/IPSL-CM5B-LR/amip/mon/atmos/cfMon/r1i1p1/v20120526/"
  directoryC = "/data/cnlmd/CMIP5_AMIP_Metric/"

  
;===============================================================
; MODELS with COSP Calipso and Parasol satellite simulators
; --------------------------------------------------------------
; example: directoryA = "/Metric3/" ; Directory of CRE data
;	   directoryB = "/Metric3/" ; Directory of COSP simulator
;	   directoryC = "/Metric3/" ; Working Directory
  directoryA = "/prodigfs/esg/CMIP5/merge/IPSL/IPSL-CM5B-LR/amip/mon/atmos/Amon/r1i1p1/v20120526/"
  directoryB = "/prodigfs/esg/CMIP5/merge/IPSL/IPSL-CM5B-LR/amip/mon/atmos/cfMon/r1i1p1/v20120526/"
  directoryC = "/data/cnlmd/CMIP5_AMIP_Metric/"

; --------------------------------------------------------------
; Extracting variables for 2008 from original AMIP files. 
; --------------------------------------------------------------
; example: systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryA+"Metric4_origfile "+directoryC+"Metric4_2008file"
     extract1=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryA+"ps/ps_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"ps_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract2=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryA+"ts/ts_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"ts_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract3=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,70000 -selyear,2008 "+directoryA+"ta/ta_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"t700_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract4=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,50000 -selyear,2008 "+directoryA+"wap/wap_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"wap500_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract5=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,70000 -selyear,2008 "+directoryA+"wap/wap_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"wap700_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")


     extract6=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"clhcalipso/clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract7=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"clmcalipso/clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract8=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"cllcalipso/cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract9=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"parasolRefl/parasolRefl_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"parasolRefl_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")


; --------------------------------------------------------------
; Cloud Radiative Effect files
; --------------------------------------------------------------
	file101="wap500_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc" 	; "Metric4"
	file102="wap700_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
	file103="t700_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
	file104="ts_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
	file105="ps_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
   apple  = addfile(directoryC+file101,"r")
   pear   = addfile(directoryC+file102,"r")
   orange = addfile(directoryC+file103,"r")
   cherry = addfile(directoryC+file104,"r")
   lime = addfile(directoryC+file105,"r")
; --------------------------------------------------------------
; COSP simulator files
; --------------------------------------------------------------
	file201 = "clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc" ; "Metric4"
	file202 = "clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
	file203 = "cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc" 
	file204 = "clcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
   lychee   = addfile(directoryC+file201,"r")
   pineapple= addfile(directoryC+file202,"r")
   starfruit= addfile(directoryC+file203,"r")
   plum     = addfile(directoryC+file204,"r")


;===============================================================
;===============================================================
; MODEL 
;===============================================================
;===============================================================
; -------------------------------------------------------------
; Import variables
; -------------------------------------------------------------
   IPSL5B_lat=apple->lat
     print(IPSL5B_lat)
     nlat=dimsizes(IPSL5B_lat)  ;
   IPSL5B_lon=apple->lon
     ;print(IPSL5B_lon)
     nlon=dimsizes(IPSL5B_lon)

   IPSL5B_time=apple->time(:)
      ntime = dimsizes(IPSL5B_time)

   IPSL5B_omega500= apple->wap(time|:,plev|0,lat|:,lon|:)
   IPSL5B_omega700= pear->wap(time|:,plev|0,lat|:,lon|:)
	IPSL5B_omega500@_FillValue=1.e+20
	IPSL5B_omega700@_FillValue=1.e+20		
   printVarSummary(IPSL5B_omega500)

   IPSL5B_surfpressure= lime->ps(time|:,lat|:,lon|:)
   IPSL5B_surftemp= cherry->ts(time|:,lat|:,lon|:)
   IPSL5B_temp700= orange->ta(time|:,plev|0,lat|:,lon|:)
	IPSL5B_surfpressure@_FillValue=1.e+20
	IPSL5B_surftemp@_FillValue=1.e+20
	IPSL5B_temp700@_FillValue=1.e+20		
   printVarSummary(IPSL5B_temp700)

   IPSL5B_Highcld=lychee->clhcalipso(:,:,:)
	IPSL5B_Highcld@_FillValue=1e20
   IPSL5B_Midcld=pineapple->clmcalipso(:,:,:)
	IPSL5B_Midcld@_FillValue=1e20
   IPSL5B_Lowcld=starfruit->cllcalipso(:,:,:)
	IPSL5B_Lowcld@_FillValue=1e20
   IPSL5B_3Dcld=plum->clcalipso(:,:,:,:)
	IPSL5B_3Dcld@_FillValue=1e20


   IPSL5B_alt=plum->alt40(0:8)
	IPSL5B_alt!0= "alt40"
      print(IPSL5B_alt)
      nalt=dimsizes(IPSL5B_alt)


; -------------------------------------------------------------
; Define Variables for Calculations
; -------------------------------------------------------------
   ;----- 1. Define Variables for Large-Scale Calculations -----
   CldRange=fspan(0,100,21)
     ;print(CldRange)
     ncld=dimsizes(CldRange)

   IPSL5B_tpot700=new((/ntime,nlat,nlon/),float)
   IPSL5B_tpotsf=new((/ntime,nlat,nlon/),float)
   IPSL5B_lts=new((/ntime,nlat,nlon/),float)

   ;----- 2. Define Variables for 3D-Cloud Calculations -----

   IPSL5B_Shcu_threeDfrac_Histo=new((/ntime,ncld,nalt/),float)
     IPSL5B_Shcu_threeDfrac_Histo!0      = "time"
     IPSL5B_Shcu_threeDfrac_Histo!1      = "cldfra"             ; assign dimension names
     IPSL5B_Shcu_threeDfrac_Histo!2      = "alt40"
     IPSL5B_Shcu_threeDfrac_Histo(:,:,:)=0

   IPSL5B_Strat_threeDfrac_Histo=new((/ntime,ncld,nalt/),float)
     IPSL5B_Strat_threeDfrac_Histo!0      = "time"
     IPSL5B_Strat_threeDfrac_Histo!1      = "cldfra"             ; assign dimension names
     IPSL5B_Strat_threeDfrac_Histo!2      = "alt40"
     IPSL5B_Strat_threeDfrac_Histo(:,:,:)=0


   IPSL5B_Shcu_cnt_3Dfrac=new((/ntime,ncld,nalt/),float)
     IPSL5B_Shcu_cnt_3Dfrac(:,:,:)=0
     IPSL5B_Shcu_cnt_3Dfrac!0  = "time"
     IPSL5B_Shcu_cnt_3Dfrac!1  = "cldfra"             ; assign dimension names
     IPSL5B_Shcu_cnt_3Dfrac!2  = "alt40"
     IPSL5B_Shcu_cnt_3Dfrac@_FillValue=1.e+20
   IPSL5B_Shcu_ind_3Dfrac=new((/ntime,ncld,nalt/),integer)
     IPSL5B_Shcu_ind_3Dfrac(:,:,:)=0

   IPSL5B_Strat_cnt_3Dfrac=new((/ntime,ncld,nalt/),float)
     IPSL5B_Strat_cnt_3Dfrac(:,:,:)=0
     IPSL5B_Strat_cnt_3Dfrac!0  = "time"
     IPSL5B_Strat_cnt_3Dfrac!1  = "cldfra"             ; assign dimension names
     IPSL5B_Strat_cnt_3Dfrac!2  = "alt40"
     IPSL5B_Strat_cnt_3Dfrac@_FillValue=1.e+20
   IPSL5B_Strat_ind_3Dfrac=new((/ntime,ncld,nalt/),integer)
     IPSL5B_Strat_ind_3Dfrac(:,:,:)=0


;==================== 3D-CloudFraction Histo ================================
; *NOTE: .ge.0.00001 specific to IPSL_5B model
;=============================================================================
 do m=0,(ntime-1)
   do l=0,(nlat-1)
   do k=0,(nlon-1)
	IPSL5B_tpot700(m,l,k)= IPSL5B_temp700(m,l,k)*(1000./700.)^0.286
	IPSL5B_tpotsf(m,l,k)= IPSL5B_surftemp(m,l,k)*(1000./(IPSL5B_surfpressure(m,l,k)/100.))^0.286 ; CNam:ps in Pa  
	IPSL5B_lts(m,l,k)= IPSL5B_tpot700(m,l,k)-IPSL5B_tpotsf(m,l,k)
        ;*** ONLY LOW: High and Mid < 5% *** 
 	if (.not.ismissing(IPSL5B_Lowcld(m,l,k)) .and. IPSL5B_Lowcld(m,l,k).ge.0.00001 .and. IPSL5B_Midcld(m,l,k).le.5 .and. IPSL5B_Highcld(m,l,k).le.5) then
        ;*** Find Subsidence ***
        if ((IPSL5B_omega700(m,l,k)*864.).ge.10. .and.(IPSL5B_omega500(m,l,k)*864.).ge.10.) then   
        ;*** SEPERATE: Shallow Cu and Strato Cu ***
	do i=0,(ncld-1)
	do j=0,(nalt-1)
        ; --- shallow cumulus ---
	   if (.not.ismissing(IPSL5B_lts(m,l,k)) .and. IPSL5B_lts(m,l,k).lt.18.55) then
	   if (.not.ismissing(IPSL5B_3Dcld(m,j,l,k)) .and. IPSL5B_3Dcld(m,j,l,k).ge.0.00001 .and. IPSL5B_3Dcld(m,j,l,k).ge. CldRange(i) .and. IPSL5B_3Dcld(m,j,l,k).lt.CldRange(i)+5) then
		IPSL5B_Shcu_threeDfrac_Histo(m,i,j) = IPSL5B_Shcu_threeDfrac_Histo(m,i,j)+IPSL5B_3Dcld(m,j,l,k)
		IPSL5B_Shcu_ind_3Dfrac(m,i,j) = IPSL5B_Shcu_ind_3Dfrac(m,i,j) + 1
	   end if
	   end if
	; --- stratocumulus ---
	   if (.not.ismissing(IPSL5B_lts(m,l,k)) .and. IPSL5B_lts(m,l,k).ge.18.55) then
	   if (.not.ismissing(IPSL5B_3Dcld(m,j,l,k)) .and. IPSL5B_3Dcld(m,j,l,k).ge.0.00001 .and. IPSL5B_3Dcld(m,j,l,k).ge. CldRange(i) .and. IPSL5B_3Dcld(m,j,l,k).lt.CldRange(i)+5) then
		IPSL5B_Strat_threeDfrac_Histo(m,i,j)= IPSL5B_Strat_threeDfrac_Histo(m,i,j)+IPSL5B_3Dcld(m,j,l,k)
		IPSL5B_Strat_ind_3Dfrac(m,i,j)= IPSL5B_Strat_ind_3Dfrac(m,i,j) + 1
	   end if       
	   end if
	end do ; j
	end do ; i
	;----------
	end if
	end if
   end do ;k
   end do ;l
   end do ;m


;********** 3D Only Low Cloud Cover **********
;------------- Shallow Cumulus -------------
   IPSL5B_Shcu_cnt_3Dfrac=where(IPSL5B_Shcu_ind_3Dfrac.eq.0,1.e+20,IPSL5B_Shcu_ind_3Dfrac)
   IPSL5B_Shcu_dim_cnt_3Dfrac=dim_sum_Wrap(IPSL5B_Shcu_cnt_3Dfrac(time|:,alt40|:,cldfra|:))
      printVarSummary(IPSL5B_Shcu_dim_cnt_3Dfrac)

   IPSL5B_Shcu_Normalize=new((/ntime,ncld,nalt/),float)
     IPSL5B_Shcu_Normalize@_FillValue=1e+20
     IPSL5B_Shcu_Normalize!0  = "time"             ; assign dimension names
     IPSL5B_Shcu_Normalize!1  = "cldfra"           
     IPSL5B_Shcu_Normalize!2  = "height"
     IPSL5B_Shcu_Normalize&cldfra = CldRange
     IPSL5B_Shcu_Normalize&height =  IPSL5B_alt
 
   do m=0,(ntime-1)
   do j=0,(nalt-1)
   do i=0,(ncld-1)
     IPSL5B_Shcu_Normalize(m,i,j)=IPSL5B_Shcu_cnt_3Dfrac(m,i,j)/IPSL5B_Shcu_dim_cnt_3Dfrac(m,j)
   end do
   end do
   end do
 
  printVarSummary(IPSL5B_Shcu_Normalize)


;------------- Stratocumulus ---------------
   IPSL5B_Strat_cnt_3Dfrac=where(IPSL5B_Strat_ind_3Dfrac.eq.0,1.e+20,IPSL5B_Strat_ind_3Dfrac)
   IPSL5B_Strat_dim_cnt_3Dfrac=dim_sum_Wrap(IPSL5B_Strat_cnt_3Dfrac(time|:,alt40|:,cldfra|:))
      printVarSummary(IPSL5B_Strat_dim_cnt_3Dfrac)

   IPSL5B_Strat_Normalize=new((/ntime,ncld,nalt/),float)
     IPSL5B_Strat_Normalize@_FillValue=1e+20
     IPSL5B_Strat_Normalize!0  = "time"             ; assign dimension names
     IPSL5B_Strat_Normalize!1  = "cldfra"           
     IPSL5B_Strat_Normalize!2  = "height"
     IPSL5B_Strat_Normalize&cldfra = CldRange
     IPSL5B_Strat_Normalize&height =  IPSL5B_alt
 
   do m=0,(ntime-1)
   do j=0,(nalt-1)
   do i=0,(ncld-1)
     IPSL5B_Strat_Normalize(m,i,j)=IPSL5B_Strat_cnt_3Dfrac(m,i,j)/IPSL5B_Strat_dim_cnt_3Dfrac(m,j)
   end do
   end do
   end do
 
  printVarSummary(IPSL5B_Strat_Normalize)




;===============================================================
;===============================================================
; SATELLITE OBSERVATIONS
;===============================================================
;===============================================================
; Extracting variables for 2008 from original AMIP files. 
; --------------------------------------------------------------
   directoryD = "/data/cnlmd/Satellites_v20110323/GOCCP_Monthly/" ; Metric 3: GOCCP data
   directoryE = "/data/cnlmd/Satellites_v20110323/ERA_interim/"   ; Metric 3: ERA-Interim data

     extract10=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryD+"MapLowMidHigh330m_2008_avg_CFMIP2_sat_2.1.nc "+directoryC+"MapLowMidHigh330m_avg_CFMIP2_sat_2.1_Tropic2008.nc")
     extract11 = systemfunc ("cdo mergetime "+directoryD+"3D_CloudFraction330m_2008??_avg_CFMIP2_sat_2.1.nc "+directoryC+"3D_CloudFraction330m_2008.nc")

     extract12=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryE+"ps2d_erai_200606-200812_S15.nc "+directoryC+"ps2d_erai_S15_Tropic2008.nc")
     extract13=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryE+"t2m_erai_200606-200812.nc "+directoryC+"t2m_erai_S15_Tropic2008.nc")
     extract14=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,700 -selyear,2008 "+directoryE+"t3d_erai_200606-200812_S15.nc "+directoryC+"t3d700_erai_S15_Tropic2008.nc")
     extract15=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,500 -selyear,2008 "+directoryE+"w3d_erai_200606-200812_S15.nc "+directoryC+"w3d500_erai_S15_Tropic2008.nc")
     extract16=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,700 -selyear,2008 "+directoryE+"w3d_erai_200606-200812_S15.nc "+directoryC+"w3d700_erai_S15_Tropic2008.nc")

; --------------------------------------------------------------

      file301 = "MapLowMidHigh330m_avg_CFMIP2_sat_2.1_Tropic2008.nc"	  ; Metric 4
   peach = addfile(directoryC+file301,"r")
      printVarSummary(peach)   ; overview of var

     file401 = "3D_CloudFraction330m_200801_avg_CFMIP2_sat_2.1.nc"
   kiwi  = addfile(directoryD+file401,"r")
     file402 = systemfunc ("ls "+directoryD+"3D_CloudFraction330m_2008??_avg_CFMIP2_sat_2.1.nc") ; file paths
   banana    = addfiles (file402, "r")   
        ListSetType (banana, "cat")

     file501 = "w3d500_erai_S15_Tropic2008.nc"
     file502 = "w3d700_erai_S15_Tropic2008.nc"
     file503 = "t3d700_erai_S15_Tropic2008.nc"
     file504 = "t2m_erai_S15_Tropic2008.nc"
     file505 = "ps2d_erai_S15_Tropic2008.nc"
   grape    = addfile(directoryC+file501,"r")
   appricot = addfile(directoryC+file502,"r")
   cherry   = addfile(directoryC+file503,"r")
   lime     = addfile(directoryC+file504,"r")
   orange   = addfile(directoryC+file505,"r")

; -------------------------------------------------------------
; import variable: reorder the data's longitude coordinates
; -------------------------------------------------------------
   Satellite_lat=peach->latitude
   Satellite_lon=peach->longitude
       ilon=dimsizes(peach->longitude(:))
       jlat=dimsizes(peach->latitude(:))

   Satellite_time=peach->time(:)
      ntime = dimsizes(Satellite_time)

   Satellite_Highcld_in=peach->clhcalipso(:,:,:)
     Satellite_Highcld_in@_FillValue = -9999
     Satellite_High=Satellite_Highcld_in*100
     Satellite_High!0="time"
     Satellite_High!1="latitude"
     Satellite_High!2="longitude"
     Satellite_High&latitude=peach->latitude(:)
     Satellite_High&longitude=peach->longitude(:)
     Satellite_High&latitude@units="degrees_north"
     Satellite_High&longitude@units="degrees_east"
     printVarSummary(Satellite_High)

   Satellite_Midcld_in=peach->clmcalipso(:,:,:)
     Satellite_Midcld_in@_FillValue = -9999
     Satellite_Mid=Satellite_Midcld_in*100
     Satellite_Mid!0="time"
     Satellite_Mid!1="latitude"
     Satellite_Mid!2="longitude"
     Satellite_Mid&latitude=peach->latitude(:)
     Satellite_Mid&longitude=peach->longitude(:)
     Satellite_Mid&latitude@units="degrees_north"
     Satellite_Mid&longitude@units="degrees_east"
     printVarSummary(Satellite_Mid)

   Satellite_Lowcld_in=peach->cllcalipso(:,:,:)
     Satellite_Lowcld_in@_FillValue = -9999
     Satellite_Low=Satellite_Lowcld_in*100
     Satellite_Low!0="time"
     Satellite_Low!1="latitude"
     Satellite_Low!2="longitude"
     Satellite_Low&latitude=peach->latitude(:)
     Satellite_Low&longitude=peach->longitude(:)
     Satellite_Low&latitude@units="degrees_north"
     Satellite_Low&longitude@units="degrees_east"
     printVarSummary(Satellite_Low)

   Satellite_3Dcld_in=banana[:]->clcalipso(:,0:8,30:59,:) 
     Satellite_3Dcld_in@_FillValue = -9999
     printVarSummary(Satellite_3Dcld_in)
     ;Note: cdo sellonlatbox yeilds "Unsupported grid type", so we select 29:60 (30N/30S) manually
     Satellite_3Dcld=Satellite_3Dcld_in*100
     Satellite_3Dcld!0="time"
     Satellite_3Dcld!1="altitude"
     Satellite_3Dcld!2="latitude"
     Satellite_3Dcld!3="longitude"
     Satellite_3Dcld&latitude=peach->latitude(:)
     Satellite_3Dcld&longitude=peach->longitude(:)
     Satellite_3Dcld&latitude@units="degrees_north"
     Satellite_3Dcld&longitude@units="degrees_east"
   printVarSummary(Satellite_3Dcld)
   printMinMax(Satellite_3Dcld,True)

   Satellite_alt=kiwi->alt_mid(0:8)
	Satellite_alt!0= "alt40"
      print(Satellite_alt)
      nalt=dimsizes(Satellite_alt)

; -------------------------------------------------------------
; ERA-Interim have different lat lon co-ordinates than GOCCP
; -------------------------------------------------------------
   ERA_omega500_inA=short2flt(grape->w(:,0,::-1,:))
   ERA_omega500=f2fsh_Wrap(ERA_omega500_inA,(/jlat,ilon/))
        ERA_omega500@_FillValue=-32767
        ERA_omega500!1="lat"
        ERA_omega500!2="lon"
        ERA_omega500&lat=peach->latitude(:)
        ERA_omega500&lon=peach->longitude(:) 
        ERA_omega500&lat@units="degrees_north"
        ERA_omega500&lon@units="degrees_east"
	printVarSummary(ERA_omega500)

   ERA_omega700_inA=short2flt(grape->w(:,0,::-1,:))
   ERA_omega700=f2fsh_Wrap(ERA_omega700_inA,(/jlat,ilon/))
        ERA_omega700@_FillValue=-32767
        ERA_omega700!1="lat"
        ERA_omega700!2="lon"
        ERA_omega700&lat=peach->latitude(:)
        ERA_omega700&lon=peach->longitude(:) 
        ERA_omega700&lat@units="degrees_north"
        ERA_omega700&lon@units="degrees_east"
        ;printVarSummary(ERA_omega700)

   ERA_temp700_inA=short2flt(cherry->t(:,0,::-1,:))
   ERA_temp700=f2fsh_Wrap(ERA_temp700_inA,(/jlat,ilon/))
        ERA_temp700@_FillValue=-32767
        ERA_temp700!1="lat"
        ERA_temp700!2="lon"
        ERA_temp700&lat=peach->latitude(:)
        ERA_temp700&lon=peach->longitude(:) 
        ERA_temp700&lat@units="degrees_north"
        ERA_temp700&lon@units="degrees_east"
        ;printVarSummary(ERA_temp700)

   ERA_surftemp_inA=short2flt(lime->t2m(:,::-1,:))
   ERA_surftemp=f2fsh_Wrap(ERA_surftemp_inA,(/jlat,ilon/))
        ERA_surftemp@_FillValue=-32767
        ERA_surftemp!1="lat"
        ERA_surftemp!2="lon"
        ERA_surftemp&lat=peach->latitude(:)
        ERA_surftemp&lon=peach->longitude(:) 
        ERA_surftemp&lat@units="degrees_north"
        ERA_surftemp&lon@units="degrees_east"
        ;printVarSummary(ERA_surftemp)

   ERA_surfpress_inA=short2flt(orange->sp(:,::-1,:))
   ERA_surfpress=f2fsh_Wrap(ERA_surfpress_inA,(/jlat,ilon/))
        ERA_surfpress@_FillValue=-32767
        ERA_surfpress!1="lat"
        ERA_surfpress!2="lon"
        ERA_surfpress&lat=peach->latitude(:)
        ERA_surfpress&lon=peach->longitude(:) 
        ERA_surfpress&lat@units="degrees_north"
        ERA_surfpress&lon@units="degrees_east"
        ;printVarSummary(ERA_surfpress)

; -------------------------------------------------------------
; Define Variables for Calculations
; -------------------------------------------------------------
   ;----- 1. Define Variables for Large-scale Calculations -----

   OBS_tpot700=new((/ntime,jlat,ilon/),float)
   OBS_tpotsf=new((/ntime,jlat,ilon/),float)
   OBS_lts=new((/ntime,jlat,ilon/),float)

   ;----- 2. Define Variables for 3D-Cloud Calculations -----

   OBS_Shcu_threeDcld_Histo=new((/ntime,ncld,nalt/),float)
     OBS_Shcu_threeDcld_Histo!0      = "time"
     OBS_Shcu_threeDcld_Histo!1      = "cldfra"             ; assign dimension names
     OBS_Shcu_threeDcld_Histo!2      = "height"
     OBS_Shcu_threeDcld_Histo(:,:,:)=0

   OBS_Strat_threeDcld_Histo=new((/ntime,ncld,nalt/),float)
     OBS_Strat_threeDcld_Histo!0      = "time"
     OBS_Strat_threeDcld_Histo!1      = "cldfra"             ; assign dimension names
     OBS_Strat_threeDcld_Histo!2      = "height"
     OBS_Strat_threeDcld_Histo(:,:,:)=0

   OBS_Shcu_cnt_3D=new((/ntime,ncld,nalt/),float)
     OBS_Shcu_cnt_3D(:,:,:)=0
     OBS_Shcu_cnt_3D!0  = "time"
     OBS_Shcu_cnt_3D!1  = "cldfra"             ; assign dimension names
     OBS_Shcu_cnt_3D!2  = "height"
     OBS_Shcu_cnt_3D@_FillValue=-9999
   OBS_Shcu_ind_3D=new((/ntime,ncld,nalt/),integer)
     OBS_Shcu_ind_3D(:,:,:)=0

   OBS_Strat_cnt_3D=new((/ntime,ncld,nalt/),float)
     OBS_Strat_cnt_3D(:,:,:)=0
     OBS_Strat_cnt_3D!0  = "time"
     OBS_Strat_cnt_3D!1  = "cldfra"             ; assign dimension names
     OBS_Strat_cnt_3D!2  = "height"
     OBS_Strat_cnt_3D@_FillValue=-9999
   OBS_Strat_ind_3D=new((/ntime,ncld,nalt/),integer)
     OBS_Strat_ind_3D(:,:,:)=0


;===================================================================
; BEGIN CALCULATIONS
;===================================================================
 do m=0,(ntime-1)
   do l=0,(jlat-1)
   do k=0,(ilon-1)
	OBS_tpot700(m,l,k)= ERA_temp700(m,l,k)*(1000./700.)^0.286
	OBS_tpotsf(m,l,k)= ERA_surftemp(m,l,k)*(1000./(ERA_surfpress(m,l,k)/100.))^0.286  
	OBS_lts(m,l,k)= OBS_tpot700(m,l,k)-OBS_tpotsf(m,l,k)
        ;*** ONLY LOW: High and Mid < 5% ***
 	if (.not. ismissing(Satellite_Low(m,l,k)) .and. .not. ismissing(Satellite_Mid(m,l,k)) .and. .not. ismissing(Satellite_High(m,l,k))) then
	if (Satellite_Low(m,l,k).gt.0.0001 .and. Satellite_Mid(m,l,k).le.5 .and. Satellite_High(m,l,k).le.5) then 
        ;*** SEPERATE: Shallow Cu and Strato Cu ***
	if ((ERA_omega700(m,l,k)*864.).ge.10. .and. (ERA_omega500(m,l,k)*864.).ge.10.) then   
	do i=0,(ncld-1)
	do j=0,(nalt-1)
        ; --- shallow cumulus ---
	if (OBS_lts(m,l,k).lt.18.55) then
	   if (.not.ismissing(Satellite_3Dcld(m,j,l,k)) .and. Satellite_3Dcld(m,j,l,k).gt.0.0001 .and. Satellite_3Dcld(m,j,l,k).ge. CldRange(i) .and. Satellite_3Dcld(m,j,l,k).lt.CldRange(i)+5) then
		OBS_Shcu_threeDcld_Histo(m,i,j) = OBS_Shcu_threeDcld_Histo(m,i,j)+Satellite_3Dcld(m,j,l,k)
		OBS_Shcu_ind_3D(m,i,j) = OBS_Shcu_ind_3D(m,i,j) + 1
	   end if          
	end if
        ; --- stratocumulus ---
        if (OBS_lts(m,l,k).ge.18.55) then
	   if (.not.ismissing(Satellite_3Dcld(m,j,l,k)) .and. Satellite_3Dcld(m,j,l,k).gt.0.0001 .and. Satellite_3Dcld(m,j,l,k).ge. CldRange(i) .and. Satellite_3Dcld(m,j,l,k).lt.CldRange(i)+5) then
		OBS_Strat_threeDcld_Histo(m,i,j)= OBS_Strat_threeDcld_Histo(m,i,j)+Satellite_3Dcld(m,j,l,k)
		OBS_Strat_ind_3D(m,i,j)= OBS_Strat_ind_3D(m,i,j) + 1
	   end if           
	end if
	;----------
	end do ;j
	end do ;i
	end if
        end if 
	end if
   end do ;k
   end do ;l
   end do ;m


;********** 3D Only Low Cloud Cover **********
;------------- Shallow Cumulus -------------
   OBS_Shcu_cnt_3D=where(OBS_Shcu_ind_3D.eq.0,-9999,OBS_Shcu_ind_3D)
   OBS_Shcu_dim_cnt_3D=dim_sum_Wrap(OBS_Shcu_cnt_3D(time|:,height|:,cldfra|:))
     ;print(OBS_Shcu_dim_cnt_3D)

   OBS_Shcu_Normalize=new((/ntime,ncld,nalt/),float)
     OBS_Shcu_Normalize@_FillValue=-9999
     OBS_Shcu_Normalize!0  = "time"             ; assign dimension names
     OBS_Shcu_Normalize!1  = "cldfra"           
     OBS_Shcu_Normalize!2  = "height"
     OBS_Shcu_Normalize&cldfra = CldRange
     OBS_Shcu_Normalize&height = Satellite_alt
 
   do m=0,(ntime-1)
   do j=0,(nalt-1)
   do i=0,(ncld-1)
     OBS_Shcu_Normalize(m,i,j)=OBS_Shcu_cnt_3D(m,i,j)/OBS_Shcu_dim_cnt_3D(m,j)
   end do
   end do
   end do
 
   printVarSummary(OBS_Shcu_Normalize)
   printMinMax(OBS_Shcu_Normalize,True)

;------------- Stratocumulus ---------------
   OBS_Strat_cnt_3D=where(OBS_Strat_ind_3D.eq.0,-9999,OBS_Strat_ind_3D)
   OBS_Strat_dim_cnt_3D=dim_sum_Wrap(OBS_Strat_cnt_3D(time|:,height|:,cldfra|:))
      ;print(OBS_Strat_dim_cnt_3D)

   OBS_Strat_Normalize=new((/ntime,ncld,nalt/),float)
     OBS_Strat_Normalize@_FillValue=-9999
     OBS_Strat_Normalize!0  = "time"             ; assign dimension names
     OBS_Strat_Normalize!1  = "cldfra"           
     OBS_Strat_Normalize!2  = "height"
     OBS_Strat_Normalize&cldfra = CldRange
     OBS_Strat_Normalize&height =  Satellite_alt
 
   do m=0,(ntime-1)
   do j=0,(nalt-1)
   do i=0,(ncld-1)
     OBS_Strat_Normalize(m,i,j)=OBS_Strat_cnt_3D(m,i,j)/OBS_Strat_dim_cnt_3D(m,j)
   end do
   end do
   end do
 
   printVarSummary(OBS_Strat_Normalize)
   printMinMax(OBS_Strat_Normalize,True)


;======================================================================
; BEGIN PANEL PLOT 
;======================================================================
; SHALLOW CUMULUS
;-------------------------------------------
; Satellite: CALIPSO 3D Cloud Fraction Contour
;-------------------------------------------
  res001                      = True               ; enable plot options
  res001@gsnFrame             = False              ; advance frame
  res001@gsnDraw              = False               ; draw

  res001@cnFillOn             = True               ; Fill contours
  res001@cnFillMode           = "RasterFill"       ; Blocks vs. Smooth
  res001@cnLinesOn            = False              ; Contour lines off
  res001@lbLabelBarOn	      = False
  res001@gsnSpreadColors      = True               ; spread colors around 0
  res001@gsnSpreadColorStart  = 0                  ; start at color XXX in colormap
  res001@gsnSpreadColorEnd    = -2                  ; start at color XXX in colormap
  ;res001@tiXAxisString        = "Low Cloud Fraction"  
  res001@tiYAxisString        = "Height [km]"
  res001@cnLabelBarEndStyle   = "ExcludeOuterBoxes"
  res001@cnLevelSelectionMode = "ExplicitLevels"    ; set explicit contour levels
  res001@cnLevels = (/0.001,0.005,0.01,0.05,0.1,0.3,0.5,0.7,0.9/)  ; set levels

  res001@tmXBMode       = "Explicit"
  res001@tmXBValues 	= (/7.5,17.5,27.5,37.5,47.5,57.5,67.5,77.5,87.5,97.5/)
  res001@tmXBLabels 	= (/"","0.2","","0.4","","0.6","","0.8","","1"/)
  res001@tmYLMode       = "Explicit"
  res001@tmYLValues 	= (/0.48,0.96,1.44,1.92,2.40,2.88,3.36,3.84/)
  res001@tmYLLabels 	= (/"","0.96","","1.92","","2.88","","3.84"/)

  res001@lbLabelBarOn        = False           ; turn off individual cb's

  res001@tmXTBorderOn      = False ; kills border line (x-axis top)
  res001@tmYRBorderOn      = False ; kills border line (y-axis right)
  res001@tmXTOn            = False ; kills tick marks (x-axis top)
  res001@tmYROn            = False ; kills tick marks (y-axis right)

  res001@tiMainString =  "CALIPSO shallow cumulus"  ;Main title

  res001@tiMainFont           =21		; hevelica
  res001@tiXAxisFont          =21
  res001@tiYAxisFont	      =21
  res001@tmXBLabelFont        =21
  res001@tmYLLabelFont        =21
  res001@tmXBLabelFontHeightF  = 0.02
  res001@tmYLLabelFontHeightF  = 0.02

; this controls the size and location of the plot
  res001@vpXF            = 0.15 ; position on the paper
  res001@vpYF            = 0.55 ; position on the paper
  res001@vpWidthF        = 0.4 ; width of figure
  res001@vpHeightF       = 0.3 ; height of figure

  plot(0) = gsn_csm_contour(wks,dim_avg_Wrap(OBS_Shcu_Normalize(height|:,cldfra|:,time|:)),res001)

;-------------------------------------------
  delete(res001)
;-------------------------------------------
; IPSL5B: Shallow Cumulus 3D Cloud Fraction Contour
;-------------------------------------------
  res001                      = True               ; enable plot options
  res001@gsnFrame             = False              ; advance frame
  res001@gsnDraw              = False               ; draw

  res001@cnFillOn             = True               ; Fill contours
  res001@cnFillMode           = "RasterFill"       ; Blocks vs. Smooth
  res001@cnLinesOn            = False              ; Contour lines off
  res001@lbLabelBarOn	      = False
  res001@gsnSpreadColors      = True               ; spread colors around 0
  res001@gsnSpreadColorStart  = 0                  ; start at color XXX in colormap
  res001@gsnSpreadColorEnd    = -2                  ; start at color XXX in colormap
  ;res001@tiXAxisString        = "Low Cloud Fraction"  
  res001@tiYAxisString        = "Height [km]"
  res001@cnLabelBarEndStyle   = "ExcludeOuterBoxes"
  res001@cnLevelSelectionMode = "ExplicitLevels"    ; set explicit contour levels
  res001@cnLevels = (/0.001,0.005,0.01,0.05,0.1,0.3,0.5,0.7,0.9/)  ; set levels

  res001@tmXBMode       = "Explicit"
  res001@tmXBValues 	= (/7.5,17.5,27.5,37.5,47.5,57.5,67.5,77.5,87.5,97.5/)
  res001@tmXBLabels 	= (/"","0.2","","0.4","","0.6","","0.8","","1"/)
  res001@tmYLMode       = "Explicit"
  res001@tmYLValues 	= (/480,960,1440,1920,2400,2880,3360,3840/)
  res001@tmYLLabels 	= (/"","0.96","","1.92","","2.88","","3.84"/)

  res001@lbLabelBarOn        = False           ; turn off individual cb's

  res001@tmXTBorderOn      = False ; kills border line (x-axis top)
  res001@tmYRBorderOn      = False ; kills border line (y-axis right)
  res001@tmXTOn            = False ; kills tick marks (x-axis top)
  res001@tmYROn            = False ; kills tick marks (y-axis right)

  res001@tiMainString = "IPSL5B Shallow Cumulus"  ;Main title

  res001@tiMainFont           =21		; hevelica
  res001@tiXAxisFont          =21
  res001@tiYAxisFont	      =21
  res001@tmXBLabelFont        =21
  res001@tmYLLabelFont        =21
  res001@tmXBLabelFontHeightF  = 0.02
  res001@tmYLLabelFontHeightF  = 0.02

; this controls the size and location of the plot
  res001@vpXF            = 0.15 ; position on the paper
  res001@vpYF            = 0.55 ; position on the paper
  res001@vpWidthF        = 0.4 ; width of figure
  res001@vpHeightF       = 0.3 ; height of figure

  plot(1) = gsn_csm_contour(wks,dim_avg_Wrap(IPSL5B_Shcu_Normalize(height|:,cldfra|0:20,time|:)),res001)


;-------------------------------------------
;-------------------------------------------
; STRATOCUMULUS
;-------------------------------------------
; Satellite: CALIPSO stratocumulus 3D Cloud Fraction Contour
;-------------------------------------------
  res002                      = True               ; enable plot options
  res002@gsnFrame             = False              ; advance frame
  res002@gsnDraw              = False               ; draw

  res002@cnFillOn             = True               ; Fill contours
  res002@cnFillMode           = "RasterFill"       ; Blocks vs. Smooth
  res002@cnLinesOn            = False              ; Contour lines off
  res002@lbLabelBarOn	      = False
  res002@gsnSpreadColors      = True               ; spread colors around 0
  res002@gsnSpreadColorStart  = 0                  ; start at color XXX in colormap
  res002@gsnSpreadColorEnd    = -2                  ; start at color XXX in colormap
  res002@tiXAxisString        = "Low Cloud Fraction"  
  res002@tiYAxisString        = "Height [km]"
  res002@cnLabelBarEndStyle   = "ExcludeOuterBoxes"
  res002@cnLevelSelectionMode = "ExplicitLevels"    ; set explicit contour levels
  res002@cnLevels = (/0.001,0.005,0.01,0.05,0.1,0.3,0.5,0.7,0.9/)  ; set levels

  res002@tmXBMode       = "Explicit"
  res002@tmXBValues 	= (/7.5,17.5,27.5,37.5,47.5,57.5,67.5,77.5,87.5,97.5/)
  res002@tmXBLabels 	= (/"","0.2","","0.4","","0.6","","0.8","","1"/)
  res002@tmYLMode       = "Explicit"
  res002@tmYLValues 	= (/0.48,0.96,1.44,1.92,2.40,2.88,3.36,3.84/)
  res002@tmYLLabels 	= (/"","0.96","","1.92","","2.88","","3.84"/)

  res002@lbLabelBarOn        = False           ; turn off individual cb's

  res002@tmXTBorderOn      = False ; kills border line (x-axis top)
  res002@tmYRBorderOn      = False ; kills border line (y-axis right)
  res002@tmXTOn            = False ; kills tick marks (x-axis top)
  res002@tmYROn            = False ; kills tick marks (y-axis right)

  res002@tiMainString = "CALIPSO stratocumulus"  ;Main title

  res002@tiMainFont           =21		; hevelica
  res002@tiXAxisFont          =21
  res002@tiYAxisFont	      =21
  res002@tmXBLabelFont        =21
  res002@tmYLLabelFont        =21
  res002@tmXBLabelFontHeightF  = 0.02
  res002@tmYLLabelFontHeightF  = 0.02

; this controls the size and location of the plot
  res002@vpXF            = 0.5 ; position on the paper
  res002@vpYF            = 0.55 ; position on the paper
  res002@vpWidthF        = 0.4 ; width of figure
  res002@vpHeightF       = 0.3 ; height of figure

  plot(2) = gsn_csm_contour(wks,dim_avg_Wrap(OBS_Strat_Normalize(height|:,cldfra|:,time|:)),res002)


;-------------------------------------------
 delete(res002)
;-------------------------------------------
; IPSL5B: stratocumulus 3D Cloud Fraction Contour
;-------------------------------------------
  res002                      = True               ; enable plot options
  res002@gsnFrame             = False              ; advance frame
  res002@gsnDraw              = False               ; draw

  res002@cnFillOn             = True               ; Fill contours
  res002@cnFillMode           = "RasterFill"       ; Blocks vs. Smooth
  res002@cnLinesOn            = False              ; Contour lines 
  res002@lbLabelBarOn	      = False
  res002@gsnSpreadColors      = True               ; spread colors around 0
  res002@gsnSpreadColorStart  = 0                  ; start at color XXX in colormap
  res002@gsnSpreadColorEnd    = -2                  ; start at color XXX in colormap
  res002@tiXAxisString        = "Low Cloud Fraction"  
  res002@tiYAxisString        = "Height [km]"
  res002@cnLabelBarEndStyle   = "ExcludeOuterBoxes"
  res002@cnLevelSelectionMode = "ExplicitLevels"    ; set explicit contour levels
  res002@cnLevels = (/0.001,0.005,0.01,0.05,0.1,0.3,0.5,0.7,0.9/)  ; set levels

  res002@tmXBMode       = "Explicit"
  res002@tmXBValues 	= (/7.5,17.5,27.5,37.5,47.5,57.5,67.5,77.5,87.5,97.5/)
  res002@tmXBLabels 	= (/"","0.2","","0.4","","0.6","","0.8","","1"/)
  res002@tmYLMode       = "Explicit"
  res002@tmYLValues 	= (/480,960,1440,1920,2400,2880,3360,3840/)
  res002@tmYLLabels 	= (/"","0.96","","1.92","","2.88","","3.84"/)

  res002@lbLabelBarOn        = False           ; turn off individual cb's

  res002@tmXTBorderOn      = False ; kills border line (x-axis top)
  res002@tmYRBorderOn      = False ; kills border line (y-axis right)
  res002@tmXTOn            = False ; kills tick marks (x-axis top)
  res002@tmYROn            = False ; kills tick marks (y-axis right)

  res002@tiMainString = "IPSL5B Stratocumulus"  ;Main title

  res002@tiMainFont           =21		; hevelica
  res002@tiXAxisFont          =21
  res002@tiYAxisFont	      =21
  res002@tmXBLabelFont        =21
  res002@tmYLLabelFont        =21
  res002@tmXBLabelFontHeightF  = 0.02
  res002@tmYLLabelFontHeightF  = 0.02

; this controls the size and location of the plot
  res002@vpXF            = 0.15 ; position on the paper
  res002@vpYF            = 0.55 ; position on the paper
  res002@vpWidthF        = 0.4 ; width of figure
  res002@vpHeightF       = 0.3 ; height of figure

  plot(3) = gsn_csm_contour(wks,dim_avg_Wrap(IPSL5B_Strat_Normalize(height|:,cldfra|0:20,time|:)),res002)


;======================================================================
; PANEL PLOT 
;======================================================================
  res_Panel                     = True      ; modify the panel plot
  res_Panel@gsnMaximize         = True      ; maximize plot 

  res_Panel@gsnPanelYWhiteSpacePercent = 3

  res_Panel@txString   = "30N to 30S 2008 3DLowCld(monmean)"
  res_Panel@gsnPanelLabelBar    = True                ; add common colorbar
  res_Panel@lbLabelFontHeightF  = 0.007               ; make labels smaller

  res_Panel@lbAutoManage                = False           ; manual   
              

;======================================================================
  gsn_panel(wks,plot,(/2,2/),res_Panel)             ; now draw as one plot









end
