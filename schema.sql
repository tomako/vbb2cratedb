DROP TABLE IF EXISTS agency;
DROP TABLE IF EXISTS calendar;
DROP TABLE IF EXISTS calendar_dates;
DROP TABLE IF EXISTS frequencies;
DROP TABLE IF EXISTS pathways;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS shapes;
DROP TABLE IF EXISTS stop_times;
DROP TABLE IF EXISTS stops;
DROP TABLE IF EXISTS transfers;
DROP TABLE IF EXISTS trips;

CREATE TABLE agency
(
  agency_id         text PRIMARY KEY,
  agency_name       text NOT NULL,
  agency_url        text NOT NULL,
  agency_timezone   text NOT NULL,
  agency_lang       text,
  agency_phone      text,
  agency_fare_url   text,
  agency_email      text
);

CREATE TABLE calendar
(
  service_id        text PRIMARY KEY,
  monday            smallint NOT NULL,
  tuesday           smallint NOT NULL,
  wednesday         smallint NOT NULL,
  thursday          smallint NOT NULL,
  friday            smallint NOT NULL,
  saturday          smallint NOT NULL,
  sunday            smallint NOT NULL,
  start_date        text NOT NULL,
  end_date          text NOT NULL
);

CREATE TABLE calendar_dates
(
  service_id        text PRIMARY KEY,
  date              text    PRIMARY KEY,
  exception_type    integer NOT NULL
);

CREATE TABLE frequencies
(
  trip_id           text NOT NULL,
  start_time        text NOT NULL,
  end_time          text NOT NULL,
  headway_secs      integer NOT NULL,
  exact_times       text
);

CREATE TABLE pathways
(
  pathway_id                text PRIMARY KEY,
  from_stop_id              text NOT NULL,
  to_stop_id                text NOT NULL,
  pathway_mode              smallint NOT NULL,
  is_bidirectional          smallint NOT NULL,
  length                    real,
  traversal_time            integer,
  stair_count               integer,
  max_slope                 real,
  min_width                 real,
  signposted_as             text,
  reversed_signposted_as    text
);

CREATE TABLE routes
(
  route_id              text PRIMARY KEY,
  agency_id             text,
  route_short_name      text,
  route_long_name       text,
  route_desc            text,
  route_type            smallint NOT NULL,  -- TODO: Seemingly invalid values in the CSV
  route_url             text,
  route_color           text,
  route_text_color      text,
  route_sort_order      integer,
  continuous_pickup     text,
  continuous_drop_off   text
);

CREATE TABLE shapes (
  shape_id              text,               -- TODO: ID vs Primary key
  shape_pt_lat          double precision NOT NULL,
  shape_pt_lon          double precision NOT NULL,
  shape_pt_sequence     integer NOT NULL,
  shape_dist_traveled   real
);

CREATE TABLE stop_times (
  trip_id               text NOT NULL,
  arrival_time          text,
  departure_time        text,
  stop_id               text NOT NULL,
  stop_sequence         integer NOT NULL,
  stop_headsign         text,
  pickup_type           text,
  drop_off_type         text,
  continuous_pickup     text,
  continuous_drop_off   text,
  shape_dist_traveled   real,
  timepoint             text
);

CREATE TABLE stops (
  stop_id               text PRIMARY KEY,
  stop_code             text,
  stop_name             text,
  stop_desc             text,
  stop_lat              double precision,
  stop_lon              double precision,
  zone_id               text,
  stop_url              text,
  location_type         text,
  parent_station        text,
  stop_timezone         text,
  wheelchair_boarding   text,
  level_id              text,
  platform_code         text
);

CREATE TABLE transfers (
  from_stop_id          text NOT NULL,
  to_stop_id            text NOT NULL,
  transfer_type         text NOT NULL,
  min_transfer_time     text            -- TODO: Invalid column type (it should be int)
) WITH ( column_policy = 'dynamic');    -- TODO: Invalid fields in the CSV

CREATE TABLE trips (
  route_id              text NOT NULL,
  service_id            text NOT NULL,
  trip_id               text PRIMARY KEY,
  trip_headsign         text,
  trip_short_name       text,
  direction_id          smallint,
  block_id              text,
  shape_id              text,
  wheelchair_accessible text,
  bikes_allowed         text
);
