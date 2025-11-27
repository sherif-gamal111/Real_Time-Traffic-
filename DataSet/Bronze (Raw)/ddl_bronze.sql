/*
#######################################################################################################################################
##									                  Build The Bronze Layer: Data Ingestion				  				         ##
#######################################################################################################################################
*/


------------------------------------
--	  Craeating Traffic table	  --
------------------------------------

if object_id('bronze.Traffic','U') is not null
	drop table bronze.Traffic;
create table bronze.Traffic(
	count_point_id int,
	road_name varchar(30),
	region_id int,
	local_authority_id int,
	direction_of_travel varchar(20), 
	count_date date,
	hour int,
	pedal_cycles int,
	two_wheeled_motor_vehicles int,
	cars int,
	buses int,
	LGVs int,
	HGVs_2_rigid_axle int,
	HGVs_3_rigid_axle int,
	HGVs_4_rigid_axle int,
	HGVs_4_articulated_axle int,
	HGVs_5_articulated_axle int,
	HGVs_6_articulated_axle int,
	all_HGVs int,
	all_motor_vehicles int
)

------------------------------------
--	  Craeating Date table	  --
------------------------------------

if object_id('bronze.Date','U') is not null
	drop table bronze.Date;
create table bronze.Date(
	count_date date,
	day int,
	month int,
	year int
)

------------------------------------
-- Craeating LocalAuthority table --
------------------------------------

if object_id('bronze.LocalAuthority','U') is not null
	drop table bronze.LocalAuthority;
create table bronze.LocalAuthority(
	local_authority_id int,
	local_authority_name varchar(30),
	local_authority_code varchar(50)
)

------------------------------------
--	  Craeating Location table	  --
------------------------------------

if object_id('bronze.Location','U') is not null
	drop table bronze.Location;
create table bronze.Location(
	easting int,
	northing int,
	latitude int,
	longitude int,
	region_id int,
	local_authority_id int
)

------------------------------------
--	  Craeating Region table	  --
------------------------------------

if object_id('bronze.Region','U') is not null
	drop table bronze.Region;
create table bronze.Region(
	region_id int,
	region_name varchar(50),
	region_ons_code varchar(50)
)

------------------------------------
--	    Craeating Road table	  --
------------------------------------

if object_id('bronze.Road','U') is not null
	drop table bronze.Road;
create table bronze.Road(
	road_name varchar(50),
	road_category varchar(30),
	road_type varchar(30),
	start_junction_road_name varchar(70),
	end_junction_road_name varchar(70),
	link_length_km decimal
)
