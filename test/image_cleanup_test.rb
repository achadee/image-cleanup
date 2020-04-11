require "test/unit"
require 'fileutils'
require_relative '../lib/image_cleanup'

# load the testing modules
require_relative 'models/image_test'
require_relative 'models/folder_test'

module ImageCleanupTest
  class Helper
    attr_accessor :dir


    def initialize
      Dir.mkdir 'temp' unless File.exists?('temp')
      self.dir = 'temp'
    end

    def create_image name, size, type="png", char=0

      case type
      when "png"
        File.open("temp/#{name}.png", "w") {|f| f.write(">PNG"+(0..12).map{|e| char }.join)}
      end
    end

    def create_duplicates name, amount, char=0
      amount.times.each_with_index do |image, index|
        self.create_image "#{name}#{index}", 5, "png", char
      end
    end


    def destroy
      FileUtils.rm_rf('temp')
    end
  end
end
