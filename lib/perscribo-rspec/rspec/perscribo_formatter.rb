module RSpec
  module Core
    module Formatters
      require 'perscribo'
      require 'rspec/core/formatters/progress_formatter'
      
      class PerscriboFormatter < ProgressFormatter
        RSpec::Core::Formatters.register self, :dump_summary

        def initialize(*args)
          super(*args)
          @output.singleton_class.send(:prepend, ::Perscribo::IO)
          reset_label
        end

        def dump_summary(summary)
          update_label?(summary)
          super
        end

        private

        def reset_label(label = :info)
          @output.label = label
          @output.puts if label == :info
        end

        def update_label?(summary)
          if summary.failure_count > 0
            reset_label(:failure)
          elsif summary.pending_count > 0
            reset_label(:pending)
          elsif summary.example_count > 0
            reset_label(:success)
          end
        end
      end
    end
  end
end
