# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/ipfilter"

describe LogStash::Filters::Ipfilter do
  describe "Set to some example cases" do
    let(:config) do <<-CONFIG
      filter {
        ipfilter {
           ipfilled => "source_ip"
           database => "database.csv"
           search_column => "agency"
           search_target => "agencies"
         }
        ipfilter {
          ipfilled => "destination_ip"
          database => "database.csv"
          search_column => "agency"
          search_target => "agencies"
        }
      }
    CONFIG
    end

     sample("message" => "source_ip: 172.16.142.65, destination_ip: 172.16.144.15") do
       expect(subject.get("agencies")).to eq(["agency", "foo"])
    end
  end
end
