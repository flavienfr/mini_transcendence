class HandleWarEndingJob < ApplicationJob
  queue_as :default

  def perform(war_id)

    war = War.find(war_id)
    # Do something later
  end
end

# example

  # War.set(wait: 2.seconds).perform_later(1)
