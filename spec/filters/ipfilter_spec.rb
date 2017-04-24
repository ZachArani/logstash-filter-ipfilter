# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/ipfilter"

describe LogStash::Filters::Ipfilter do
  describe "Set to some example cases" do
    let(:config) do <<-CONFIG
      filter {
        ipfilter {
          database => "database.csv"
          ip_filled => "source_ip"
          aggregate_column => "agency"
          aggregate_target => "agencies"
        }
      }
    CONFIG
    end

    sample("source_ip" => "172.16.142.65") do
      expect(subject).to include("iplookup_source_ip")
      # expect(subject.get('message')).to eq('Hello World')
    end
  end
end
