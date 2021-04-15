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
