Airline Reservation System - ER Diagram

1. One-to-One Relationship

A one-to-one (1:1) relationship means one record in one table is associated with only one record in another table.

For the basic airline project, you do not need to force a 1:1 relationship. For example, booking and payment can be designed as 1:1 if your project allows exactly one payment per booking:

BOOKING  1 ───────── 1  PAYMENT

However, if you want to support multiple payment attempts for one booking, it should instead be 1:M.

For a student project, I recommend treating:

BOOKING 1 ───────── 1 PAYMENT

with payment.booking_id as a UNIQUE foreign key.

2. One-to-Many Relationships

A one-to-many (1:M) relationship means one record in the parent table can have many records in the child table.

Passenger → Booking

One passenger can make many bookings.

PASSENGER 1 ─────────── M BOOKING

Example:

Passenger 101
     |
     +── Booking 1001
     +── Booking 1002
     +── Booking 1003

booking.passenger_id is the FK.

Aircraft → Flight

One aircraft can be assigned to many flights over time.

AIRCRAFT 1 ─────────── M FLIGHT

flight.aircraft_id is the FK.

Airport → Flight

An airport can be the departure airport for many flights.

AIRPORT 1 ─────────── M FLIGHT

flight.departure_airport_id is the FK.

Similarly, an airport can be the arrival airport for many flights:

AIRPORT 1 ─────────── M FLIGHT

flight.arrival_airport_id is the FK.

So the flight table has two foreign keys pointing to the same airport table.

Aircraft → Seat

One aircraft has many seats.

AIRCRAFT 1 ─────────── M SEAT

seat.aircraft_id is the FK.

Example:

Aircraft 101
    |
    +── 1A
    +── 1B
    +── 2A
    +── 2B
    +── 3A
Flight → Booking

One flight can have many bookings.

FLIGHT 1 ─────────── M BOOKING

booking.flight_id is the FK.

Booking → Ticket

If one booking generates one ticket, this can be 1:1. But if your system supports multiple passengers under one booking/PNR, the relationship can become 1:M.

For the simplified student project:

BOOKING 1 ─────────── 1 TICKET
Booking → Cancellation

A booking can have zero or one cancellation.

BOOKING 1 ─────────── 0..1 CANCELLATION

This means:

Booking
   |
   +── No cancellation

or

Booking
   |
   +── Cancellation
3. Many-to-Many Relationships

A many-to-many (M:N) relationship means many records in one table can be related to many records in another table.

For your project, the most important M:N relationship is:

Passenger ↔ Flight

A passenger can travel on many flights, and a flight can have many passengers.

PASSENGER M ─────────── M FLIGHT

We should not directly create an M:N relationship in a relational database.

Instead, we use the booking table as a junction/bridge table.

PASSENGER 1 ─── M BOOKING M ─── 1 FLIGHT

Therefore:

PASSENGER
    |
    | 1
    |
    | M
  BOOKING
    |
    | M
    |
    | 1
  FLIGHT

The booking table resolves the original:

PASSENGER M ↔ M FLIGHT

relationship.

4. Why booking is a Junction Table

Consider:

Passenger A → Flight 101
Passenger A → Flight 102
Passenger B → Flight 101
Passenger C → Flight 101

This means:

              Flight 101
             /     |     \
       Passenger A B     C

Passenger A
     |
     └──── Flight 102

This is a many-to-many relationship.

The booking table converts it into two 1:M relationships:

PASSENGER
    1
    |
    M
 BOOKING
    M
    |
    1
 FLIGHT
5. Final ER Diagram Structure

Here is the complete text-based ER diagram for your Airline Reservation System.

                         ┌───────────────────────┐
                         │       AIRPORT         │
                         ├───────────────────────┤
                         │ PK airport_id         │
                         │    airport_code       │
                         │    airport_name       │
                         │    city               │
                         │    country            │
                         └───────────┬───────────┘
                                     │
                       ┌─────────────┴─────────────┐
                       │                           │
                     1 │                           │ 1
                       │                           │
                     M │                           │ M
                       ▼                           ▼
              ┌────────────────────────────────────────┐
              │                 FLIGHT                  │
              ├────────────────────────────────────────┤
              │ PK flight_id                           │
              │    flight_number                       │
              │ FK aircraft_id                         │
              │ FK departure_airport_id                │
              │ FK arrival_airport_id                  │
              │    departure_time                      │
              │    arrival_time                        │
              │    status                              │
              └──────────────────┬─────────────────────┘
                                 │
                               1 │
                                 │
                               M │
                                 ▼
              ┌────────────────────────────────────────┐
              │                BOOKING                 │
              ├────────────────────────────────────────┤
              │ PK booking_id                          │
              │ FK passenger_id                        │
              │ FK flight_id                           │
              │    booking_date                        │
              │    booking_status                      │
              │    total_amount                        │
              └──────────────┬───────────┬─────────────┘
                             │           │
                           M │           │ 1
                             │           │
                           1 │           │
                             ▼           ▼
                ┌──────────────────┐  ┌──────────────────┐
                │    PASSENGER     │  │     PAYMENT      │
                ├──────────────────┤  ├──────────────────┤
                │ PK passenger_id  │  │ PK payment_id    │
                │    first_name    │  │ FK booking_id    │
                │    last_name     │  │    payment_date  │
                │    gender        │  │    amount        │
                │    date_of_birth │  │    payment_method│
                │    email         │  │    payment_status│
                │    phone         │  └──────────────────┘
                │    passport_no   │
                └──────────────────┘
                             │
                             │
                             │
                             ▼
                    ┌──────────────────┐
                    │      TICKET      │
                    ├──────────────────┤
                    │ PK ticket_id     │
                    │ FK booking_id    │
                    │ FK passenger_id  │
                    │ FK flight_id     │
                    │ FK seat_id       │
                    │    ticket_number │
                    │    fare          │
                    └────────┬─────────┘
                             │
                           M │
                             │
                           1 │
                             ▼
                    ┌──────────────────┐
                    │       SEAT       │
                    ├──────────────────┤
                    │ PK seat_id       │
                    │ FK aircraft_id   │
                    │    seat_number   │
                    │    seat_class    │
                    │    seat_status   │
                    └────────┬─────────┘
                             │
                           M │
                             │
                           1 │
                             ▼
                    ┌──────────────────┐
                    │     AIRCRAFT     │
                    ├──────────────────┤
                    │ PK aircraft_id   │
                    │    aircraft_no   │
                    │    aircraft_model│
                    │    total_seats   │
                    └──────────────────┘


                    BOOKING
                       │
                       │ 1
                       │
                       │ 0..1
                       ▼
              ┌────────────────────┐
              │    CANCELLATION    │
              ├────────────────────┤
              │ PK cancellation_id │
              │ FK booking_id      │
              │    cancellation_date│
              │    reason          │
              │    refund_amount   │
              └────────────────────┘