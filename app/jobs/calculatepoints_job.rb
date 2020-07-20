class CalculatepointsJob < ApplicationJob
  queue_as :default
  def perform
    @matches = Match.where(event_stamp: Date.today.to_s)
    @forecasts = Forecast.where(season_id: Season.last.id)
    @matches.each do |match|
      match.forecasts.each do |forecast|
        if match.result[0].to_i > match.result[2].to_i && forecast.outcome == "1"
          forecast.update(points_win: match.points_home)
        elsif match.result[0].to_i == match.result[2].to_i && forecast.outcome == "NULL"
          forecast.update(points_win: match.points_draw)
        elsif match.result[0].to_i < match.result[2].to_i && forecast.outcome == "2"
          forecast.update(points_win: match.points_away)
        end
        if match.result[0].to_i > match.result[2].to_i && forecast.outcome == "NULL"
          forecast.update(points_lose: match.negative_points_draw)
        elsif match.result[0].to_i < match.result[2].to_i && forecast.outcome == "NULL"
          forecast.update(points_lose: match.negative_points_draw)
        elsif match.result[0].to_i > match.result[2].to_i && forecast.outcome == "2"
          forecast.update(points_lose: match.negative_points_away)
        elsif match.result[0].to_i == match.result[2].to_i && forecast.outcome == "2"
          forecast.update(points_lose: match.negative_points_away)
        elsif match.result[0].to_i == match.result[2].to_i && forecast.outcome == "1"
          forecast.update(points_lose: match.negative_points_home)
        elsif match.result[0].to_i < match.result[2].to_i && forecast.outcome == "1"
          forecast.update(points_lose: match.negative_points_home)
        end
      end
    end
  end
end
