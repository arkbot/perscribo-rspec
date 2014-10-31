require 'perscribo/support/core/io'

require 'rspec/core/formatters/progress_formatter'

module Perscribo
  module RSpec
    class Formatter < ::RSpec::Core::Formatters::ProgressFormatter
      ::RSpec::Core::Formatters.register self, :dump_summary

      def initialize(*args)
        super(*args)
        @output = Support::Core::IO.hook!(@output, :info)
      end

      def dump_summary(summary)
        update_level?(summary)
        super
      end

      private

      def reset_level(level = :info)
        @output.level = level
        @output.puts if level == :info
      end

      # TODO: This could use some refactoring.
      def update_level?(summary)
        if summary.failure_count > 0
          reset_level(:failure)
        elsif summary.pending_count > 0
          reset_level(:pending)
        elsif summary.example_count > 0
          reset_level(:success)
        end
      end
    end
  end
end
