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
