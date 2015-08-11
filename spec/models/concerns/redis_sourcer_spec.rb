require "spec_helper"

describe RedisSourcer do
  describe ".source" do
    it "maps each line of the source to the correct redis key" do
      RedisSourcer.source

      expect($redis.get("line:0")).to eq "This is a test line 0"
    end
  end
end
