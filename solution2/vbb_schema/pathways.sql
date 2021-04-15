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
