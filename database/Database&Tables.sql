/* creating database*/
create database airlinereservation;

/*using the database*/
use airlinereservation;

/*creating tables*/

create table passenger(
	passenger_id int primary key auto_increment,
    passenger_name varchar(100) not null,
    email varchar(100) unique not null,
    phone varchar(10),
    date_of_birth date
);


create table airline(
	airline_id int primary key auto_increment,
    airline_name varchar(100) not null
);


create table airport(
	airport_id int primary key auto_increment,
    airport_name varchar(100) not null,
    city varchar(100) not null,
    country varchar(100) not null
);



create table flight(
	flight_id int primary key auto_increment,
    flight_number varchar(50) unique not null,
    airline_id int not null,
    source_airport_id int not null,
    destination_airport_id int not null,
    departure_time datetime not null,
    arrival_time datetime not null,
    total_seats int not null,
    
    foreign key(airline_id)
		references airline(airline_id),
        
	foreign key(source_airport_id)
		references airport(airport_id),
        
	foreign key(destination_airport_id)
		references airport(airport_id)
);


create table booking(
	booking_id int primary key auto_increment,
    passenger_id int not null,
    flight_id int not null,
    booking_date datetime default current_timestamp,
    seat_number varchar(10),
    booking_status varchar(50) default 'CONFIRMED',
    
    foreign key(passenger_id)
		references passenger(passenger_id),
        
	foreign key(flight_id)
		references flight(flight_id)
);



create table payment(
	payment_id int primary key auto_increment,
    booking_id int not null,
    amount decimal(10,2) not null,
    payment_date datetime default current_timestamp,
    payment_status varchar(50) default 'PAID',
    
    foreign key(booking_id) 
		references booking(booking_id)
);


