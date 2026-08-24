# Gans Scooter Demand Intelligence Pipeline

## Project Overview

This project develops a data pipeline to support Gans scooter positioning decisions by combining:

- Current weather conditions from the OpenWeather API
- Airport and flight arrival information from the AeroDataBox API (via RapidAPI)

The goal is to estimate potential scooter demand by analysing customer arrival patterns together with environmental conditions.

---

## Data Sources

### OpenWeather API 🌦️

Used to retrieve current weather conditions for cities.

Collected data:
- Temperature
- Feels-like temperature
- Humidity
- Weather condition
- Wind speed

The data is stored in the `weather_current` SQL table.

---

### AeroDataBox API ✈️ (via RapidAPI)

Used to retrieve airport and flight arrival information.

Airport data collected:
- Airport name
- IATA code
- ICAO code
- Coordinates
- Time zone

Flight arrival data collected:
- Flight number
- Airline
- Origin airport
- Destination airport
- Scheduled arrival
- Estimated arrival
- Flight status

The data is stored in:
- `airports`
- `flights`

---

## Pipeline Architecture

```
                 City Data
                     |
                     v
                Cities Table
                     |
          +----------+----------+
          |                     |
          v                     v
 OpenWeather API        AeroDataBox API
          |                     |
          v                     v
 weather_current       Airports + Flights
          |                     |
          +----------+----------+
                     |
                     v
          Scooter Demand Insights
```

---

## Database Tables

### cities
Stores city information and coordinates.

### weather_current
Stores the latest weather snapshot used for scooter demand decisions.

### airports
Stores airport information linked to cities.

### flights
Stores arriving flights used as a proxy for customer demand.

---

## Business Logic

The project combines:

```
Airport Arrivals
+
Weather Conditions
=
Scooter Demand Estimation
```

Example:

High demand:
- Many arriving flights
- Good weather
- Low wind
- No rain

Decision:
Increase scooter availability near airport locations.

Low demand:
- Poor weather conditions
- Heavy rain or strong wind

Decision:
Adjust scooter allocation.

---

## Technologies

- Python
- Pandas
- Requests
- MySQL
- SQLAlchemy
- PyMySQL
- Jupyter Notebook

---

## Project Structure

```
gans-scooter-demand-pipeline/

README.md
gans_scooter_demand_pipeline.ipynb
requirements.txt

sql/
    create_tables_gans.sql
```
