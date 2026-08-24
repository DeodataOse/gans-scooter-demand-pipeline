# Gans Scooter Demand Pipeline: Weather, Airports and Flight Arrivals

## Project Overview

This project develops a multi-source data pipeline to support **Gans scooter positioning decisions**.

The objective is to combine:

- City location data collected through web scraping
- Current weather conditions from the OpenWeather API
- Airport and flight arrival information from the AeroDataBox API (via RapidAPI)

The goal is to estimate potential scooter demand by combining customer arrival patterns with environmental conditions.

---

# Business Problem

Gans needs to position scooters efficiently in locations where demand is likely to increase.

Scooter demand can be influenced by:

- Number of passengers arriving at airports
- Arrival times and peak travel periods
- Temperature and weather conditions
- Rain and wind conditions

By combining transportation and weather data, Gans can make better decisions about:

- Where to position scooters
- When to increase scooter availability
- When weather conditions may reduce demand

---

# Data Pipeline Architecture

```
                 Web Scraping
                     |
                     v
              Cities Information
                     |
                     v
                Cities SQL Table
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

# Data Sources

## 1. Web Scraping - City Data

The first stage of the pipeline collects city information through web scraping.

The extracted data includes:

- City name
- Country
- Latitude
- Longitude

The latitude and longitude values are required for querying external APIs.

The cleaned city data is stored in the:

```
cities
```

SQL table.

---

# 2. OpenWeather API

The OpenWeather API provides current weather conditions for each city.

Data collected:

- Temperature
- Feels-like temperature
- Humidity
- Weather condition
- Wind speed

The processed weather data is stored in:

```
weather_current
```

This information helps determine whether weather conditions are suitable for scooter usage.

---

# 3. AeroDataBox API (via RapidAPI)

The AeroDataBox API provides airport and flight arrival information.

## Airport Data

Collected information:

- Airport name
- IATA code
- ICAO code
- Airport coordinates
- Time zone

Stored in:

```
airports
```

---

## Flight Arrival Data

Collected information:

- Flight number
- Airline
- Origin airport
- Destination airport
- Scheduled arrival time
- Estimated arrival time
- Flight status

Stored in:

```
flights
```

Flight arrivals act as an indicator of potential customer demand around airports.

---

# Database Design

The project uses four main relational tables.

## cities

Stores city information and geographical coordinates.

Purpose:

- Provides location data for API requests
- Links cities with weather and airport information

---

## weather_current

Stores current weather snapshots.

Purpose:

- Provides environmental conditions affecting scooter usage

---

## airports

Stores airport information connected to cities.

Purpose:

- Provides airport locations and identifiers needed for flight retrieval

---

## flights

Stores arriving flight information.

Purpose:

- Provides potential customer arrival demand around airports

---

# Pipeline Workflow

## Step 1 - City Data Collection

1. Scrape city information.
2. Clean geographical data.
3. Store city information in MySQL.

---

## Step 2 - Weather Data Collection

1. Read city coordinates from the database.
2. Send requests to OpenWeather API.
3. Transform API responses into Pandas DataFrames.
4. Load results into the `weather_current` SQL table.

---

## Step 3 - Airport Data Collection

1. Use city location information.
2. Retrieve airport information through AeroDataBox.
3. Store airport details in the `airports` table.

---

## Step 4 - Flight Arrival Collection

1. Generate tomorrow's date automatically.
2. Query AeroDataBox for arriving flights.
3. Transform flight responses into structured data.
4. Store flight information in the `flights` table.

---

# Business Logic

The final objective combines:

```
Location Data
+
Weather Conditions
+
Airport Arrivals

=
Scooter Demand Estimation
```

## High Demand Scenario

Example:

- Many arriving flights
- Good weather
- Low wind
- No rain

Decision:

Increase scooter availability near airport locations.

---

## Low Demand Scenario

Example:

- Heavy rain
- Strong wind
- Poor weather conditions

Decision:

Adjust scooter allocation.

---

# Technologies Used

- Python
- Pandas
- Requests
- BeautifulSoup (Web Scraping)
- MySQL
- SQLAlchemy
- PyMySQL
- Jupyter Notebook

---

# Project Structure

```
gans-scooter-demand-pipeline/

README.md

gans_scooter_demand_pipeline.ipynb

requirements.txt

sql/
    create_tables_gans.sql
```

---

# Future Improvements

Possible improvements:

- Automate API execution using scheduled jobs
- Create a scooter demand prediction model
- Add historical weather tracking
- Integrate real scooter usage data
- Build operational dashboards

---

# Conclusion

This project demonstrates an end-to-end data pipeline combining multiple data sources to support business decision-making.

By integrating:

- Web-scraped city information
- OpenWeather API weather data
- AeroDataBox airport and flight data

Gans can make more informed scooter positioning decisions based on expected customer demand and environmental conditions.
