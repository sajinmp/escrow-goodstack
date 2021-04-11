require_relative 'input_data'

class InputCollection
  attr_accessor :inputs

  def initialize(str)
    @inputs = []
    inputs = str.split("\n")[0..-2]
    inputs.each do |input|
      @inputs << InputData.new(*format_input(input))
    end
    output
  end

  def format_input(input)
    input.split("|").map(&:strip).tap { |i| i[-1] = i[-1].split(',').map(&:strip) }
  end

  def output
    puts "\n\n"
    $users.each do |user|
      puts "Balance of #{user.name}: #{user.balance}"
    end
    puts "Escrow balance: #{Escrow.balance}"
  end
end
