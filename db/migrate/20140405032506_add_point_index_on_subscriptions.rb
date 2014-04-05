class AddPointIndexOnSubscriptions < ActiveRecord::Migration
  def up
    execute %{
      CREATE INDEX index_on_subscriptions_location ON subscriptions USING gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || subscriptions.longitude || ' ' || subscriptions.latitude || ')'
        )
      )
    }
  end

  def down
    execute %{
      DROP INDEX index_on_subscriptions_location
    }
  end
end
