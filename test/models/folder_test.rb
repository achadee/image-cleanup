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

  test "should create images of the same size but different content" do
    helper = ImageCleanupTest::Helper.new
    helper.create_duplicates "i", 3, "a"
    helper.create_duplicates "j", 3, "b"

    folder = ImageCleanup::Folder.new(helper.dir)

    duplicates = folder.find_duplicate_images

    assert_equal duplicates.count, 2

    helper.destroy
  end

  test "should create images of the same size and content" do
    helper = ImageCleanupTest::Helper.new
    helper.create_duplicates "i", 3, "b"
    helper.create_duplicates "j", 3, "b"
    helper.create_duplicates "j", 3, "b"

    folder = ImageCleanup::Folder.new(helper.dir)

    duplicates = folder.find_duplicate_images

    assert_equal duplicates.count, 1

    helper.destroy
  end

  test "should not return output when logging is set to true" do
    helper = ImageCleanupTest::Helper.new
    folder = ImageCleanup::Folder.new(helper.dir)

    duplicates = folder.find_duplicate_images true

    assert_equal duplicates, nil

    helper.destroy
  end

end
