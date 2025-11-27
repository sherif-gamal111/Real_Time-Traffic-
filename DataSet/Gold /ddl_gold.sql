--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--																			Gold Layer - first dimension - date tables 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- joing the customer tables
select 
	Date_id,
	count_date,
	day,
	month,
	year 
from silver.Date

--------------------------------------

-- Note: After joing the tables always check for duplicates introduced by join logic 
	-- By using subquery 
select Date_id, count(*) as duplication from 
	(
		select 
			Date_id,
			count_date,
			day,
			month,
			year
		from silver.Date
	) t 
group by Date_id
having count(*) > 1;

--------------------------------------

-- After checking that there is no duplicates, we can remove the outer query from the subquery 
select 
	Date_id,
	count_date,
	day,
	month,
	year
from silver.Date

--------------------------------------

-- create the object (all the object in the gold layer is virtual one) so we gonna create a view

create view gold.dim_date
as
select 
	Date_id,
	count_date,
	day,
	month,
	year
from silver.Date

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--																			Gold Layer - second dimension - location tables 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

--------------------------------------

select region_id, location_id, count(*) as duplication from
	( 
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
	on t.Road_id = ro.Road_id

	) t
group by region_id, location_id
having count(*) > 1;

--------------------------------------

-- now we gonna create the view

if object_id ('gold.dim_location', 'v') is not null
	 drop table gold.dim_location;

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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--																			Gold Layer - third dimension - traffic tables 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- according to this table has keys, date, and measures so it's perfect to a fact table

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
from silver.Traffic

--------------------------------------

-- check for duplicates introduced by join logic 

select Traffic_id, count(*) as duplication from 
	(
	
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
	from silver.Traffic

	)t
group by Traffic_id 
having count(*) > 1;

--------------------------------------

-- third creating the veiw

if object_id ('gold.fact_traffic', 'v') is not null
	drop table gold.fact_traffic;

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
