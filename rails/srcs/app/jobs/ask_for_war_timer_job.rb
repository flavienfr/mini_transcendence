class AskForWarTimerJob < ApplicationJob
  queue_as :default

  def perform(ask_for_war_id)
    puts "hello from AskForWarTimerJob, ask_for_war_id = #{ask_for_war_id}"
  
    # begin
    #   
    # rescue => e
    #   puts "exception: #{e}"
    # end

    # Do something later
    #
    #
    #

  end
end

# examples

# wait: x.time for now
  # AskForWarTimerJob.set(wait: 2.seconds).perform_later(1)
  # AskForWarTimerJob.set(wait: 2.hours).perform_later(1)

# wait_until: Date.tomorrow.noon
