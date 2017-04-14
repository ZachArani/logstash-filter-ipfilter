# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/ipfilter"

describe LogStash::Filters::Ipfilter do
  describe "Set to some example cases" do
    let(:config) do <<-CONFIG
      filter {
        ipfilter {
          message => "Hello World"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect(subject).to include("message")
      expect(subject.get('message')).to eq('Hello World')
    end
  end
end
