RSpec::Matchers.define :fail_on do |step|
  chain :with do |*input|
    @input = input
    self
  end

  chain :and_return do |err|
    @err = err
  end

  chain :and_raise do |exc, message = nil|
    @exc = exc
    @exc_message = message unless message.nil?
  end

  match do |transaction|
    transaction.call(*@input) do |m|
      m.success do
        false
      end

      m.failure step do |err|
        return err == @err if instance_variable_defined?(:@err)

        if instance_variable_defined?(:@exc_message)
          return err.is_a?(@exc) && err.message == @exc_message
        end

        return err.is_a?(@exc) if instance_variable_defined?(:@exc)

        true
      end

      m.failure do
        false
      end
    end
  end
end
