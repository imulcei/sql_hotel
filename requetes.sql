INSERT INTO station VALUES (1, 'La Montagne', 2500);
INSERT INTO station VALUES (2, 'Le Sud', 200);
INSERT INTO station VALUES (3, 'La Plage', 10);

INSERT INTO hotel VALUES (1, 1, 'Le Magnifique', 3, 'rue du bas', 'Pralo');
INSERT INTO hotel VALUES (2, 2, 'Hotel du haut', 1, 'rue du haut', 'Pralo');
INSERT INTO hotel VALUES (3, 1, 'Le Narval', 3, 'place de la liberation', 'Vonten');
INSERT INTO hotel VALUES (4, 3, 'Les Pissenlis', 4, 'place du 14 juillet', 'Bretou');
INSERT INTO hotel VALUES (5, 2, 'RR Hotel', 5, 'place du bas', 'Bretou');
INSERT INTO hotel VALUES (6, 2, 'La Brique', 2, 'place du haut', 'Bretou');
INSERT INTO hotel VALUES (7, 3, 'Le Beau Rivage', 3, 'place du centre', 'Toras');

INSERT INTO room VALUES (1, 1, '256', 3, 1);
INSERT INTO room VALUES (2, 1, '102', 2, 2);
INSERT INTO room VALUES (3, 2, '048', 2, 2);
INSERT INTO room VALUES (5, 1, '101', 2, 1);  
INSERT INTO room VALUES (6, 1, '203', 4, 3);  
INSERT INTO room VALUES (7, 2, '015', 1, 1);  
INSERT INTO room VALUES (8, 2, '032', 3, 2);  
INSERT INTO room VALUES (9, 3, '156', 2, 2);  
INSERT INTO room VALUES (10, 4, '201', 4, 3);
INSERT INTO room VALUES (11, 4, '105', 2, 1); 
INSERT INTO room VALUES (12, 5, '301', 2, 2); 
INSERT INTO room VALUES (13, 6, '078', 3, 2); 
INSERT INTO room VALUES (14, 6, '145', 1, 1);
INSERT INTO room VALUES (15, 7, '089', 4, 3); 
INSERT INTO room VALUES (16, 7, '234', 2, 2);
INSERT INTO room VALUES (17, 3, '401', 3, 1); 
INSERT INTO room VALUES (18, 5, '456', 1, 1); 

INSERT INTO client VALUES (1, 'Doe', 'John', '', 'LA');
INSERT INTO client VALUES (2, 'Homme', 'Josh', '', 'Palm Desert');
INSERT INTO client VALUES (3, 'Paul', 'Weller', '', 'Londres');
INSERT INTO client VALUES (4, 'White', 'Jack', '', 'Detroit');
INSERT INTO client VALUES (5, 'Les', 'Claypool', '', 'San Francisco');
INSERT INTO client VALUES (6, 'Chris', 'Squire', '', 'Londres');
INSERT INTO client VALUES (7, 'Ronnie', 'Wood', '', 'Londres');

INSERT INTO booking VALUES (1, 1, 1, '2022-01-10', '2022-07-01', '2022-07-15', 2400, 800);
INSERT INTO booking VALUES (2, 2, 2, '2022-01-10', '2022-07-01', '2022-07-15', 3400, 100);
INSERT INTO booking VALUES (3, 9, 3, '2022-01-10', '2022-07-01', '2022-07-15', 400, 50);
INSERT INTO booking VALUES (4, 13, 4, '2022-01-10', '2022-07-01', '2022-07-15', 7200, 1800);
INSERT INTO booking VALUES (5, 3, 5, '2022-01-10', '2022-07-01', '2022-07-15', 1400, 450);
INSERT INTO booking VALUES (6, 4, 6, '2022-01-10', '2022-07-01', '2022-07-15', 2400, 780);
INSERT INTO booking VALUES (7, 14, 6, '2022-01-10', '2022-07-01', '2022-07-15', 500, 80);
INSERT INTO booking VALUES (8, 18, 7, '2022-01-10', '2022-07-01', '2022-07-15', 40, 0);

select name, city from hotel;
select city from client where last_name = 'White';
select name, altitude from station where altitude < 1000;
select number, capacity from room where capacity > 1;
select first_name, last_name, city from client where city != 'Londres';
select name, city, category from hotel where city = 'Bretou' and category > 3;

select st.name, ho.name, ho.category, ho.city from hotel ho join station st on ho.station_id = st.id order by ho.name;
select ho.name, ho.city, ro.number from hotel ho join room ro on ho.id = ro.hotel_id order by ho.name; 
select ho.name, ho.category, ho.city, ro.number, ro.capacity from hotel ho join room ro on ho.id = ro.hotel_id where ro.capacity > 1 and ho.city = 'Bretou';
select cl.first_name, cl.last_name, ho.name, bo.booking_date from booking bo join client cl on bo.client_id = cl.id join room ro on bo.room_id = ro.id join hotel ho on ro.hotel_id = ho.id;
select st.name, ho.name, ro.number, ro.capacity from room ro join hotel ho on ro.hotel_id = ho.id join station st on st.id = ho.station_id order by st.name, ho.name;
select cl.first_name, cl.last_name, ho.name, bo.stay_start_date, (bo.stay_end_date - bo.stay_start_date) as stay_duration from booking bo join client cl on bo.client_id = cl.id join room ro on bo.room_id = ro.id join hotel ho on ho.id = ro.hotel_id;

select st.name, count(distinct ho.id) as number_of_hotels from hotel ho join station st on ho.station_id = st.id group by st.name, ho.station_id;
select st.name, count(distinct ro.id) as number_of_rooms from room ro join hotel ho on ho.id = ro.hotel_id join station st on st.id = ho.station_id group by st.name;
select st.name, count(distinct ro.id) as number_of_rooms from room ro join hotel ho on ho.id = ro.hotel_id join station st on st.id = ho.station_id where ro.capacity > 1 group by st.name;
select ho.name as hotel_name from hotel ho join room ro on ho.id = ro.hotel_id join booking bo on bo.room_id = ro.id join client cl on cl.id = bo.client_id where cl.last_name = 'Squire';
select st.name, round(avg(bo.stay_end_date - bo.stay_start_date), 2) from booking bo join room ro on bo.room_id = ro.id join hotel ho on ro.hotel_id = ho.id join station st on ho.station_id = st.id group by st.id, st.name;