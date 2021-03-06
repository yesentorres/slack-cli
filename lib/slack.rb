#!/usr/bin/env ruby
require 'dotenv'
require "table_print"
require_relative "workspace"

Dotenv.load 

# prompts user for their input and records it
def prompt_action 
  puts "You have six options: list users, list channels, select user, select channel, display details, send message, or quit."
  puts "\n"
  print "Please enter your choice: "
  return gets.chomp.downcase
end

# controls command line interactivity 
def main
  
  workspace = Workspace.new

  puts "\n"
  puts "Welcome to the Ada Slack CLI! This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels."
  puts "\n"

  user_input = prompt_action

  until user_input == "quit"

    case user_input 

    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"
      puts "\n"

    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"

    when "select user"
      print "Please enter the user's username or ID: "
      requested_user = gets.chomp
      puts workspace.select_user(requested_user)
      puts "\n"

    when "select channel"
      print "Please enter the channel's name or ID: "
      requested_channel = gets.chomp
      puts workspace.select_channel(requested_channel)
      puts "\n"
    
    when "display details"
      if workspace.selected == nil
        puts "You must \"select user\" or \"select channel\" first."
        puts "\n"
      else
        workspace.display_details
        user_input = nil
        puts "\n"
      end

    when "send message"
      if workspace.selected == nil
        puts "You must \"select user\" or \"select channel\" first."
        puts "\n"
      else
        print "Enter your message: "
        message = gets.chomp
        workspace.send_message(message)
        user_input = nil
        puts "\n"
      end
    
    else 
      puts "\n"
      puts "I cannot perform \"#{user_input}\". Please try again ->"
      puts "\n"
    end 

    user_input = prompt_action # call again until valid input is provided
  end 

  puts "\n"
  puts "Okay, thank you for using the Ada Slack CLI. Goodbye!"

end

main if __FILE__ == $PROGRAM_NAME