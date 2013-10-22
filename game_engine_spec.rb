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
  
  it 'should correctly answer what is' do
    expect(what_is_solver.solve).to eq(11) 
  end

  it 'should handle complex what is with plus minus and multipled by' do
    s = Solver.new("what is 5 plus 2 minus 5 multipled by 2")  
    expect(s.solve).to eq(4)
  end

  it 'should correctly answer which is' do
    expect(which_is_largest_solver.solve).to eq("123")
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
