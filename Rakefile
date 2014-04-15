require 'rubygems'
require 'rake'

require File.join(File.dirname(__FILE__), 'lib', 'uuidtools', 'version')

PKG_DISPLAY_NAME   = 'UUIDTools'
PKG_NAME           = PKG_DISPLAY_NAME.downcase
PKG_VERSION        = UUIDTools::VERSION::STRING
PKG_FILE_NAME      = "#{PKG_NAME}-#{PKG_VERSION}"

RELEASE_NAME       = "REL #{PKG_VERSION}"

GIT_HUB_USER       = "sporkmonger"
GIT_HUB_URL        = "https://github.com/#{GIT_HUB_USER}/#{PKG_NAME}"

PKG_AUTHOR         = "Bob Aman"
PKG_AUTHOR_EMAIL   = "bob@sporkmonger.com"
PKG_HOMEPAGE       = GIT_HUB_URL
PKG_SUMMARY        = "UUID generator"
PKG_DESCRIPTION    = <<-TEXT
A simple universally unique ID generation library.
TEXT

PKG_FILES = FileList[
    "lib/**/*", "spec/**/*", "vendor/**/*",
    "tasks/**/*", "website/**/*",
    "[A-Z]*", "Rakefile"
].exclude(/database\.yml/).exclude(/[_\.]git$/).exclude(/Gemfile/).exclude(/Gemfile\.lock/)

task :default => "spec"

WINDOWS = (RUBY_PLATFORM =~ /mswin|win32|mingw|bccwin|cygwin/) rescue false
SUDO = WINDOWS ? '' : ('sudo' unless ENV['SUDOLESS'])

Dir['tasks/**/*.rake'].each { |rake| load rake }
