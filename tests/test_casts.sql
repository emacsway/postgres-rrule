BEGIN;

SELECT plan(4);

SET search_path TO public, _rrule;

SELECT is(
  '{"dtstart": "19970902T090000", "dtend": "19970903T090000", "rrule": {"freq": "WEEKLY", "count": 4}}'::text::jsonb::_rrule.RRULESET,
  $$
    ("1997-09-02 09:00:00","1997-09-03 09:00:00","(WEEKLY,1,4,,,,,,,,,,,MO)","(,,,,,,,,,,,,,)",,)
  $$,
  'when jsonb is cast to RRULESET.'
);

SELECT is(
  _rrule.rruleset_to_jsonb('{"dtstart": "19970902T090000", "dtend": "19970903T090000", "rrule": {"freq": "WEEKLY", "count": 4}}'::text::jsonb::_rrule.RRULESET),
  $$
    {"dtend": "1997-09-03T09:00:00", "rrule": {"freq": "WEEKLY", "wkst": "MO", "count": 4, "interval": 1 }, "exrule": {}, "dtstart": "1997-09-02T09:00:00"}
  $$,
  'when RRULESET is cast to jsonb.'
);

SELECT is(
  '{"freq": "WEEKLY", "count": 4}'::text::jsonb::_rrule.RRULE::jsonb,
  $$
    {"freq": "WEEKLY", "wkst": "MO", "count": 4, "interval": 1}
  $$,
  'when RRULE is cast to jsonb.'
);

SELECT is(
  '{"freq": "WEEKLY", "count": 4}'::text::jsonb::_rrule.RRULE,
  $$
    (WEEKLY,1,4,,,,,,,,,,,MO)
  $$,
  'when jsonb is cast to RRULE.'
);


SELECT * FROM finish();

ROLLBACK;