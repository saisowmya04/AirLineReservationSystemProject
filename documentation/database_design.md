Airline Reservation System — Database Design
--------------------------------------------


1. Database Name
airlinereservation

Create it using:

CREATE DATABASE airlinereservation;

USE airlinereservation;


2. Database Structure

The main tables are:

airlinereservation
│
├── airline
├── airport
├── passenger
├── flight
├── booking
└── payment
Relationship overview
                 ┌──────────────┐
                 │   AIRLINE    │
                 └──────┬───────┘
                        │ 1
                        │
                        │ N
                 ┌──────▼───────┐
                 │    FLIGHT    │
                 └──┬────────┬──┘
                    │        │
              source│        │destination
                    │        │
              ┌─────▼───┐ ┌──▼────────┐
              │ AIRPORT │ │  AIRPORT  │
              └─────────┘ └───────────┘

                 ┌──────────────┐
                 │  PASSENGER   │
                 └──────┬───────┘
                        │ 1
                        │
                        │ N
                 ┌──────▼───────┐
                 │   BOOKING    │
                 └──────┬───────┘
                        │ 1
                        │
                        │ N
                 ┌──────▼───────┐
                 │   PAYMENT    │
                 └──────────────┘

A flight has one airline, but an airline can operate many flights.

An airport can be the source or destination of many flights.

A passenger can make many bookings.

A flight can have many bookings.

A booking can have one or more payment records, depending on the payment design.

3. Table 1 — airline
Purpose

Stores information about airlines operating flights.

Examples:

Air India
IndiGo
Vistara
SpiceJet
Air India Express
Structure
Column	Data Type	Constraints	Purpose
airline_id	INT	PK, AUTO_INCREMENT	Unique airline ID
airline_name	VARCHAR(100)	NOT NULL, UNIQUE	Airline name
SQL
CREATE TABLE airline (
    airline_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL UNIQUE
);
Example data
1    Air India
2    IndiGo
3    Vistara
4    SpiceJet
5    Air India Express


4. Table 2 — airport
Purpose

Stores information about airports.

The same airport table is used for both:

source airport
destination airport

This avoids creating separate source_airport and destination_airport tables.

Structure
Column	Data Type	Constraints	Purpose
airport_id	INT	PK, AUTO_INCREMENT	Unique airport ID
airport_name	VARCHAR(150)	NOT NULL, UNIQUE	Airport name
city	VARCHAR(100)	NOT NULL	City
country	VARCHAR(100)	NOT NULL, DEFAULT 'India'	Country
SQL
CREATE TABLE airport (
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_name VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'India'
);
Example
1   Sardar Vallabhbhai Patel International Airport   Ahmedabad
2   Goa International Airport                        Goa
3   Jaipur International Airport                     Jaipur
4   Lucknow International Airport                    Lucknow



5. Table 3 — passenger
Purpose

Stores passenger/customer information.

