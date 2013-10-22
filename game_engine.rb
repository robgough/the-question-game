require 'sinatra'

configure do
  set :bind, "0.0.0.0"
end

require "sinatra/reloader"

get '/' do
  puts '*'*100
  puts params.inspect

  var = Question.new(params[:q]).solve.to_s
  puts var
  var
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
    score = 0
    previous = :plus
    @question.gsub!(/multiplied by/, 'multiply')
    @question.split(' ').each do |word|
      puts word
      begin
        value = Integer(word)
      rescue
        value = word
      end

      if value.class == Fixnum
        if previous == "plus" || previous == "is"
          score = score + value 
        elsif previous == "minus"
          score = score - value
        else
          score = score * value
        end
      else
        previous = word
      end
    end
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
