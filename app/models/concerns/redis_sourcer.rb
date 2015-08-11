module RedisSourcer
  def self.source
    path = ENV["DATA_SOURCE_PATH"] || "data"
    lines = File.open "#{Rails.root}/#{path}/lines.txt" do |file|
      file.readlines
    end

    $redis.flushall

    lines.each_with_index do |line, index|
      line.sub! /\n/, ""
      $redis.set "line:#{index}", line
    end
  end
end
