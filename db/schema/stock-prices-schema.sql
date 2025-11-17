-- Enable TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Stock prices table
CREATE TABLE  IF NOT EXISTS STOCK_PRICES (
    TIME TIMESTAMPTZ NOT NULL,
    SYMBOL TEXT NOT NULL,
    OPEN DOUBLE PRECISION,
    HIGH DOUBLE PRECISION,
    LOW DOUBLE PRECISION,
    CLOSE DOUBLE PRECISION,
    VOLUME BIGINT
);

-- Convert to TimescaleDB hypertable
SELECT create_hypertable('STOCK_PRICES', 'TIME', if_not_exists => TRUE);

-- Create index for fast symbol lookups
CREATE INDEX IF NOT EXISTS IDX_STOCK_PRICES_SYMBOL_TIME
ON STOCK_PRICES (SYMBOL, TIME DESC);

-- Verify table was created
\dt

