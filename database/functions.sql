-- count total passengers
select count(*) as total_passengers from passenger;

-- count total flights 
select count(*) as totla_flights from flight;

-- find highest payment amount
select max(amount) as highest_payment from payment;

-- find lowest payment amount
select min(amount) as lowest_payment from payment; 

-- find average payment
select avg(amount) as average_amount from payment;

-- find total payment collected
select sum(amount) as total_revenue from payment;

-- count confirmed bookings
select count(*) as confirmed_bookings from booking where booking_status='CONFIRMED';

-- count bookings by booking status
select booking_status,count(*) as total_bookings from booking group by booking_status;

-- count passengers for each flight
select flight_id,count(*) as passenger_count from booking group by flight_id;

-- count total payment for each payment status
select payment_status,sum(amount) as total_amount from payment group by payment_status;

-- find average payment for each payment status
select payment_status,avg(amount) as average_amount from payment group by payment_status;

-- find flights having more than 2 bookings
select flight_id,count(*) as booking_count from booking group by flight_id having count(*)>2;

-- find passengers who made more than one booking
select passenger_id,count(*) as total_bookings from booking group by passenger_id having count(*)>1;

-- find payment status whose total amount exceeds 30000
select payment_status,sum(amount) as total_amount from payment group by payment_status having sum(amount)>30000;

-- display passenger names in upper
select upper(passenger_name) as passenger_name from passenger;

-- display passenger names in lower
select lower(passenger_name) as passenger_name from passenger;

-- display length of each passenger name
select passenger_name,length(passenger_name) as name_length from passenger;

-- display first 5 characters of airport
select airport_name,left(airport_name,5) as first_five_characters from airport;

-- concatenate airport name and city
select concat(airport_name,'-',city) as airport_details from airport; 

-- display passenger age based on date of birth
select passenger_name,timestampdiff(year,date_of_birth,curdate()) as age from passenger;

-- display bookings made in particular year
select * from booking where year(booking_date)=2026;

-- display payment made in september
select * from payment where month(payment_date) =9;

-- calculate how many days ago each bookings was made
select booking_id,booking_date,datediff(curdate(),booking_date) as days_sice_booking from booking;

-- windowfunc
-- ==========
-- assign row numbers to flights
select flight_id,flight_number,total_seats,row_number() over(order by total_seats desc) as rowno from flight;

-- rank flights according to number of seats
select flight_number,total_seats,rank() over(order by total_seats desc) as seat_rank from flight;

-- find dense rank of flights based on seats
select flight_number,total_seats,dense_rank() over(order by total_seats desc) as seat_rank from flight;

-- find booking sequence for each passenger
select passenger_id,booking_id,booking_date,row_number() over(partition by passenger_id order by booking_date) as booking_number from booking;

-- find total bookings made by each passenger using window function
select passenger_id,booking_id,count(*) over(partition by passenger_id) as total_bookings from booking;

-- find average payment amount for each passenger
select b.passenger_id,b.booking_id,p.amount,avg(p.amount) over(partition by b.passenger_id) as passenger_average_payment
from booking b join payment p on b.booking_id=p.booking_id;