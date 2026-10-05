Airline Reservation System — Project Requirements
-------------------------------------------------

1. Project Objective

The main objective of the Airline Reservation System is to develop a database-driven system for managing airline flight and passenger reservation information efficiently.

The system is designed to store and manage:

Passenger details
Airline information
Airport information
Flight schedules
Flight routes
Seat information
Booking details
Payment information
Booking and payment status

The project uses MySQL as the database management system and demonstrates how relational databases can be used to manage real-world airline reservation operations.

The system should provide accurate and organized information about flights, passengers, bookings, and payments while maintaining relationships between different entities using primary keys and foreign keys.



2. Real-World Problem Being Solved

In a traditional or poorly organized reservation system, airline information can become difficult to manage when there are many:

Airlines
Airports
Flights
Passengers
Reservations
Payments

Managing this information manually can result in:

Duplicate passenger or booking records
Incorrect flight information
Seat duplication
Difficulty finding available flights
Difficulty tracking cancelled bookings
Payment-record inconsistencies
Difficulty generating reports
Data redundancy
Problems maintaining relationships between tables

The Airline Reservation System addresses these problems by storing information in separate but related tables.

For example:

Passenger
    ↓
Booking
    ↓
Flight
    ↓
Airline

Flight
    ↓
Source Airport
    ↓
Destination Airport

Booking
    ↓
Payment

The relational structure makes it easier to retrieve information using SQL queries and maintain data consistency using primary keys, foreign keys, constraints, transactions, and other database features.



3. Main Modules / Features

The system consists of the following major modules.

3.1 Passenger Management

This module manages passenger information.

Features
Add passenger details
View passenger details
Update passenger information
Search passengers
Identify passengers who have bookings
Identify passengers without bookings
Passenger information
passenger_id
passenger_name
email
phone
date_of_birth

3.2 Airline Management

This module stores information about airlines operating flights.

Features
Add airline
View airlines
Update airline information
Search airline
Find the number of flights operated by each airline

Example airlines in the project:

Air India
IndiGo
Vistara
SpiceJet
Air India Express

3.3 Airport Management

This module manages airport information.

Features
Store airport details
Store airport city and country
Search airports
Identify source and destination airports
Find flights departing from a particular airport
Find flights arriving at a particular airport

Airport information includes:

airport_id
airport_name
city
country

3.4 Flight Management

This is one of the main modules of the system.

It manages flight schedules and routes.

Features
Add flights
View flight details
Update flight information
Search flights
Identify source and destination
View departure and arrival times
Store total seat capacity
Find flights operated by a particular airline
Search flights between two cities

Flight information includes:

flight_id
flight_number
airline_id
source_airport_id
destination_airport_id
departure_time
arrival_time
total_seats

3.5 Booking / Reservation Management

This module manages passenger flight reservations.

Features
Create a booking
Assign a seat
View booking details
Update booking status
Cancel a booking
View confirmed bookings
View cancelled bookings
Find a passenger's bookings
Find passengers who have not booked flights

Example booking statuses:

CONFIRMED
CANCELLED

Booking information includes:

booking_id
passenger_id
flight_id
seat_number
booking_status

3.6 Payment Management

This module manages payments associated with bookings.

Features
Record payment
Store payment amount
Store payment date
Track payment status
Find successful payments
Find unsuccessful/pending payments
Calculate total revenue
Calculate average payment amount

Payment information includes:

payment_id
booking_id
amount
payment_date
payment_status

3.7 Flight Search

The system should allow users to search for flights based on criteria such as:

Source city
Destination city
Airline
Departure date
Departure time
Seat capacity

For example:

Source: Ahmedabad
Destination: Goa

The system should return matching flights.

3.8 Booking Status Management

The system should maintain the current status of every reservation.

Example:

CONFIRMED
CANCELLED

This helps identify the current state of each booking.

3.9 Reporting and Analytics

The database should support reports such as:

Flight reports
Total number of flights
Flights operated by each airline
Flights between cities
Average flight capacity
Highest-capacity flights
Lowest-capacity flights
Passenger reports
Total passengers
Passengers with bookings
Passengers without bookings
Passengers with multiple bookings
Booking reports
Total bookings
Confirmed bookings
Cancelled bookings
Bookings per flight
Bookings per passenger
Payment reports
Total revenue
Revenue by airline
Revenue by flight
Average payment
Successful payments


