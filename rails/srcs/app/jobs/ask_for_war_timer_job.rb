class AskForWarTimerJob < ApplicationJob
  queue_as :default

  rescue_from() do |exception|
    # Do something if the job generate an exception
    puts "hello from AskForWarTimerJob => exception"
  end

  def perform(ask_for_war_id)
    puts "hello from AskForWarTimerJob, ask_for_war_id = #{ask_for_war_id}"
    # Do something later
  end
end


# AskForWarTimerJob.set(wait: 2.seconds).perform_later(1)