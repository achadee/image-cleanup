require_relative '../image_cleanup_test'

class ImageTest < Test::Unit::TestCase


  # do tests here
  test "should create a new directory object with a sorted image araay" do
    helper = ImageCleanupTest::Helper.new
    helper.create_image "i1", 3
    helper.create_image "i2", 2

    folder = ImageCleanup::Folder.new(helper.dir)

    assert_equal folder.files[0].path, "i2.png"
    assert_equal folder.files[1].path, "i1.png"

    helper.destroy
  end

  test "should create images of the same size but 2 different duplicates" do
    helper = ImageCleanupTest::Helper.new
    helper.create_duplicates "i", 3, "a"
    helper.create_duplicates "j", 3, "b"

    folder = ImageCleanup::Folder.new(helper.dir)

    folder.find_duplicate_images true


    #
    # assert_equal folder.files[0].path, "i2.png"
    # assert_equal folder.files[1].path, "i1.png"
    #
    # helper.destroy
  end

end
