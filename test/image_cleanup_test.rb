require "test/unit"
require 'fileutils'
require_relative '../lib/image_cleanup'

# load the testing modules

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
        File.binwrite("temp/#{name}.png", "\x89PNG"+(0..size).map{|e| char }.join)
      when "gif"
        File.binwrite("temp/#{name}.gif", "GIF8"+(0..size).map{|e| char }.join)
      when "jpg"
        File.binwrite("temp/#{name}.jpg", "\xff\xd8\xff\xe0\x00\x10JFIF"+(0..size).map{|e| char }.join)
      else
        File.open("temp/#{name}.txt", "w") {|f| f.write("..."+(0..size).map{|e| char }.join)}
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
