-- creating database in mysql
create database airlinereservation;

-- to use that database
use airlinereservation;

-- tables in that database
show tables;

-- columns in tables
desc passenger;
desc airline;
desc airport;
desc flight;
desc booking;
desc payment;


-- data in tables
select * from passenger;
select * from airline;
select * from airport;
select * from booking;
select * from flight;
select * from payment;


-- display passenger names and email address 
select passenger_name,email from passenger;

-- find passenger whose name is Rohan Kapoor
select * from passenger where passenger_name='Rohan Kapoor';

-- find flights whose id is greater than 85
select * from flight where flight_id>85;

-- find flights whose id is between 70 and 80
select * from flight where flight_id between 70 and 80;

-- find airport name whose names start with 'C'
select * from airport where airport_name like 'C%';

-- find airline whose name contain 'i'
select * from airline where airline_name like '%i%';

-- find airline whose name contain 'x'
select * from airline where airline_name like '%x%';

-- display passengers whose email is not null
select * from passenger where email is not null;

-- display passengers whose email is null
select * from passenger where email is null;

-- find flights having more than 187 seats
select * from flight where total_seats>187;

-- find flights having more than 180 seats
select * from flight where total_seats>180;

-- find flights having seats between 180 and 190
select * from flight where total_seats between 180 and 190;

-- find confirmed bookings
select * from booking where booking_status='Confirmed';

-- find cancelled bookings
select * from booking where booking_status='Cancelled';

-- find confirmed bookings having seat numbers starting with 20
select * from booking where booking_status='CONFIRMED' and seat_number like '20%';

-- find bookings that are either confirmed or cancelled
select * from booking where booking_status in('CONFIRMED','CANCELLED');

-- display all different booking status
select distinct booking_status from booking;

-- display passengers alphabetically
select * from passenger order by passenger_name ASC;

-- display payments in descending order of amount
select * from payment order by amount desc;

-- display  first 5 airport
select * from airport limit 5; 

-- display remaining airports after 7
select * from airport limit 4 offset 7;

-- display passenger names and their booking details
select p.passenger_name,b.booking_id,b.seat_number,b.booking_status from passenger p inner join 
booking b on p.passenger_id = b.passenger_id;

-- display passenger names and flight numbers
select p.passenger_name,f.flight_number from passenger p inner join booking b on p.passenger_id=b.passenger_id 
inner join flight f on b.flight_id=f.flight_id;

-- display flight number and airline name
select f.flight_number,a.airline_name from flight f inner join airline a on f.airline_id=a.airline_id;

-- display complete booking information
select b.booking_id,p.passenger_name,f.flight_number,b.seat_number,b.booking_status from booking b 
join passenger p on b.passenger_id=p.passenger_id join flight f on b.flight_id=f.flight_id;

-- display passenger,flight,airline,booking status
select 
    p.passenger_name,
    f.flight_number,
    a.airline_name,
    b.seat_number,
    b.booking_status
from passenger p
join booking b
on p.passenger_id = b.passenger_id
join flight f
on b.flight_id = f.flight_id
join airline a
on f.airline_id = a.airline_id;

-- find all passengers, including passengers who have not not booked a flight
select p.passenger_id,p.passenger_name,b.booking_id from passenger p left join 
booking b on p.passenger_id=b.passenger_id;

-- display all flights and their airline information
select a.airline_name,f.flight_number from airline a right join flight f on a.airline_id=f.airline_id;

-- find passengers who have never made booking
select * from passenger where passenger_id not in(
	select passenger_id from booking);
    
-- find flights that have more seats than the average number of seats
select * from flight where total_seats>(
	select avg(total_seats) from flight);
    
-- find the passenger who made the booking with the highest payment.
select p.passenger_name from passenger p join booking b on p.passenger_id=b.passenger_id 
join payment pay on b.booking_id=pay.booking_id where pay.amount=(
	select max(amount) from payment);
    
-- display cities that are either source or destination airports.
select city from airport where airport_id in(
	select airport_id from flight)
UNION 
select city from airport where airport_id in(
	select destination_airport_id from flight);
    

-- add column to passenger table
alter table passenger add nationality varchar(50);

-- modify the column
alter table passenger modify nationality varchar(100);

-- rename the column
alter table passenger rename column nationality to country;

-- remove column
alter table passenger drop column country;

-- update cancelled booking status
update booking set booking_status='CANCELLED' where booking_id=9;

-- delete a specific booking
delete from booking where booking_id=88;

-- start a transaction and update booking
start transaction;
update booking set booking_status='CANCELLED' where booking_id=195;

select * from booking where booking_id=195;

commit;

-- rollback
start transaction;
update booking set booking_status='CONFIRMED' where booking_id=195;
rollback;

-- savepoint
start transaction;

update booking
set booking_status = 'CONFIRMED'
where booking_id = 10;

savepoint booking_update;

update booking
set booking_status = 'CANCELLED'
where booking_id = 11;

rollback to booking_update;

commit;