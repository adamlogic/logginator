require 'spec_helper'

describe LogEntry do
  describe ".collection" do
    it "returns a Mongo collection" do
      LogEntry.collection.should be_a(Mongo::Collection)
    end
  end
end
