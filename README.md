# F1 Race Outcome Predictor

Predicting Formula 1 finishing positions from qualifying grid position using Python, MySQL, and machine learning.

**[View the interactive dashboard on Tableau Public](https://public.tableau.com/views/F1RacePredictor/Dashboard1)**

## Project overview

This project explores how much a driver's starting grid position determines their race result, using 2025 Formula 1 season data (479 results across 24 rounds).

### Key findings

- Grid position correlates **0.651** with finishing position, explaining roughly 42% of variance across the full dataset.
- A linear regression using grid position alone achieved **R2 0.297** on held-out test data, with a mean absolute error of **3.76 positions**.
- Adding constructor (team) as a feature improved this to **R2 0.341** and **MAE 3.45** - confirming that car pace carries information grid position alone doesn't capture.
- The model marginally beat a naive baseline on MAE, but nearly tripled its R2.

**Interpretation:** grid position is a real but weak predictor. F1 race outcomes are substantially driven by factors outside qualifying performance.

## Tech stack

- **Python** (pandas, matplotlib, scikit-learn) - extraction, analysis, modelling
- **MySQL** - normalized relational storage
- **Jupyter** - exploratory analysis
- **Tableau Public** - interactive dashboard
- **n8n** - automated data pipeline

## Data source

[jolpica-f1 API](https://api.jolpi.ca/) - the community-maintained successor to the deprecated Ergast API.

## Database schema

Three normalized tables: `drivers` (21 drivers), `races` (24 rounds), and `results` (one row per driver per race, linked via foreign keys).

## Repository structure

- `data/` - raw and processed datasets
- `notebooks/` - Jupyter notebooks
- `sql/` - SQL queries and schema scripts
- `scripts/` - standalone Python scripts

## Known limitations

- `races.circuit_name` stores the race name rather than the circuit name.
- `races.race_date` is not populated, though the API provides it.
- No `constructors` table - team data is joined from CSV rather than stored relationally.
- Constructor naming is inconsistent across seasons (e.g. "RB F1 Team" vs "Racing Bulls").
- The position-change metric partly reflects where teams qualify, since gaining places is easier from the back.
- Only 2025 season data loaded.

## Setup

Requires a local MySQL instance and a `config.py` file in the project root (gitignored) containing database credentials.

## Progress

- [x] Data extraction from API
- [x] MySQL schema design and ETL pipeline
- [x] Exploratory data analysis
- [x] Baseline and improved prediction models
- [x] Tableau dashboard
- [ ] n8n automated pipeline
