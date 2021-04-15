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
