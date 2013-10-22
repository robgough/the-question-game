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
    if @question.match /fibonacci/
      what_is_fibonacci
    elsif @question.match /scrabble/
      what_is_scrabble_score
    elsif @question.match /the power/
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
    match = @question.scan /(\d+)/
    match = match.flatten
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

  def power_of
    match = @question.scan(/(\d+)/).flatten
    match[0].to_i ** match[1].to_i
  end

  def what_is_scrabble_score
    letters = { e: 1, a: 1, i: 1, o: 1, n: 1, r: 1, t: 1, l: 1, s: 1, u: 1, d: 2, g: 2, b: 3, c: 3, m: 3, p: 3, f: 4, h: 4, v: 4, w: 4, y:4, k: 5, j: 8, x: 8, q: 10, z: 10 }
    match = @question.split(" ").last.downcase
    array = []
    match.each_char do |char|
      array << letters[:"#{char}"]
    end
    array.map!(&:to_i).inject(0) { |total, num| total += num }
  end
end
