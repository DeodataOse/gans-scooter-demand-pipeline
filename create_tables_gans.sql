-- Gans Scooter Demand Pipeline
-- Database Schema

CREATE DATABASE IF NOT EXISTS gans;

USE gans;


-- Cities table
-- Stores city information collected through web scraping

CREATE TABLE IF NOT EXISTS cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    country_code VARCHAR(10),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    city_timezone VARCHAR(100),
    date_retrieved DATETIME
);


-- Historical weather table
-- Stores weather records retrieved from OpenWeather API

CREATE TABLE IF NOT EXISTS weather (
    weather_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    temperature DECIMAL(6,2),
    feels_like DECIMAL(6,2),
    humidity INT,
    weather_description VARCHAR(100),
    wind_speed DECIMAL(6,2),
    date_retrieved DATETIME,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);


-- Current weather table
-- Stores latest weather conditions used for demand analysis

CREATE TABLE IF NOT EXISTS weather_current (
    weather_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    temperature DECIMAL(6,2),
    feels_like DECIMAL(6,2),
    humidity INT,
    weather_main VARCHAR(50),
    weather_description VARCHAR(100),
    wind_speed DECIMAL(6,2),
    response_body LONGTEXT,
    date_retrieved DATETIME,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);


-- Airports table
-- Stores airport information retrieved from AeroDataBox API

CREATE TABLE IF NOT EXISTS airports (
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    airport_name VARCHAR(150),
    iata_code VARCHAR(10),
    icao_code VARCHAR(10),
    municipality_name VARCHAR(100),
    country_code VARCHAR(10),
    timezone VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);


-- Flights table
-- Stores arriving flight information retrieved from AeroDataBox API

CREATE TABLE IF NOT EXISTS flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_id INT NOT NULL,
    flight_number VARCHAR(20),
    airline VARCHAR(100),
    origin_airport VARCHAR(150),
    origin_iata VARCHAR(10),
    destination_airport VARCHAR(150),
    destination_iata VARCHAR(10),
    scheduled_arrival DATETIME,
    revised_arrival DATETIME,
    estimated_arrival DATETIME,
    terminal VARCHAR(20),
    gate VARCHAR(20),
    flight_status VARCHAR(50),
    date_retrieved DATETIME,
    FOREIGN KEY (airport_id) REFERENCES airports(airport_id)
);


-- Scooter demand forecast table
-- Stores demand predictions based on:
-- weather conditions, airport arrivals, and location data

CREATE TABLE IF NOT EXISTS scooter_weather_forecast (
    forecast_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    weather_risk VARCHAR(100),
    scooter_demand_forecast VARCHAR(100),
    notes VARCHAR(255),
    date_retrieved DATETIME,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);