Structure
Column	Data Type	Constraints	Purpose
passenger_id	INT	PK, AUTO_INCREMENT	Unique passenger ID
passenger_name	VARCHAR(100)	NOT NULL	Passenger name
email	VARCHAR(150)	NOT NULL, UNIQUE	Passenger email
phone	VARCHAR(15)	NOT NULL, UNIQUE	Contact number
date_of_birth	DATE	NOT NULL	Date of birth
created_at	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	Record creation time
SQL
CREATE TABLE passenger (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
Why phone is VARCHAR?

Phone numbers should generally be stored as strings rather than integers because:

they are identifiers, not quantities
they may contain leading zeros
they may contain country codes such as +91


6. Table 4 — flight
Purpose

Stores flight schedules and connects a flight with:

airline
source airport
destination airport

This is one of the most important tables in the project.

Structure
Column	Data Type	Constraints	Purpose
flight_id	INT	PK, AUTO_INCREMENT	Unique flight ID
flight_number	VARCHAR(20)	NOT NULL, UNIQUE	Flight number
airline_id	INT	NOT NULL, FK	Operating airline
source_airport_id	INT	NOT NULL, FK	Departure airport
destination_airport_id	INT	NOT NULL, FK	Arrival airport
departure_time	DATETIME	NOT NULL	Departure date/time
arrival_time	DATETIME	NOT NULL	Arrival date/time
total_seats	INT	NOT NULL, CHECK	Aircraft capacity
SQL
CREATE TABLE flight (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,

    flight_number VARCHAR(20) NOT NULL UNIQUE,

    airline_id INT NOT NULL,

    source_airport_id INT NOT NULL,

    destination_airport_id INT NOT NULL,

    departure_time DATETIME NOT NULL,

    arrival_time DATETIME NOT NULL,

    total_seats INT NOT NULL,

    CONSTRAINT fk_flight_airline
        FOREIGN KEY (airline_id)
        REFERENCES airline(airline_id),

    CONSTRAINT fk_flight_source_airport
        FOREIGN KEY (source_airport_id)
        REFERENCES airport(airport_id),

    CONSTRAINT fk_flight_destination_airport
        FOREIGN KEY (destination_airport_id)
        REFERENCES airport(airport_id),

    CONSTRAINT chk_flight_seats
        CHECK (total_seats > 0),

    CONSTRAINT chk_flight_airports
        CHECK (source_airport_id <> destination_airport_id),

    CONSTRAINT chk_flight_time
        CHECK (arrival_time > departure_time)
);
Important point

The airport table is referenced twice:

flight.source_airport_id
          ↓
airport.airport_id

flight.destination_airport_id
          ↓
airport.airport_id

This is a valid and common database design.

7. Table 5 — booking
Purpose

Stores passenger reservations.

It connects:

Passenger ← Booking → Flight

This table represents the many-to-many relationship between passengers and flights.

For example:

Passenger 16 → Flight 13
Passenger 17 → Flight 13
Passenger 18 → Flight 14
Structure
Column	Data Type	Constraints	Purpose
booking_id	INT	PK, AUTO_INCREMENT	Unique booking
passenger_id	INT	NOT NULL, FK	Passenger making booking
flight_id	INT	NOT NULL, FK	Booked flight
seat_number	VARCHAR(5)	NOT NULL	Assigned seat
booking_status	VARCHAR(20)	NOT NULL, DEFAULT	Booking status
booking_date	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	Booking time
Recommended SQL
CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,

    passenger_id INT NOT NULL,

    flight_id INT NOT NULL,

    seat_number VARCHAR(5) NOT NULL,

    booking_status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',

    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_passenger
        FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id),

    CONSTRAINT fk_booking_flight
        FOREIGN KEY (flight_id)
        REFERENCES flight(flight_id),

    CONSTRAINT chk_booking_status
        CHECK (booking_status IN ('CONFIRMED', 'CANCELLED', 'PENDING')),

    CONSTRAINT uq_flight_seat
        UNIQUE (flight_id, seat_number)
);
Why this UNIQUE constraint?
UNIQUE (flight_id, seat_number)

means:

Flight 101 → Seat 10A → Passenger A

cannot simultaneously be:

Flight 101 → Seat 10A → Passenger B

But the same seat number can be used on a different flight:

Flight 101 → 10A
Flight 102 → 10A

That is correct.

Important consideration for cancelled bookings

If you use:

UNIQUE (flight_id, seat_number)

a cancelled booking still occupies that combination.

For a production-grade system, you could instead enforce seat availability through application logic or a trigger that allows a cancelled seat to be reused.

For your learning project, the simple UNIQUE (flight_id, seat_number) constraint is easy to understand and demonstrates composite uniqueness.

8. Table 6 — payment
Purpose

Stores payment information associated with bookings.

Structure
Column	Data Type	Constraints	Purpose
payment_id	INT	PK, AUTO_INCREMENT	Unique payment
booking_id	INT	NOT NULL, FK	Related booking
amount	DECIMAL(10,2)	NOT NULL, CHECK	Payment amount
payment_date	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	Payment time
payment_status	VARCHAR(20)	NOT NULL, DEFAULT	Payment status
SQL
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,

    booking_id INT NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    payment_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',

    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id),

    CONSTRAINT chk_payment_amount
        CHECK (amount > 0),

    CONSTRAINT chk_payment_status
        CHECK (
            payment_status IN
            ('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED')
        )
);
9. Complete Database Design

Putting all six tables together:

CREATE DATABASE airlinereservation;

USE airlinereservation;


-- 1. AIRLINE
CREATE TABLE airline (
    airline_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL UNIQUE
);


