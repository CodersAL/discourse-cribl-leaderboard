# discourse-cribl-leaderboard

Please note, the Athena table scripts contain a LOCATION statement.

If an appropriately configured JSON file exists in this folder with data, it will be loaded in upon table creation.

e.g.

```
LOCATION
  's3://merefield-athena-test/source_data/points'
```

This location needs to reflect the folder that is actually being used.

Therefore these scripts need to be updated before running.

Please approach authors with any questions.
