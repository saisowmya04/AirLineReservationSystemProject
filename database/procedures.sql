-- create a procedure to display all passengers
delimiter //
create procedure get_all_passengers()
begin
select * from passenger;
end //
delimiter ;

call get_all_passengers();

-- create a procedure to find bookings for  passenger
delimiter //
create procedure passenger_bookings(in pid int)
begin
select * from booking where passenger_id=pid;
end //
delimiter ;

call passenger_bookings(40);