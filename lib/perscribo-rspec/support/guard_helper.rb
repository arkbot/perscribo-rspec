DEFAULT_RSPEC_RESULTS = "#{Dir.pwd}/tmp/perscribo_rspec.log"
DEFAULT_RSPEC_CLI = [
  '--tty',
  '--color',
  "--require #{File.dirname(__FILE__)}/../rspec/perscribo_formatter.rb",
  '--format RSpec::Core::Formatters::PerscriboFormatter',
  "--out #{DEFAULT_RSPEC_RESULTS}"
]
DEFAULT_RSPEC_OPTS = {
  all_on_start: true,
  cmd: "bundle exec rspec #{DEFAULT_RSPEC_CLI.join(' ')}",
  spec_paths: ['test/spec'],
  notification: true
}
log_output('RSpec', "#{DEFAULT_RSPEC_RESULTS}", :info, :failure, :success)
