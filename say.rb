require 'optparse'
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: say.rb [options]"

  #default value
  options[:output] = 'audio.en.mp3'

  opts.on("-i", "--input TEXTFILE", "MANDATORY text file input") do |i|
    options[:input] = i
  end
  opts.on("-o", "--output FILENAME", "audio output file, default=#{options[:output]}") do |o|
    options[:output] = o
  end
end.parse!

unless options[:input]
  logger.error 'Missing option: -i, --input'
  raise OptionParser::MissingArgument
end

input_file = options[:input]
out_file = options[:output]

logger.info "Using #{input_file} as text source."
logger.info "Creating audio in #{out_file}."

say = ''

File.open(input_file, 'r') do |f|
  f.each do |line|
    say << line unless line[0] == '#' or line[0,4] == '    '
  end
end

success = system "say", say,  "-o", "audio.aiff"
unless success
  logger.info "failed to create audio file from #{input_file}"
  Kernel.exit 1
end

#remove unnecesary audio.aiff file at exit
at_exit do
  File.unlink "audio.aiff"
end

#convert .aiff to .mp3
success = system "ffmpeg", "-i", "audio.aiff", out_file
unless success
  logger.info "failed to create #{out_file} from audio.aiff"
  Kernel.exit 1
end

audio_ogg = File.basename(out_file, File.extname(out_file))

#convert .mp3 to .ogg
success = system "ffmpeg", "-i", "audio.aiff", audio_ogg
unless success
  logger.info "failed to create #{audio_ogg} file from audio.aiff"
  Kernel.exit 1
end
