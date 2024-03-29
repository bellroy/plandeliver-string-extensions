require File.dirname(__FILE__) + '/spec_helper'

describe String do
  
  describe "numeric?" do
    %w[0 0.1 1 -1 1.0 1.1 99 99.123].each do |value|
      it "should return true for '#{value}'" do
        value.should be_numeric
      end
    end
    
    %w[abc a1b 1. .1 1.a a.1 1\ 0].each do |value|
      it "should return false for '#{value}'" do
        value.should_not be_numeric
      end
    end
  end
  
  describe "date?" do
    %w[1/1 1/1/2009 1/1/09 31/1/2009 31/12/2009].each do |value|
      it "should return true for '#{value}'" do
        value.should be_date
      end
    end
    
    %w[abc 1\ 1 1\ 1\ 2009 32/1/9 1/b/09].each do |value|
      it "should return false for '#{value}'" do
        value.should_not be_date
      end
    end
  end
  
  describe "time?" do
    %w[9:00 09:00 9am 9pm 9AM 9PM].each do |value|
      it "should return true for '#{value}'" do
        value.should be_time
      end
    end
    
    %w[abc 9 09 090 09\ 00 9\ am 9\ pm].each do |value|
      it "should return false for '#{value}'" do
        value.should_not be_time
      end
    end
  end
  
  describe "typed" do
    it "should return the float value if the value is numeric" do
      "1.1".typed.should == 1.1
    end
    
    it "should parse the value with Chronic if the value is a date" do
      "1/1/2009".typed.should be_a(Date)
    end
    
    it "should pass in the reversed date, splitted at the dashes, with hyphens" do
      Chronic.should_receive(:parse).with "2009-12-24"
      "24/12/2009".typed
    end
    
    it "should parse the original value with chronic if the value is a time" do
      "09:00".typed.should be_a(Time)
    end
    
    it "should pass in the ref forwarded to typed" do
      Chronic.should_receive(:parse).with "ref 09:00"
      "09:00".typed "ref"
    end
    
    it "should return self if the value is neither numeric nor a date" do
      "abc".typed.should == "abc"
    end
    
    it "should downcase the string when self is returned" do
      "aBc".typed.should == "abc"
    end
  end
end