module ImageCleanup
  class Base

    # returns the name of the folder or image
    def name
      path || bass_path
    end

  end
end
