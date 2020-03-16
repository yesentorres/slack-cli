require "httparty"

class Recipient # abstract class 

  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  # ----- IMPLEMENTED METHODS -----

  # gets desired data from Slack API 
  def self.get(url)
    requested_data = HTTParty.get(url, query: {token: ENV["BOT_TOKEN"]})

    if requested_data.code != 200 || requested_data["ok"] == false
      raise SlackAPIError, "Encountered error: #{requested_data["error"]}"
    end 

    return requested_data
  end

  def send_message(message)

  end

  # ----- ABSTRACT METHODS -----

  def self.list_all
    raise NotImplementedError, "Implement me in a child class!"
  end

  def details
    raise NotImplementedError, "Implement me in a child class!"
  end

end

# created here so that it is accessible by all other classes in this project
class SlackAPIError < Exception
end