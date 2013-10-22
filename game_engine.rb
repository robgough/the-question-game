require 'sinatra'

configure do
  set :bind, "0.0.0.0"
end

require "sinatra/reloader"

get '/' do
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
    else
      1
    end
  end

  def what_is
    match = @question.scan /(\d+)/
    match = match.flatten
    match[0].to_i + match[1].to_i
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
