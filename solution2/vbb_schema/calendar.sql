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
