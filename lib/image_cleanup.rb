module ImageCleanup
  # for when a file outside of jpg, png, and gif is used
  class FileTypeNotSupported < StandardError; end

  # colors for output
end

class String
  def bold;           "\e[1m#{self}\e[22m" end
end

require_relative 'models/base'
require_relative 'models/image'
require_relative 'models/folder'
