CREATE TYPE UserType AS ENUM ('OWNER', 'TECHNICIAN', 'CUST');
CREATE TYPE AppointmentStatus AS ENUM ('BOOKED', 'COMPLETED', 'CANCELLED');

CREATE TABLE IF NOT EXISTS "User" (
    UserID SERIAL PRIMARY KEY,
    Username TEXT NOT NULL UNIQUE,
    Password TEXT NOT NULL, -- Assumes hashed password storage
    Email TEXT NOT NULL UNIQUE,
    PhoneNumber TEXT,
    UserType UserType NOT NULL
);

-- NailDesign table
CREATE TABLE IF NOT EXISTS NailDesign (
    DesignID SERIAL PRIMARY KEY,
    Name TEXT NOT NULL,
    Picture BYTEA, -- This will store images in binary format
    Description TEXT
);

-- Appointment table
CREATE TABLE IF NOT EXISTS Appointment (
    AppointmentID SERIAL PRIMARY KEY,
    CustomerID INTEGER REFERENCES "User"(UserID),
    NailTechID INTEGER REFERENCES "User"(UserID),
    StartTime TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    EndTime TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    Status AppointmentStatus NOT NULL
);

-- FavoriteDesign table
CREATE TABLE IF NOT EXISTS FavoriteDesign (
    FavoriteID SERIAL PRIMARY KEY,
    CustomerID INTEGER REFERENCES "User"(UserID),
    DesignID INTEGER REFERENCES NailDesign(DesignID)
);







