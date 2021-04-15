class ResultsYesterdayJob < ApplicationJob
  queue_as :default

  def perform
    puts "Let's get the football results"
    @matches = Match.where(event_stamp: Date.yesterday.to_s - 1, sport: "football")
    @matches.each do |game|
      SportOdd.get_results_for_match(game)
    end
    CalculatepointsYesterdayJob.perform_now
    RecalcpointsJob.perform_now
  end
end
