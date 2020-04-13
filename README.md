# Image Cleanup

This gem is designed to cleanup duplicates images contained in a folder


<!-- ## Installation

Add this line to your application's Gemfile:

```ruby
gem 'image-cleanup'
``` -->

## Usage

### CLI

1. open cli by running the command from the root directory of this repo
```bash
bin/cli
```
2. load a folder
```ruby
folder = ImageCleanup::Folder.new("/Users/achadee/desktop/")
```
3. find the duplicates
```ruby
log = true # set this if you want to just display to STOUT, otherwise a folder object will be returned
folder.find_duplicate_images log
```
OUTPUT (if log is set to true)
```
-------------------------
Found duplicates
-------------------------
should_be_ok.gif
      ===> Screen Shot 2019-03-09 at 10.35.45 am.png
Screen Shot 2020-03-29 at 5.57.46 pm.png
      ===> Screen Shot 2020-03-29 at 5.57.46 pm copy.png
Screen Shot 2019-03-09 at 10.35.07 am.png
      ===> Screen Shot 2019-03-09 at 10.35.07 am copy 2.png
      ===> Screen Shot 2019-03-09 at 10.35.07 am copy.png
Screen Shot 2019-03-09 at 10.35.27 am copy.png
      ===> Screen Shot 2019-03-09 at 10.35.27 am.png
```

## Tests

Run the tests using the command
```bash
ruby test/models/folder_test.rb
ruby test/models/image_test.rb
```
