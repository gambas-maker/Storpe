class CreateSeasonMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :season_matches do |t|
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
