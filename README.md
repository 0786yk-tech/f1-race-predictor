# F1 Race Outcome Predictor

Predicting Formula 1 finishing positions from qualifying grid position using Python, MySQL, and machine learning.

**[View the interactive dashboard on Tableau Public](https://public.tableau.com/views/F1RacePredictor/Dashboard1)**

## Project overview

This project explores how much a driver's starting grid position determines their race result, using 2025 Formula 1 season data (479 results across 24 rounds).

### Key findings

- Grid position correlates **0.651** with finishing position, explaining roughly 42% of variance across the full dataset.
- A linear regression using grid position alone achieved **R2 0.297** on held-out test data, with a mean absolute error of **3.76 positions**.
- Adding constructor (team) as a feature improved this to **R2 0.341** and **MAE 3.45** - confirming that car pace carries information grid position alone doesn't capture.
- The model marginally beat a naive baseline (predicting finish = grid) on MAE, but nearly tripled its R2, indicating it captures the underlying relationship better even where individual predictions remain imprecise.

**Interpretation:** grid position is a real but weak predictor. F1 race outcomes are substantially driven by factors outside qualifying performance - reliability, strategy, incidents, and race-day pace.

## Tech stack

- **Python** (pandas, matplotlib, scikit-learn) - extraction, analysis, modelling
- **MySQL** - normalized relational storage
- **Jupyter** - exploratory analysis
- **Tableau Public** - interactive dashboard
- **n8n** - automated data pipeline
- **Docker** - running n8n locally
- **Git / GitHub** - version control

## Data source

[jolpica-f1 API](https://api.jolpi.ca/) - the community-maintained successor to the deprecated Ergast API. Free, no authentication required.

## Database schema

Three normalized tables:

- `drivers` - one row per driver (21 in 2025)
- `races` - one row per Grand Prix (24 rounds)
- `results` - one row per driver per race, linked to both via foreign keys

## Repository structure

- `data/` - raw and processed datasets
- `notebooks/` - Jupyter notebooks (01_data_extraction, 02_modelling)
- `sql/` - SQL queries and schema scripts
- `scripts/` - standalone Python scripts

## Automation (n8n)

A scheduled n8n workflow keeps the pipeline running without manual intervention:

1. **Schedule Trigger** - fires weekly (Mondays, 9am)
2. **HTTP Request** - fetches the most recent completed race from the jolpica API using the `/current/last/` endpoint
3. **Code node** (JavaScript) - extracts driver, constructor, grid and finish position from the nested JSON
4. **Convert to File** - outputs as CSV

## Known limitations

### Data and schema

- `races.circuit_name` stores the race name (e.g. "Australian Grand Prix") rather than the circuit (e.g. "Albert Park"). These should be separate columns.
- `races.race_date` is not populated, though the API provides it.
- No `constructors` table - team data is joined from CSV rather than stored relationally.
- Constructor naming is inconsistent across seasons (e.g. "RB F1 Team" vs "Racing Bulls"). Entity resolution would be needed before combining multiple seasons.

### Analysis

- The position-change metric partly reflects where teams qualify, since gaining places is easier from the back of the grid.
- Only 2025 season data was used for modelling; more seasons would give a more robust model.

### Automation

- n8n runs in a Docker container and cannot reach the local MySQL instance without additional network configuration, so output is written to file rather than inserted directly into the database.
- The n8n Python runner is unavailable in the standard Docker image; the transform node uses JavaScript instead.
- The schedule only fires while the container is running. Production deployment would require hosting n8n on a persistent server.
- The pipeline collects current-season (2026) data while the model is trained on 2025. Reconciling the two - retraining across multiple seasons and handling constructor renames - is the next development step.

## Setup

Requires a local MySQL instance and a `config.py` file in the project root (gitignored) containing database credentials.

## Progress

- [x] Data extraction from API
- [x] MySQL schema design and ETL pipeline
- [x] Exploratory data analysis
- [x] Baseline and improved prediction models
- [x] Tableau dashboard
- [x] n8n automated pipeline
- [ ] Multi-season data and model retraining
- [ ] Forward prediction: predict upcoming races before they run
