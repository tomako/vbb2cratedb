CREATE TABLE shapes (
  shape_id              text,               -- TODO: ID vs Primary key
  shape_pt_lat          double precision NOT NULL,
  shape_pt_lon          double precision NOT NULL,
  shape_pt_sequence     integer NOT NULL,
  shape_dist_traveled   real
);
