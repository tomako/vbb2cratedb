CREATE TABLE frequencies
(
  trip_id           text NOT NULL,
  start_time        text NOT NULL,
  end_time          text NOT NULL,
  headway_secs      integer NOT NULL,
  exact_times       text
);
