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