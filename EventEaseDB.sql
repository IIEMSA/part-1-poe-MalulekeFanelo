-- Use master database to create a new database
USE master;
GO

-- Create the EventEase database
CREATE DATABASE EventEaseDB
GO

-- Switch to the new database
USE EventEaseDB;
GO

-- Create Venue Table
CREATE TABLE Venue(
    VenueId INT IDENTITY(1,1) PRIMARY KEY,
    VenueName VARCHAR(255) NOT NULL UNIQUE,
    Location VARCHAR(255) NOT NULL,
    Capacity INT NOT NULL,
    ImageUrl VARCHAR(500),
);
GO

-- Create Event Table
CREATE TABLE Event (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATETIME NOT NULL,
    Description TEXT NULL,
    VenueId INT NULL,
    FOREIGN KEY (VenueId) REFERENCES Venue(VenueId) ON DELETE SET NULL
);
GO

-- Create Booking Table
CREATE TABLE Booking (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    VenueId INT NOT NULL,
    BookingDate DATETIME NOT NULL,
    FOREIGN KEY (EventId) REFERENCES Event(EventId) ON DELETE CASCADE,
    FOREIGN KEY (VenueId) REFERENCES Venue(VenueId) ON DELETE CASCADE,
    CONSTRAINT UC_VenueBooking UNIQUE (VenueId, BookingDate) -- Prevent double booking
);
GO

-- Insert sample data into Venue table
INSERT INTO Venue (VenueName, Location, Capacity, ImageUrl)
VALUES 
('City Hall', 'Bloemfontein', 600, 'cityhall.jpg'),
('Amara Golf Club', 'Durban ', 300, 'amaragolfclub.jpg'),
('Botanical Gardens', 'Cape Town', 500, 'botanical.jpg');
GO

-- Insert sample data into Event table
INSERT INTO Event (EventName, EventDate, Description, VenueId)
VALUES 
('Comic Con', '2025-07-10 09:00', 'Annual Comic Convention', 1),
('Wedding Reception', '2025-08-15 18:00', 'Exclusive wedding event', 2),
('Nedbank Christmas Party', '2025-06-05 14:00', 'Coparate annual christmas partu', 3);
GO

-- Insert sample data into Booking table
INSERT INTO Booking (EventId, VenueId, BookingDate)
VALUES 
(1, 1, '2025-07-10 09:00'),
(2, 2, '2025-08-15 18:00'),
(3, 3, '2025-06-05 14:00');
GO
-- Verify data
SELECT * FROM Venue;
SELECT * FROM Event;
SELECT * FROM Booking;
GO
ALTER TABLE Booking DROP CONSTRAINT UC_VenueBooking;


ALTER TABLE Booking ADD CONSTRAINT UC_VenueBooking UNIQUE (VenueId, BookingDate, EventId);

SELECT * FROM INFORMATION_SCHEMA.TABLES
