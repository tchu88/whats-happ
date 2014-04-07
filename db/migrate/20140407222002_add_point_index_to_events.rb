class AddPointIndexToEvents < ActiveRecord::Migration
  def up
    execute %{
      create index index_on_events_location ON events using gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || events.longitude || ' ' || events.latitude || ')'
        )
      )
    }
  end

  def down
    execute %{drop index index_on_events_location}
  end
end
