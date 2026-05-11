CREATE DATABASE Vietjet_Airline;
USE Vietjet_Airline;


CREATE TABLE Passengers (
	 passenger_id VARCHAR(5) PRIMARY KEY NOT NULL,
     full_name VARCHAR(100) NOT NULL,
     email VARCHAR(100) UNIQUE NOT NULL ,
     phone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE Airlines (
	airline_id VARCHAR(5) PRIMARY KEY NOT NULL,
    airline_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Flights (
	flight_id VARCHAR(5) PRIMARY KEY NOT NULL,
    route_name VARCHAR(100) UNIQUE NOT NULL,
    airline_id VARCHAR(5) NOT NULL,
    CONSTRAINT FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id),
    ticket_price DECIMAL(10,2) NOT NULL,
    available_seats INT NOT NULL
);

CREATE TABLE Bookings (
	 booking_id INT PRIMARY KEY  AUTO_INCREMENT NOT NULL,
     passenger_id VARCHAR(5) NOT NULL,
     flight_id VARCHAR(5) NOT NULL,
     status VARCHAR(20) NOT NULL,
     booking_date DATE NOT NULL,
     CONSTRAINT FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
     CONSTRAINT FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

INSERT INTO passengers 
VALUES
('P01','Trần Văn Bình', 'binh.tv@gmail.com', '0981111111' ),
('P02','Lê Thị Hoa','hoa.lt@gmail.com','0982222222'),
('P03','Nguyễn Trọng Tuấn','tuan.nt@gmail.com','0983333333'),
('P04','Hoàng Minh Châu','chau.hm@gmail.com','0984444444'),
('P05','Đinh Kiều Oanh','oanh.dk@gmail.com','098555555');

INSERT INTO Airlines
VALUES 
('A01','Vietnam Airlines'),
('A02','VietJet Air'),
('A03','Bamboo Airways'),
('A04','Pacific Airlines');

INSERT INTO Flights
VALUES
('F01', 'HN-HCM', 'A01', 2500000.00, '50'),
('F02', 'HN-DN', 'A01', 1500000.00, '30'),
('F03', 'HCM-HCM', 'A02', 1200000.00, '40'),
('F04', 'HN-PQ', 'A03', 3000000.00, '20'),
('F05', 'HCM-DL', 'A04', 1000000.00, '15');

INSERT INTO Bookings
VALUES
( 1,'P01', 'F01', 'Booked', '2025-10-01'),
( 2,'P02', 'F03', 'Boarded', '2025-10-02'),
( 3,'P01', 'F02', 'Boarded', '2025-10-03'),
( 4,'P04', 'F05', 'Cancelled', '2025-10-04'),
( 5,'P05', 'F01', 'Booked', '2025-10-05');


UPDATE Flights
SET available_seats = available_seats + 10 ,
ticket_price = ticket_price * 1.05
WHERE route_name = 'HN-PQ';

UPDATE Passengers
SET phone = '0999999999'
WHERE passenger_id = 'P03';


SET SQL_SAFE_UPDATES = 0;

DELETE FROM Bookings
WHERE status = 'Cancelled' AND booking_date < '2025-10-03' ;

-- PHẦN 2 --

SELECT flight_id, route_name, ticket_price
FROM Flights
WHERE ticket_price BETWEEN 1200000 AND 2500000 AND available_seats > 0; 

SELECT full_name, email
FROM Passengers
WHERE full_name LIKE 'Trần%';

SELECT booking_id, passenger_id, booking_date
FROM Bookings
ORDER BY booking_date DESC;

SELECT flight_id, route_name, ticket_price, available_seats
FROM Flights
ORDER BY ticket_price DESC
LIMIT 3 OFFSET 0 ;

-- Phân trang --
SELECT route_name , available_seats
FROM Flights
Limit 2 OFFSET 2;

-- PHẦN 3 --

SELECT b.booking_id, p.full_name, f.route_name, b.booking_date
FROM Bookings b
JOIN  Passengers p
ON b.passenger_id = p.passenger_id
JOIN Flights f
ON b.flight_id = f.flight_id
WHERE status = 'Booked';

SELECT a.airline_name, f.route_name
FROM Airlines a
JOIN Flights f
ON a.airline_id = f.airline_id;

SELECT full_name, phone
FROM Passengers p
JOIN Bookings b
ON p.passenger_id = b.passenger_id
JOIN flights f
ON f.flight_id = b.flight_id
WHERE route_name = 'HN-HCM';





