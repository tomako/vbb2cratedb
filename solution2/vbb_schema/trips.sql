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
