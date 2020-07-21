class ChampionshipJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)
    @championships = Championship.where(name: "CFA")
    if PlayerSeason.exists?(user_id: @user.id)
    else
      PlayerSeason.create!(user_id: @user.id, season_id: Season.last.id, championship_id: 1)
    end
  end
end
