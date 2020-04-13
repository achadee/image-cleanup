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

    def scan_specific_size_from_iteration comparer, duplicates, i
      return duplicates if self.files[i].nil? || comparer.scanned
      # only compare files that are the exact same size, since array is sorted
      # we can loop over the images that follow the next biggest image
      if self.files[i].size == comparer.size
        if comparer == self.files[i]
          duplicates[comparer.path] = [] if !duplicates[comparer.path]
          duplicates[comparer.path] << self.files[i]
          self.files[i].scanned = true
        else
          # set a new comparer and look at i+1
          duplicates.merge(scan_specific_size_from_iteration self.files[i], duplicates, i+1)
        end
        # skip over the current i and look at the next one with the current comparer
        duplicates.merge(scan_specific_size_from_iteration comparer, duplicates, i+1)
      end

      return duplicates.merge(scan_specific_size_from_iteration self.files[i], duplicates, i+1)
    end

    def find_duplicate_images log=false
      # we are using a dynamic programming technique that skips over files with the
      # same size
      duplicates = scan_specific_size_from_iteration self.files[0], {}, 1

      # simple log function for people that only care about diplaying stuff
      log ? log_duplicates(duplicates) : duplicates
    end

    def log_duplicates duplicates
      if duplicates.count > 0
        puts "-------------------------"
        puts "Found duplicates"
        puts "-------------------------"
        duplicates.each do |comparer, dups|
          puts comparer.bold
          dups.each {|d| puts "      ===> #{d.path}"}
        end
      end
      return
    end

  end
end

# folder = ImageCleanup::Folder.new("/Users/achadee/Projects/interviews/cogent/temp").find_duplicate_images
