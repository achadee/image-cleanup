module ImageCleanup
  class Image < Base

    attr_accessor :base_path
    attr_accessor :path
    attr_accessor :name
    attr_accessor :extension
    attr_accessor :size
    attr_accessor :scanned

    # ImageCleanup::Image.new("/Users/achadee/Downloads/","IMG_0304\ copy\ 2.JPG")

    def initialize base_path, path

      #set the scanned value
      self.scanned = false

      # set the bass path
      self.base_path = base_path

      # set the path
      self.path = path

      # run once and save the true file type
      self.extension = file_type

      # calculate the size of the file
      self.size = File.size("#{self.base_path}/#{self.path}")

      # throw an exception if the file extension is not supported
      raise FileTypeNotSupported if !is_image?
      return true
    end

    def file_type
      io = IO.read("#{self.base_path}/#{self.path}", 10)

      return '.gif' if /^GIF8/n =~ io
      return '.jpg' if /^\xff\xd8\xff\xe0\x00\x10JFIF/n =~ io
      return '.jpg' if /^\xff\xd8\xff\xe1(.*){2}Exif/n =~ io
      return '.png' if /^\x89PNG/n =~ io

      return 'other'
    end

    # overide compare operator
    def == file

      f1 = File.open("#{base_path}/#{file.path}", 'r')
      f2 = File.open("#{base_path}/#{self.path}", 'r')

      # all will break on the first mismatch, and we are comparing line by line
      # rubys native string comparison will compare byte by byte, so loading lines
      # is just more efficient for memory

      # we also search the array backwards to be slightly more efficient, as we
      # will be skipping the header information
      f1.each_line.zip(f2.each_line).reverse_each.all? { |a,b| a == b }
    end

    def is_image?
      return self.extension != 'other'
    end

  end
end
