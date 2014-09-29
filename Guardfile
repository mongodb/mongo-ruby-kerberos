# vim:set filetype=ruby:
guard(
  "rspec",
  :all_after_pass => false,
  :cmd => 'bundle exec rspec --tty --format documentation --colour --fail-fast') do

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |match| "spec/#{match[1]}_spec.rb" }
end
