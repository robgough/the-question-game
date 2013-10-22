require 'sinatra'

configure do
  set :bind, "0.0.0.0"
end

require "sinatra/reloader"

get '/' do
  puts params.inspect
  q = Question.new(params[:q])
  output = q.solve
  puts output
  output.to_s
end

def question_what_is question
  match = question.match /(\d+).+(\d+)/
  puts match.inspect
  match[1].to_i + match[2].to_i
end

def question_which_is question

end

class Question
  def initialize(question)
    @question = question
  end

  def split
    #a = @question.scan(/[0-9a-z]+: (.+)/)
    #puts a.inspect
    #a.flatten
    @question[10..-1]
  end

  def solve
    s = Solver.new(split)
    s.solve
  end
end

class Solver
  def initialize(question)
    @question = question
  end

  def solve
    if @question.match /fibonacci/
      what_is_fibonacci
    elsif @question.match /what is/
      what_is
    elsif @question.match /largest/
      which_largest
    end
  end

  def what_is
    puts "running what is"
    match = []
    puts @question
    match = @question.scan /(\d+)/
    match = match.flatten
    puts match
    match[0].to_i + match[1].to_i
  end

  def which_largest
    match = @question.scan /(\d+)/
    match = match.flatten
    match.max
  end

  def what_is_fibonacci
    match = @question.scan /(\d+)/
    match = match.flatten[0].to_i
    nth_fibonacci(match)
  end

  def nth_fibonacci(n)
    a, b = 0, 1
    (n).times { a, b = b, a+b }
    a
  end

end