4. Users / Roles Involved

The system can be considered to have the following roles.

4.1 Passenger

The passenger is the person who wants to travel.

Responsibilities
Search flights
Select a flight
Provide passenger information
Select a seat
Make a reservation
Make payment
View booking details
Cancel a reservation

4.2 Airline / Reservation Staff

Reservation staff manage operational information.

Responsibilities
Manage flight information
View passenger reservations
Check booking status
Manage flight schedules
View passenger information
Monitor seat reservations

4.3 Administrator

The administrator manages the database and system information.

Responsibilities
Manage airlines
Manage airports
Manage flights
Manage passengers
Manage bookings
Manage payments
Generate reports
Maintain database integrity

For your MySQL project, the administrator role can be represented conceptually rather than implemented as a separate application login.

5. Complete Workflow of the System

The complete system workflow can be represented as:

START
  ↓
Passenger enters system
  ↓
Search for flights
  ↓
Select source and destination
  ↓
System displays available flights
  ↓
Passenger selects a flight
  ↓
Enter passenger details
  ↓
Select seat
  ↓
Check seat availability
  ↓
Create booking
  ↓
Booking status = CONFIRMED
  ↓
Make payment
  ↓
Store payment information
  ↓
Display booking confirmation
  ↓
Passenger can view booking
  ↓
Passenger can cancel booking if required
  ↓
Booking status = CANCELLED
  ↓
END




6. Detailed Database Workflow

From the database perspective, the process works as follows:

Step 1 — Passenger registration

Passenger information is stored in:

passenger

Example:

passenger_id
passenger_name
email
phone
date_of_birth

↓

Step 2 — Flight search

The system checks:

flight
airline
airport

to identify available flights.

↓

Step 3 — Flight selection

The selected flight is identified using:

flight_id

The flight is associated with:

airline_id
source_airport_id
destination_airport_id

↓

Step 4 — Seat selection

The passenger selects a seat such as:

10A
10B
12A
12B

The system checks existing bookings to avoid assigning the same confirmed seat to another passenger on the same flight.

↓

Step 5 — Booking creation

A record is inserted into:

booking

Example:

passenger_id
flight_id
seat_number
booking_status

↓

Step 6 — Payment

Payment information is stored in:

payment

The payment is associated with the booking using:

booking_id

↓

Step 7 — Confirmation

The system can combine information from:

passenger
       +
booking
       +
flight
       +
airline
       +
airport
       +
payment

to display complete reservation information.

↓

Step 8 — Cancellation

If the passenger cancels the reservation:

booking_status = 'CANCELLED'

The payment and booking information can still be retained for historical/reporting purposes, depending on the business rules implemented.




7. Functional Requirements

The system should provide the following functionality:

ID	Requirement
FR01	The system shall store passenger information.
FR02	The system shall store airline information.
FR03	The system shall store airport information.
FR04	The system shall store flight information.
FR05	The system shall associate flights with airlines.
FR06	The system shall associate flights with source and destination airports.
FR07	The system shall allow passengers to make bookings.
FR08	The system shall associate each booking with a passenger and flight.
FR09	The system shall store seat numbers for bookings.
FR10	The system shall maintain booking status.
FR11	The system shall store payment information.
FR12	The system shall associate payments with bookings.
FR13	The system shall support flight searching.
FR14	The system shall support booking cancellation.
FR15	The system shall generate reservation-related reports.
FR16	The system shall maintain referential integrity using foreign keys.
FR17	The system shall support SQL-based analysis and reporting.




8. Non-Functional Requirements
Performance

The database should efficiently retrieve:

Flight information
Passenger information
Booking information
Payment information

Indexes should be created on frequently searched columns where appropriate.

Data Integrity

The system should maintain consistency using:

Primary keys
Foreign keys
NOT NULL
UNIQUE
Appropriate constraints

For example:

booking.flight_id
       ↓
flight.flight_id

should always reference an existing flight.

Security

Access to the database should be restricted according to user privileges.

Sensitive information such as payment-related information should be appropriately protected.

Reliability

The database should avoid invalid bookings and maintain consistent relationships between:

Passenger → Booking → Flight → Airline
Scalability

The database design should allow additional:

Airlines
Airports
Flights
Passengers
Bookings
Payments

to be added without changing the overall database structure.