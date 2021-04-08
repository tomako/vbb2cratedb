DROP TABLE IF EXISTS agency;
DROP TABLE IF EXISTS calendar;
DROP TABLE IF EXISTS calendar_dates;
DROP TABLE IF EXISTS frequencies;
DROP TABLE IF EXISTS pathways;
DROP TABLE IF EXISTS routes;

CREATE TABLE agency
(
  agency_id         integer PRIMARY KEY,
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
  service_id        integer PRIMARY KEY,
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
  service_id        integer PRIMARY KEY,
  date              text    PRIMARY KEY,
  exception_type    integer NOT NULL
);

CREATE TABLE frequencies
(
  trip_id           integer NOT NULL,
  start_time        text NOT NULL,
  end_time          text NOT NULL,
  headway_secs      integer NOT NULL,
  exact_times       smallint
);

CREATE TABLE pathways
(
  pathway_id                integer PRIMARY KEY,
  from_stop_id              integer NOT NULL,
  to_stop_id                integer NOT NULL,
  pathway_mode              smallint NOT NULL,
  is_bidirectional          smallint NOT NULL,
  length                    float,
  traversal_time            integer,
  stair_count               integer,
  max_slope                 float,
  min_width                 float,
  signposted_as             text,
  reversed_signposted_as    text
);

CREATE TABLE routes
(
  route_id              text PRIMARY KEY,
  agency_id             integer,
  route_short_name      text,
  route_long_name       text,
  route_desc            text,
  route_type            smallint NOT NULL,  -- TODO: Seemingly invalid values in CSV
  route_url             text,
  route_color           text,
  route_text_color      text,
  route_sort_order      integer,
  continuous_pickup     smallint,
  continuous_drop_off   smallint
);
