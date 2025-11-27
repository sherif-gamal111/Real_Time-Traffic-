------------------------------
--        date view         --
------------------------------

create view gold.dim_date
as
select 
	Date_id,
	count_date,
	day,
	month,
	year
from silver.Date

------------------------------
--      location view       --
------------------------------

create view gold.dim_location
as
select 
	r.region_id,
	r.region_name,
	r.region_ons_code,
	l.Location_id,
	l.easting,
	l.northing,
	l.latitude,
	l.longitude,
	ro.Road_id,
	ro.road_name,
	ro.road_category,
	ro.road_type,
	ro.start_junction_road_name,
	ro.end_junction_road_name,
	ro.link_length_km,
	la.local_authority_id,
	la.local_authority_name,
	la.local_authority_code
from silver.Region r join silver.Location l 
on r.region_id = l.region_id join silver.LocalAuthority la
on l.local_authority_id = la.local_authority_id join silver.Traffic t
on l.Location_id = t.Location_id join silver.Road ro 
on t.Road_id = ro.Road_id;

------------------------------
--       traffic view       --
------------------------------

create view gold.fact_traffic
as
select 
	Traffic_id,
	Road_id,
	region_id,
	Location_id,
	local_authority_id,
	Date_id,
	count_point_id,
	direction_of_travel,
	hour,
	pedal_cycles,
	two_wheeled_motor_vehicles,
	cars,
	buses,
	LGVs,
	HGVs_2_rigid_axle,
	HGVs_3_rigid_axle,
	HGVs_4_rigid_axle,
	HGVs_4_articulated_axle,
	HGVs_5_articulated_axle,
	HGVs_6_articulated_axle,
	all_HGVs,
	all_motor_vehicles
from silver.Traffic;
