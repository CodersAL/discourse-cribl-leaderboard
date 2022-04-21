# discourse-cribl-leaderboard

## Athena Setup

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

## Settings

The following settings are required to be set up:

Discourse site settings:

- `s3_access_key_id`
- `s3_secret_access_key`
- `s3_region`

this is assumed to be the same s3 location as backups, so it's leveraged for Athena connection.

Plugin setting:

- `cribl_leaderboard_s3_query_output_location`
