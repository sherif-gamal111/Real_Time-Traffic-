create database [Data wharhose pro]
use [Data wharhose pro]

-- Creating Data wharehouse Schema's 

create schema Bronze ; 
go 
create schema Silver ; 
go 
create schema Gold   ; 
go 

--Creating Tables 

drop Table if Exists Traffic; 
Create table Bronze.Traffic (
		count_point_id Int ,
		road_name    varchar(50)   ,
		region_id	   Int, 
		local_authority_id    Int ,
       direction_of_travel  VARCHAR(50),
	   hour int  , 
	   pedal_cycles  int ,
       two_wheeled_motor_vehicles  int, 
	   cars int ,
	   buses int ,
	   LGVs   int ,
       HGVs_2_rigid_axle  int ,
	   HGVs_3_rigid_axle  int ,
	   HGVs_4_rigid_axle  int ,
       HGVs_4_articulated_axle int ,
	   HGVs_5_articulated_axle int ,
       HGVs_6_articulated_axle int ,
	   all_HGVs int ,
	   all_motor_vehicles    int 
);
Drop Table if Exists Region ; 
Create table Bronze.Region ( 
     region_id   Int,
	 region_name  varchar(50),
	 region_ons_code  varchar(20)
);

Drop Table if Exists LocalAuthority ; 
Create table Bronze.LocalAuthority ( 
		local_authority_id  int  ,
		local_authority_name varchar(50)    ,
		local_authority_code  varchar(30)

); 
Drop Table if Exists Location ; 
Create table Bronze.Location ( 
		easting  bigint , 
		northing    bigint ,
		latitude decimal(10,6), 
		longitude decimal(10,6),
		region_id  int ,
       local_authority_id int 
);

Drop Table if Exists Road ; 
Create table Bronze.Road  ( 
		road_name varchar (50),
		road_category varchar (50),
		road_type varchar (50),
		start_junction_road_name  varchar (70),
		end_junction_road_name varchar(80),
		link_length_km decimal(10,6)
		
);
Drop Table if Exists Date ; 
Create table Bronze.Date( 
		count_date  date,
		day  int ,
		month int , 
		year  int 
);
