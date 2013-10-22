require_relative 'game_engine'
describe 'question' do
  let(:question) { Question.new(what_is) }
  let(:what_is) { "9544DA10: what is 5 + 6" }
  it 'splits a question' do
    expect(question.split).to eq("what is 5 + 6")
  end

  it 'should should answer 5 + 6' do
    expect(question.solve).to eq(11)
  end
end

describe 'solver' do
  let (:what_is_solver) { Solver.new(what_is_question) }
  let (:what_is_question) { "what is 5 + 6" }
  let (:which_is_question) { "which of the following numbers is the largest: 100 101 123" }
  let (:which_is_largest_solver) { Solver.new(which_is_question) }
  let (:what_is_fibonacci_question) { "what is the 16th fibonacci number" }
  let (:what_is_fibonacci_solver) {Solver.new(what_is_fibonacci_question) }
  let (:what_is_scrabble_score_question) { "what is the scrabble score of banana" }
  let (:what_is_scrabble_score_solver) {Solver.new(what_is_scrabble_score_question) }

  it 'should correctly answer what is' do
    expect(what_is_solver.solve).to eq(11)
  end
  it 'should correctly answer which is' do
    expect(which_is_largest_solver.solve).to eq("123")
  end

  it 'should correctly answer what is fibonacci' do
    expect(what_is_fibonacci_solver.solve).to eq(987)
  end

  it 'should correctly answer what is scrabble score' do
    expect(what_is_scrabble_score_solver.solve).to eq(8)
  end

  context "solves powers of" do
    let(:question) { "what is 6 to the power of 6" }

    subject { Solver.new(question).solve }

    it "solves to the power of" do
      expect(subject).to eq(46656)
    end
  end

  context "solves the eiffel tower" do
    let(:question) { "eiffel" }
    subject { Solver.new(question).solve }

    it "returns paris" do
      expect(subject).to eq('Paris')
    end
  end
end