-- 2. AIRPORT
CREATE TABLE airport (
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_name VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'India'
);


-- 3. PASSENGER
CREATE TABLE passenger (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 4. FLIGHT
CREATE TABLE flight (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_number VARCHAR(20) NOT NULL UNIQUE,
    airline_id INT NOT NULL,
    source_airport_id INT NOT NULL,
    destination_airport_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    total_seats INT NOT NULL,

    CONSTRAINT fk_flight_airline
        FOREIGN KEY (airline_id)
        REFERENCES airline(airline_id),

    CONSTRAINT fk_flight_source_airport
        FOREIGN KEY (source_airport_id)
        REFERENCES airport(airport_id),

    CONSTRAINT fk_flight_destination_airport
        FOREIGN KEY (destination_airport_id)
        REFERENCES airport(airport_id),

    CONSTRAINT chk_flight_seats
        CHECK (total_seats > 0),

    CONSTRAINT chk_flight_airports
        CHECK (source_airport_id <> destination_airport_id),

    CONSTRAINT chk_flight_time
        CHECK (arrival_time > departure_time)
);


-- 5. BOOKING
CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    seat_number VARCHAR(5) NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_passenger
        FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id),

    CONSTRAINT fk_booking_flight
        FOREIGN KEY (flight_id)
        REFERENCES flight(flight_id),

    CONSTRAINT chk_booking_status
        CHECK (
            booking_status IN
            ('CONFIRMED', 'CANCELLED', 'PENDING')
        ),

    CONSTRAINT uq_flight_seat
        UNIQUE (flight_id, seat_number)
);


-- 6. PAYMENT
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',

    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id),

    CONSTRAINT chk_payment_amount
        CHECK (amount > 0),

    CONSTRAINT chk_payment_status
        CHECK (
            payment_status IN
            ('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED')
        )
);



10. Foreign Key Relationship Summary
Child Table	Foreign Key	Parent Table	Relationship
flight	airline_id	airline.airline_id	Airline → Flights
flight	source_airport_id	airport.airport_id	Airport → Flights
flight	destination_airport_id	airport.airport_id	Airport → Flights
booking	passenger_id	passenger.passenger_id	Passenger → Bookings
booking	flight_id	flight.flight_id	Flight → Bookings
payment	booking_id	booking.booking_id	Booking → Payments



11. Constraints Used

Your project demonstrates several important MySQL constraints.

PRIMARY KEY

Every table has a unique identifier:

airline.airline_id
airport.airport_id
passenger.passenger_id
flight.flight_id
booking.booking_id
payment.payment_id
FOREIGN KEY

Maintains relationships:

flight → airline
flight → airport
booking → passenger
booking → flight
payment → booking
UNIQUE

Used where duplicate values should not be allowed:

airline_name
airport_name
email
phone
flight_number
(flight_id, seat_number)
NOT NULL

Used for mandatory information:

passenger_name
email
phone
flight_number
airline_id
source_airport_id
destination_airport_id
seat_number
amount
DEFAULT

Examples:

country DEFAULT 'India'

booking_status DEFAULT 'CONFIRMED'

payment_status DEFAULT 'PENDING'

booking_date DEFAULT CURRENT_TIMESTAMP

payment_date DEFAULT CURRENT_TIMESTAMP
CHECK

Examples:

CHECK (total_seats > 0)

CHECK (amount > 0)

CHECK (source_airport_id <> destination_airport_id)

CHECK (arrival_time > departure_time)

and:

CHECK (
    booking_status IN
    ('CONFIRMED', 'CANCELLED', 'PENDING')
)



12. Why This Design Is Normalized

The design avoids storing the same information repeatedly.

For example, instead of storing:

AI101 | Air India | Ahmedabad | Goa
AI102 | Air India | Goa | Jaipur
AI103 | Air India | Jaipur | Lucknow

with repeated airline and airport information inside every row, we store:

airline
---------
1 | Air India

and:

airport
---------
1 | Ahmedabad
2 | Goa
3 | Jaipur
4 | Lucknow

Then flight stores only the IDs:

flight_number | airline_id | source_airport_id | destination_airport_id
AI101         | 1          | 1                 | 2
AI102         | 1          | 2                 | 3
AI103         | 1          | 3                 | 4

This reduces data redundancy and improves data consistency.