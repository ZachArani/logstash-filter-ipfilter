# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "csv"

#TODO: Actually take those new commands and do things with them (set up on 24-27)
# This  filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Ipfilter < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # ipfilter {
  #    {
  #     database => "somecsv.csv"
  #     ipfilled => "the name of the ip we're looking for"
  #     search_column => "what column in the csv we're trying to search for"
  #     search_target => "Name of the array where we put our results"
  #   }
  # }
  #
  config_name "ipfilter"
  
  # Replace the message with this value.
  config :ipfilled, :validate => :string, :default => ""
  config :database, :validate => :string, :default => ""
  config :search_column, :validate => :string, :default => ""
  config :search_target, :validate => :string, :default => ""
  config :message, :validate => :string, :default => "Hello World!"

  public
  def register
    # Add instance variables 
    
  end # def register

  public
  def filter(event)
    ip =""
    ipname = ""
    CSV.parse(event.get("message")) do |row| # Parse the message
      for line in row #for each ip in the message
        ipname = line.partition(":").first().strip # get name of ip
        if(ipname==@ipfilled) #Check if the name is equal to what we're searching for
          ip = line.partition(":").last().strip #get ip
          break
        end
      end
    end
    CSV.foreach(@database, headers:true) do |row| #iterate through database 
      subnet = row[0] #get subnet 
      if subnet[0..9] == ip[0..9] #if they match, add all of the fields 
        event.set("[iplookup_" + ipname + "][ip]", ip) #add ip
        event.set("[iplookup_" + ipname + "][network]", subnet) #add subnet
        event.set("[iplookup_" + ipname + "][" + @search_column + "]", row[@search_column]) #add the search column
        event.set("[iplookup_" + ipname + "][description]", row['description' ]) #add the description
        if(event.get(@search_target) == nil)
          event.set(@search_target, [@search_column])  
        else
          event.set(@search_target, event.get(@search_target) + [row[@search_column]])
          end 
        end 
      end
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Ipfilter