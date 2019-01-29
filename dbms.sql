create table client_info(
    client_id int,
    client_first_name varchar(50),
    client_last_name varchar(50),
    client_city varchar(50),
    client_country varchar(50),
    client_Dob date);
 select * from  client_info;
alter table client_info add constraint pk primary key(client_id);

create table phone_numbers(
    client_id int,
    client_phone_number numeric);
alter table phone_numbers add constraint pkphonenumbers primary key(client_id,client_phone_number);
alter table phone_numbers add constraint fk foreign key(client_id) references client_info on delete cascade on update cascade;

create table owner(
	owner_id varchar(10),
	owner_first_name varchar(20),	
	owner_last_name varchar(10),
	licence_no varchar(10),
	owner_dob date);

select * from owner;
alter table owner add constraint pkowner primary key(owner_id);

create table boat(
    boat_number varchar(20),
    boat_capacity int,
    owner_id varchar(10),
    service_type varchar(10));
alter table boat add constraint pk2 primary key(boat_number);
alter table boat add constraint boatfk foreign key(owner_id) references owner on delete cascade on update cascade;
alter table boat add constraint boatfk1 foreign key(service_type) references services on delete cascade on update cascade;

create	table services(
    service_type varchar(10),
    wifi_bandwidth varchar(10),
    bar varchar(10),
    cuisine varchar(10),
    rate numeric);
alter table services add constraint pkservice_type primary key(service_type);

create table route(
    route_id varchar(10),
    source varchar(20),
    destination varchar(20));
alter table route add constraint routepk primary key(route_id);

create table sightseeing_spots(
    route_id int,
    spot varchar(20));
alter table route add constraint routefk foreign key(route_id) references route on delete cascade on update cascade;

create table booking_info(
    client_id  int,
    boat_number varchar(20),
    from_date date,
    to_date date,
    route_id varchar(10),
    payment_amount numeric,
    payment_type varchar(20),
    payment_status varchar(10));
alter table booking_info add constraint pk3 primary key(client_id,boat_number,from_date);
alter table booking_info add constraint fk1 foreign key(client_id) references client_info  on delete cascade on update cascade;
alter table booking_info add constraint fk2 foreign key(boat_number) references boat on delete cascade on update cascade;
alter table booking_info add constraint fkbooking_info foreign key(route_id) references route on delete cascade on update cascade;

INSERT INTO client_info VALUES (1,'Sai Satwik','Kuppili','Vizag','India' );
INSERT INTO client_info VALUES ( 2,'Vyshnavi','Ravella','Guntur','India' );
INSERT INTO client_info VALUES ( 3,'Surya Chaitanya','Palepu','Hyderabad','India' );
INSERT INTO client_info VALUES ( 4,'Sai Sarath Chandra','Ganti','Chegai','Pakistan');

select *from client_info;

INSERT INTO boat VALUES ( 'I321',50,2,'Luxury' );
INSERT INTO boat VALUES ( 'I322',25,4,'Luxury' );
INSERT INTO boat VALUES ( 'I323',30,1,'Normal' );
INSERT INTO boat VALUES ( 'I324',150,3,'Deluxe' );
INSERT INTO boat VALUES ( 'I666',100,4,'Luxury' );

select * from boat;

INSERT INTO booking_info VALUES ( 1,'I321','22-OCT-2018','25-OCT-2018',1,0,'Cash','No' );
INSERT INTO booking_info VALUES ( 1,'I324','22-OCT-2018','25-OCT-2018',3,0,'Card','Yes' );
INSERT INTO booking_info VALUES ( 2,'I322','12-MAR-2019','30-MAR-2019',4,0,'Cash','Yes' );
INSERT INTO booking_info VALUES ( 2,'I324','22-OCT-2018','25-OCT-2018',2,0,'Card','Yes' );
INSERT INTO booking_info VALUES ( 3,'I323','01-DEC-2018','05-DEC-2018',1,0,'Cash','Yes' );
INSERT INTO booking_info VALUES ( 3,'I666','14-DEC-2018','20-DEC-2018',3,0,'Cash','Yes' );
INSERT INTO booking_info VALUES ( 4,'I323','01-DEC-2018','05-DEC-2018',1,0,'Cash','Yes' );


select * from booking_info

