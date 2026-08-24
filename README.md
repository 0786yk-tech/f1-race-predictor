# F1 Race Outcome Predictor

Predicting Formula 1 finishing positions from qualifying grid position using Python, MySQL, and machine learning.

## Project overview

This project explores how much a driver's starting grid position determines their race result, using 2025 Formula 1 season data.

**Key finding so far:** grid position correlates 0.651 with finishing position, explaining roughly 42% of the variance. Grid position matters substantially, but leaves most of the outcome unexplained.

## Tech stack

- **Python** (pandas, matplotlib, scikit-learn) - extraction, analysis, modelling
- **MySQL** - normalized relational storage
- **Jupyter** - exploratory analysis
- **Tableau** - dashboards
- **n8n** - automated data pipeline

## Data source

[jolpica-f1 API](https://api.jolpi.ca/) - the community-maintained successor to the deprecated Ergast API. Free, no authentication required.

## Database schema

Three normalized tables:
- `drivers` - one row per driver
- `races` - one row per Grand Prix
- `results` - one row per driver per race, linked to both via foreign keys

## Known limitations

- The `races.circuit_name` column currently stores the race name (e.g. "Australian Grand Prix") rather than the actual circuit name (e.g. "Albert Park"). These are conceptually different and should be separate columns.
- `races.race_date` is not currently populated, though the API provides it.
- Only 2025 season data loaded so far; more seasons needed for robust modelling.

## Setup

Requires a local MySQL instance and a `config.py` file in the project root (gitignored) containing database credentials.

## Progress

- [x] Data extraction from API
- [x] MySQL schema design and loading
- [x] Exploratory data analysis
- [ ] Prediction model
- [ ] Tableau dashboard
- [ ] n8n automated pipeline
