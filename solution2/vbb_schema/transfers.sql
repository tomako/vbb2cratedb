CREATE TABLE transfers (
  from_stop_id          text NOT NULL,
  to_stop_id            text NOT NULL,
  transfer_type         text NOT NULL,
  min_transfer_time     text            -- TODO: Invalid column type (it should be int)
) WITH ( column_policy = 'dynamic');    -- TODO: Invalid fields in the CSV
