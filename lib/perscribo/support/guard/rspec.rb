require 'perscribo/guard'

module Perscribo
  module Support
    module Guard
      module RSpec
        REQ_PATH = File.expand_path('../../../rspec/formatter.rb', __FILE__)
        OUT_PATH = "#{Dir.pwd}/tmp/perscribo_rspec_#{ENV['RACK_ENV']}.log"
        DEFAULTS = {
          labels: [:info, :failure, :success],
          guard_opts: {
            all_on_start: true,
            cmd: [
              'bundle exec rspec',
              '--color',
              '--tty',
              "--require #{REQ_PATH}",
              '--format Perscribo::RSpec::Formatter',
              "--out #{OUT_PATH}"
            ].join(' '),
            spec_paths: ['test/spec'],
            notification: true
          },
          path: OUT_PATH,
          watcher_opts: { }
        }

        ::Perscribo::Guard.capture!(self)
      end
    end
  end
end
