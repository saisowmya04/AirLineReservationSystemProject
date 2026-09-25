-- inserting data into booking

INSERT INTO booking
(
    passenger_id,
    flight_id,
    seat_number,
    booking_status
)
VALUES
(16, 51, '10A', 'CONFIRMED'),
(17, 51, '10B', 'CONFIRMED'),
(18, 52, '12A', 'CONFIRMED'),
(19, 52, '12B', 'CONFIRMED'),
(20, 53, '08A', 'CONFIRMED'),
(21, 53, '08B', 'CONFIRMED'),
(22, 54, '14A', 'CONFIRMED'),
(23, 54, '14B', 'CONFIRMED'),
(24, 55, '15A', 'CONFIRMED'),
(25, 56, '15B', 'CONFIRMED'),

(26, 57, '16A', 'CONFIRMED'),
(27, 57, '16B', 'CONFIRMED'),
(28, 58, '09A', 'CONFIRMED'),
(29, 58, '09B', 'CONFIRMED'),
(30, 59, '11A', 'CONFIRMED'),
(31, 59, '11B', 'CONFIRMED'),
(32, 60, '13A', 'CONFIRMED'),
(33, 61, '13B', 'CONFIRMED'),
(34, 62, '17A', 'CONFIRMED'),
(35, 62, '17B', 'CONFIRMED'),

(36, 63, '18A', 'CONFIRMED'),
(37, 63, '18B', 'CONFIRMED'),
(38, 64, '19A', 'CONFIRMED'),
(39, 64, '19B', 'CONFIRMED'),
(40, 65, '20A', 'CONFIRMED'),
(41, 65, '20B', 'CONFIRMED'),
(42, 66, '21A', 'CONFIRMED'),
(43, 66, '21B', 'CONFIRMED'),
(44, 67, '22A', 'CONFIRMED'),
(45, 67, '22B', 'CONFIRMED'),

(46, 68, '23A', 'CONFIRMED'),
(47, 68, '23B', 'CONFIRMED'),
(48, 69, '24A', 'CONFIRMED'),
(49, 69, '24B', 'CONFIRMED'),
(50, 70, '25A', 'CONFIRMED'),

(16, 78, '17C', 'CONFIRMED'),
(17, 78, '17D', 'CONFIRMED'),
(18, 80, '12C', 'CONFIRMED'),
(19, 80, '12D', 'CONFIRMED'),
(20, 72, '18C', 'CONFIRMED'),
(21, 72, '18D', 'CONFIRMED'),
(22, 74, '20C', 'CONFIRMED'),
(23, 74, '20D', 'CONFIRMED'),
(24, 76, '22C', 'CONFIRMED'),
(25, 76, '22D', 'CONFIRMED'),

(26, 88, '23C', 'CONFIRMED'),
(27, 88, '23D', 'CONFIRMED'),
(28, 90, '25B', 'CONFIRMED'),
(29, 90, '25C', 'CONFIRMED'),
(30, 73, '11A', 'CANCELLED'),
(31, 84, '13A', 'CANCELLED'),
(32, 75, '09A', 'CANCELLED'),
(33, 76, '15C', 'CANCELLED'),
(34, 77, '16C', 'CANCELLED'),
(35, 79, '10C', 'CANCELLED');


select * from booking;