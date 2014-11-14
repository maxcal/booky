require 'zeus/rails'

class CustomPlan < Zeus::Rails

  # @see https://github.com/burke/zeus/issues/213
  def test
    exit RSpec::Core::Runner.run(ARGV)
  end

end

Zeus.plan = CustomPlan.new
