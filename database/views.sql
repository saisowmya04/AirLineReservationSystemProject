-- creating view for booking information
create view booking_details as
select b.booking_id,p.passenger_name,f.flight_number,b.seat_number,b.booking_status from booking b 
join passenger p on b.passenger_id=p.passenger_id join flight f on b.flight_id=f.flight_id;

-- display the view
select * from booking_details;

-- display confirmed bookings from views
select * from booking_details where booking_status='CONFIRMED';