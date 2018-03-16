# Input your code here
require 'pry'
require 'csv'
require './lib/user'
require './lib/args_validator'


if ArgsValidator.args_valid?(ARGV)
  if User.import_from_file(ARGV[1])
    User.search(ARGV[2..-1])
  end
end
