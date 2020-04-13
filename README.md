# Image Cleanup

This gem is designed to cleanup duplicates images contained in a folder


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'image-cleanup'
```

## Usage

### CLI

1. open cli
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

## Tests

Run the tests using the command
```bash
ruby test/models/folder_test.rb
ruby test/models/image_test.rb
```
