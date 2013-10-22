require 'sinatra'

configure do
  set :bind, "0.0.0.0"
end

require "sinatra/reloader"

get '/' do
  puts params.inspect
  q = Question.new(params[:q])
  q.solve
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
    @question.split(':').last
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
    if @question.match /what is/
      what_is
    elsif @question.match /which/
      which
    end
  end

  def what_is
    match = []
    puts @question
    match = @question.scan /(\d+)/
    match = match.flatten
    match[0].to_i + match[1].to_i
  end

  def which
  end
end
