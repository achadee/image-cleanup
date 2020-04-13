require_relative '../image_cleanup_test'

class ImageTest < Test::Unit::TestCase
  # do tests here
  test "should create a file object only if it is one of the 3 supported file types" do
    helper = ImageCleanupTest::Helper.new

    helper.create_image "i1", 3, "png"
    helper.create_image "i2", 2, "gif"
    helper.create_image "i3", 2, "jpg"

    helper.create_image "i4", 2, "txt"

    i1 = ImageCleanup::Image.new("temp", "i1.png")
    i2 = ImageCleanup::Image.new("temp", "i2.gif")
    i3 = ImageCleanup::Image.new("temp", "i3.jpg")

    assert_raise ImageCleanup::FileTypeNotSupported do
      i4 = ImageCleanup::Image.new("temp", "i4.txt")
    end

    assert_not_empty i1.path
    assert_not_empty i2.path
    assert_not_empty i3.path

    helper.destroy
  end

  test "should compare 2 of the same images" do
    helper = ImageCleanupTest::Helper.new

    helper.create_image "i1", 2, "png"
    helper.create_image "i2", 2, "png"

    i1 = ImageCleanup::Image.new("temp", "i1.png")
    i2 = ImageCleanup::Image.new("temp", "i2.png")

    assert_equal i1, i2

    helper.destroy
  end

  test "should compare 2 different images" do
    helper = ImageCleanupTest::Helper.new

    helper.create_image "i1", 2, "png", "a"
    helper.create_image "i2", 2, "png", "b"

    i1 = ImageCleanup::Image.new("temp", "i1.png")
    i2 = ImageCleanup::Image.new("temp", "i2.png")

    assert_not_equal i1, i2

    helper.destroy
  end

end
