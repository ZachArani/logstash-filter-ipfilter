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
  # filter {
  #    {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "ipfilter"
  
  # Replace the message with this value.
  config :ipfilled, :validate => :string, :default => ""
  config :database, :validate => :string, :default => ""
  config :search_column, :validate => :string, :default => ""
  config :search_target, :validate => :string, :default => ""
    

  public
  def register
    # Add instance variables 
    
  end # def register

  public
  def filter(event)
    if @ipfilled && @database && @search_column && @search_target
      ip = event.get(@ipfilled) 
      CSV.foreach('database.csv', headers:true) do |row|
          subnet = row[0]
          if subnet[0..9] == ip[0..9]
            #event.set(event.get(@search_target), event.get(@search_target) << row[1]) #Attempt to append agency to already existing array
            event.set("[ipfilter_" << @ip_filled << "][ip]", ip)
            event.set("[ipfilter_" << @ip_filled << "][network]", subnet)
            event.set("[ipfilter_" << @ip_filled << "][agency]", row[@search_column])
            event.set("[ipfilter_" << @ip_filled << "][description]", row[@search_target])
          end
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Ipfilter