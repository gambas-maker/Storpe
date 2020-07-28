class PromotionJob < ApplicationJob
  queue_as :default

  def perform
    @championships = Championship.all
    @playerseasons = PlayerSeason.all
    @forecasts = Forecast.where(season_id: Season.last.id)
    @championships.each do |championship|
      ranking = {}
      championship.player_seasons.each { |hash| ranking[hash] = hash.number_of_points }
      if championship.player_seasons.count >= 8
        ranking.sort_by { |k, v| v }.reverse.first(4)
        puts ranking.sort_by { |k, v| k.forecasts.where(season_id: Season.last.id).exists? v }.reverse.last(4)
        if championship.name == "CFA"
          if Championship.where(name: "LDC").exists? && Championship.where(name: "LDC").playerseasons.count < 20
            ranking.each { |x| x.update(championship_id: Championship.where(name: "LDC")) }
          else
            Championship.create!(name: "LDC", season_id: Season.last.id)
            puts ranking.class
            ranking.each { |x| puts x }
          end
        elsif championship.name == "LDC"
        end
      else
        array = []
        array_1 = []
        puts array << ranking.sort_by { |k, v| v }.reverse.first(2)
        puts array_1 << ranking.sort_by { |k, v| k.forecasts.where(season_id: Season.last.id).exists? v }.reverse.last(2)
      end
    end
  end
end
