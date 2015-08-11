namespace :line_server do
  desc "Create a sample text file"
  task generate_source: :environment do
    puts "Creating new source file"

    File.open "#{Rails.root}/data/lines.txt", "w" do |lines_file|
      1_000.times do |i|
        lines_file.puts "This is line #{i} (#{Time.now})"
      end
    end
  end

  desc "Load source file into Redis"
  task source_redis: :environment do
    puts "Sourcing redis"
    RedisSourcer.source
  end
end
