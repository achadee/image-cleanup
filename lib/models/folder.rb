module ImageCleanup
  class Folder < Base

    attr_accessor :base_path
    attr_accessor :files

    def initialize base_path
      self.files = []
      self.base_path = base_path

      # remove all directories and sort by size
      Dir.entries(base_path).each do |f|
        next if f[0] == "." || File.directory?("#{base_path}/#{f}")

        begin
          # create a new image file
          file = Image.new(self.base_path, "#{f}")
          insert_at = self.files.bsearch_index { |f| f.size >= file.size }

          if insert_at

            # insert into ordered array so we can process faster in the next step
            self.files.insert(insert_at, file)
          else

            # otherwise just pop it into the array
            self.files << file
          end
        rescue ImageCleanup::FileTypeNotSupported
          # skipping non png / jpg / bpm / gif
          # puts "Skipping... " + "#{f}".bold
        end
      end
    end

    def find_duplicate_images log=false
      # we are using a dynamic programming technique that skips over files with the
      # same size, so we have to use a traditional loop in ruby
      duplicates = {}
      count = 0
      # worst case complexity is O(n2)
      i = 0
      while (i < self.files.length-1)
        # determine the size of the current file
        size = self.files[i].size

        # switch the iterator to the next file straight away
        j = i+1

        # only compare files that are the exact same size, since array is sorted
        # we can loop over the images that follow the next biggest image
        while (self.files[j].size == size)

          # compare images here, the complexity of the comparator O(n) but is
          # unlikely to hit this unless the images are all one byte difference
          # and the exact same size
          if self.files[i] == self.files[j]
            count = count + 1
            duplicates[self.files[i].path] = [] if !duplicates[self.files[i].path]
            duplicates[self.files[i].path] << self.files[j]
          end

          j = j + 1
        end
        # because we skip the iterator the comoplexity of these two loops is O(n)
        i=j
      end

      # simple log function for people that only care about diplaying stuff
      if log
        puts "Found #{count} duplicates"
        puts "-------------------------"
        duplicates.each do |comparer, dups|
          puts comparer.bold
          dups.each {|d| puts "      ===> #{d.path}"}
        end
        return true
      end

      return duplicates, count
    end

  end
end

# ImageCleanup::Folder.new("/Users/achadee/Desktop/").find_duplicate_images