INSERT INTO phone_numbers VALUES ( 1,7730876239 );
INSERT INTO phone_numbers VALUES ( 1,9494200000 );
INSERT INTO phone_numbers VALUES ( 2,8309240324 );
INSERT INTO phone_numbers VALUES ( 2,7995297281 );
INSERT INTO phone_numbers VALUES ( 3,9963516161 );
INSERT INTO phone_numbers VALUES ( 4,8137069878 );
INSERT INTO phone_numbers VALUES ( 4,9063545753 );

select * from phone_numbers;

INSERT INTO services VALUES ( 'Luxury','100Mbps','NULL','Yes',10000 );
INSERT INTO services VALUES ( 'Deluxe','200Mbps','Yes','Yes',20000 );
INSERT INTO services VALUES ( 'Normal','NULL','NULL','NULL',7500 );
select * from services;

INSERT INTO owner VALUES ( 1,'Trilochan','Balivada','KL123','22-MAR-1976' );
INSERT INTO owner VALUES ( 2,'RamaKrishna','VR','KL345','18-AUG-1979' );
INSERT INTO owner  VALUES ( 3,'HariPrasad','Sonti','KL766','14-NOV-1969' );
INSERT INTO owner VALUES ( 4,'Shabir','Gohal','KL487','12-FEB-1978' );
select * from owner;

INSERT INTO route VALUES ( 1,'Alleppey','Neudmudi' );
INSERT INTO route VALUES ( 2,'Champakkulam','Kainarary' );
INSERT INTO route VALUES ( 3,'Chennamkary','Kainakary' );
INSERT INTO route VALUES ( 4,'Kanjippadom','Pallathruthy' );

INSERT INTO sightseeing_spots VALUES ( 1,'Kumarakom' );
INSERT INTO sightseeing_spots VALUES ( 1,'Thottappally' );
INSERT INTO sightseeing_spots VALUES ( 2,'Alumkadavu' );
INSERT INTO sightseeing_spots VALUES ( 2,'Pallathruthy');
INSERT INTO sightseeing_spots VALUES ( 2,'Kumarakom' );
INSERT INTO sightseeing_spots VALUES ( 3,'Vembabanad' );
INSERT INTO sightseeing_spots VALUES ( 4,'Karumadikuttan' );
INSERT INTO sightseeing_spots VALUES ( 4,'Amrithapuri' );

select route_id,count(*) from booking_info where from_date >= '01-DEC-2018' and from_date <= '30-DEC-2018' group by route_id ;
update client_info set client_dob = '27-NOV-1998' where client_id=1;
update client_info set client_dob = '15-NOV-1998' where client_id=2;
update client_info set client_dob = '12-AUG-1998' where client_id=3; 
update client_info set client_dob = '29-NOV-1998' where client_id=4;

select * from client_info order by client_dob asc;

display the capacity of boat booked by client on a given date;

select client_first_name,client_last_name,boat.boat_number,boat_capacity 
	from (booking_info join boat on booking_info.boat_number=boat.boat_number)
	join client_info using (client_id) 
	where booking_info.from_date='14-DEC-2018';

update booking_info set payment_amount= temp.rate*(DATE_PART('day',booking_info.to_date::date)-DATE_PART('day',booking_info.from_date::date))
	from ((booking_info join boat using (boat_number))
	join services using (service_type)) as temp
	where booking_info.boat_number=temp.boat_number;

select * from booking_info;
select * from client_info where client_first_name like '%Sai%'; 

select client_id,client_first_name from client_info
	where client_id IN 
	(select client_id 
	from ( booking_info join boat using (boat_number) )as temp 
	where temp.service_type NOT IN ('Luxury','Normal'));

select client_id,client_first_name from client_info
	where client_id IN 
	(select client_id 
	from ( booking_info join boat using (boat_number) )as temp 
	where temp.service_type  IN ('Luxury'))
	union 
	select client_id,client_first_name from client_info
	where client_id IN 
	(select client_id 
	from ( booking_info join boat using (boat_number) )as temp 
	where temp.service_type IN ('Normal'));
select client_info.client_first_name 
	from (booking_info join client_info using (client_id)) 
	where from_date between '01-DEC-2018' and '31-DEC-2018'  and  exists (select* from booking_info where route_id = '3' and from_date between '01-DEC-2018' and '31-DEC-2018');

select EXTRACT(MONTH from (select from_date from booking_info where from_date=

