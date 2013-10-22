require 'sinatra'

configure do
  set :bind, "0.0.0.0"
end

require "sinatra/reloader"

get '/' do
  puts '*'*100
  puts params.inspect
  Question.new(params[:q]).solve.to_s
end

class Question
  def initialize(question)
    @question = question
  end

  def split
    @question[10..-1]
  end

  def solve
    Solver.new(split).solve
  end
end

class Solver
  def initialize(question)
    @question = question
  end

  def solve
    if @question.match /the power/
      power_of
    elsif @question.match /what is/
      what_is
    elsif @question.match /largest/
      which_largest
    elsif @question.match /eiffel/
      'Paris'
    else
      1
    end
  end

  def what_is
    #match = @question.scan /(\d+)/
    #match = match.flatten
    #match[0].to_i + match[1].to_i
    first = @question.scan(/(\d+)/).first
    puts "first #{first}"
    plus = @question.scan(/plus (\d+)/)
    puts "plus #{plus.inspect}"
    minus = @question.scan(/minus (\d+)/)
    puts "minus #{minus.inspect}"
    multiplied = @question.scan(/multiplied by (\d+)/)
    puts "multiplied by #{multiplied.inspect}"
    score = first.flatten
    score += plus.flatten.inject(:+)
    puts "score #{score}"
    score
  end

  def which_largest
    match = @question.scan /(\d+)/
    match = match.flatten
    match.max
  end

  def power_of
    match = @question.scan(/(\d+)/).flatten
    match[0].to_i ** match[1].to_i
  end
end
