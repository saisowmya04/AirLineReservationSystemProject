✈️ Airline Reservation System

An Airline Reservation System is a database-driven application designed to manage airline flight bookings and passenger information efficiently. The system uses MySQL as the backend database to store and manage flight, passenger, booking, and payment details.

📌 Project Overview

The Airline Reservation System allows users to:

Search for available flights

View flight details

Register passenger information

Book airline tickets

Manage passenger bookings

Cancel reservations

View booking details

Store and manage payment information

Manage flight and airport details

The project demonstrates the use of MySQL database concepts, including tables, relationships, primary keys, foreign keys, queries, joins, constraints, and transactions.

🛠️ Technologies Used

Database: MySQL

Language: SQL

Tools: MySQL Workbench / MySQL Server

Version Control: Git & GitHub

🗂️ Database Structure

The database can contain the following main tables:

1. passengers

Stores information about passengers.

Column	Description
passenger_id	Unique passenger ID
first_name	Passenger first name
last_name	Passenger last name
email	Passenger email
phone	Passenger phone number
passport_number	Passport identification number
2. airports

Stores airport information.

Column	Description
airport_id	Unique airport ID
airport_name	Name of the airport
city	Airport city
country	Airport country
airport_code	IATA airport code
3. flights

Stores information about available flights.

Column	Description
flight_id	Unique flight ID
flight_number	Flight number
airline	Airline name
source_airport	Departure airport
destination_airport	Arrival airport
departure_time	Departure date and time
arrival_time	Arrival date and time
total_seats	Total number of seats
available_seats	Available seats
ticket_price	Ticket price
4. bookings

Stores passenger reservation details.

Column	Description
booking_id	Unique booking ID
passenger_id	Passenger reference
flight_id	Flight reference
booking_date	Date of booking
seat_number	Allocated seat
booking_status	Current booking status
5. payments

Stores payment information.

Column	Description
payment_id	Unique payment ID
booking_id	Booking reference
payment_date	Payment date
amount	Payment amount
payment_method	Payment method
payment_status	Payment status
🔗 Database Relationships

The main relationships are:

Passengers
    |
    | 1 : Many
    v
Bookings
    |
    | Many : 1
    v
Flights
    |
    +--------------------+
                         |
                         v
                    Airports

Bookings
    |
    | 1 : 1 / 1 : Many
    v
Payments


One passenger can have multiple bookings.

One flight can have multiple bookings.

A booking belongs to one passenger and one flight.

A booking can have associated payment information.

Flights are associated with departure and destination airports.

💾 Installation and Setup
Step 1: Install MySQL

Install MySQL Server and optionally MySQL Workbench on your system.

Step 2: Create the Database

Open MySQL Workbench or the MySQL command line and run:

CREATE DATABASE airline_reservation;

USE airline_reservation;

Step 3: Create Tables

Run the SQL file included in the project.

For example:

mysql -u root -p airline_reservation < airline_reservation.sql


Or open the .sql file in MySQL Workbench and execute it.

Step 4: Insert Sample Data

Execute the sample-data SQL script if it is included in the project:

INSERT INTO airports
(airport_name, city, country, airport_code)
VALUES
('Rajiv Gandhi International Airport', 'Hyderabad', 'India', 'HYD');

🔍 Example SQL Queries
View all flights
SELECT *
FROM flights;

Find available flights
SELECT *
FROM flights
WHERE available_seats > 0;

Search flights between airports
SELECT *
FROM flights
WHERE source_airport = 1
AND destination_airport = 2;

View booking details
SELECT
    b.booking_id,
    p.first_name,
    p.last_name,
    f.flight_number,
    f.departure_time,
    f.arrival_time,
    b.seat_number,
    b.booking_status
FROM bookings b
JOIN passengers p
    ON b.passenger_id = p.passenger_id
JOIN flights f
    ON b.flight_id = f.flight_id;

View payment details
SELECT
    p.payment_id,
    b.booking_id,
    p.amount,
    p.payment_method,
    p.payment_status
FROM payments p
JOIN bookings b
    ON p.booking_id = b.booking_id;

⚙️ Main Features
👤 Passenger Management

Add new passengers

Update passenger information

View passenger details

Delete passenger records

✈️ Flight Management

Add flights

Update flight schedules

View available flights

Track available seats

Manage ticket prices

🎫 Reservation Management

Create reservations

Assign seats

View booking information

Cancel reservations

Update booking status

💳 Payment Management

Record payments

Track payment status

View payment history

Associate payments with bookings

🔐 Database Constraints

The database uses:

Primary Keys to uniquely identify records

Foreign Keys to maintain relationships between tables

NOT NULL constraints for required fields

UNIQUE constraints for values such as email or passport number

CHECK constraints where applicable

DEFAULT values for fields such as booking status

📁 Suggested Project Structure
Airline-Reservation-System/
│
├── README.md
├── airline_reservation.sql
│
├── database/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── queries.sql
│
└── documentation/
    ├── requirements.md
    └── ER Diagrams.md
    ├── database design.md
    

🚀 Future Enhancements

The project can be extended with:

User login and authentication

Admin dashboard

Online ticket generation

Email/SMS booking confirmation

Online payment integration

Seat selection interface

Flight search filters

Real-time flight status

Cancellation and refund management

Web or mobile application interface

🎯 Learning Objectives

This project helps demonstrate practical knowledge of:

MySQL database design

Relational database management

SQL queries

CRUD operations

Primary and foreign keys

Database normalization

Joins

Constraints

Aggregate functions

Transactions

Database relationships

👨‍💻 Author

Mangamuri Sai Sowmya

If you found this project useful, feel free to ⭐ the repository.

📄 License

This project is created for educational and academic purposes. You may modify and use it for learning or project development.
