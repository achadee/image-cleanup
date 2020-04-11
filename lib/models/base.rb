module ImageCleanup
  class Base

    # returns the name of the folder or image
    def name
      self.path || self.bass_path
    end

  end
end
