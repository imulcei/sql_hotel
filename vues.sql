create or replace view hotel_station as select ho.id as hotel_id, ho.station_id, ho.name as "hotel name", ho.category, ho.address, ho.city, st.name as "station name", st.altitude from hotel ho join station st on ho.station_id = st.id;
select * from hotel_station;
drop view if exists hotel_station;

create or replace view client_booking as select cl.first_name, cl.last_name, ro.number, ho.name as "hotel", st.name as "station", bo.stay_start_date, bo.stay_end_date, bo.price, bo.deposit from client cl join booking bo on cl.id = bo.client_id join room ro on ro.id = bo.room_id join hotel ho on ho.id = ro.hotel_id join station st on st.id = ho.station_id;
select * from client_booking;

create or replace view room_list as select ro.number as "room number", ho.name as "hotel", st.name as "station" from room ro join hotel ho on ho.id = ro.hotel_id join station st on st.id = ho.station_id;
select * from room_list order by "station", "hotel";

create or replace view hotel_booking as select cl.first_name, cl.last_name, ho.name from client cl join booking bo on bo.client_id = cl.id join room ro on ro.id = bo.room_id join hotel ho on ho.id = ro.hotel_id;
select * from hotel_booking order by first_name, last_name;

create role application_admin
login
password 'soleil12345';

grant select, insert, update, delete
on hotel, room, client, booking
to application_admin;

create role application_client
login
password 'nuage6789';

grant select
on room_list
to application_client;

--- requête en étant connecté en tant que application_admin
select * from hotel; --- access denied
select * from station;

--- requête en étant connecté en tant que application_client
select * from hotel; --- access denied
select * from station; --- access denied
select * from room_list;