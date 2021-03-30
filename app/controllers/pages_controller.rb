class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def about
  end

  def contact
  end

  def rules
  end

  def settings
    @blasons = Blason.all
  end

  def confidentialite
  end

  def dashboard
    @matchestoday = Match.where(event_stamp: Date.today.to_s, sport: "football")
    @matchestomorrow = Match.where(event_stamp: Date.tomorrow.to_s, sport: "football")
    @matchesdayafter = Match.where(event_stamp: (Date.tomorrow+1).to_s, sport: "football")
    @matchesbasketoday = Match.where(event_stamp: Date.tomorrow.to_s, sport: "basketball")
    @matches = Match.where(event_stamp: Date.yesterday.to_s, sport: "football")
    @matchesbasket = Match.where(event_stamp: Date.today.to_s, sport: "basketball")
    @championshippro = Championship.where(name: "Pro")
    @championshipchamp = Championship.where(name: "Champion")
    @championshipsemi = Championship.where(name: "Semi-pro")
    @championshipama = Championship.where(name: "Amateur")
  end
end
