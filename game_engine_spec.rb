require_relative 'game_engine'
describe 'question' do
  let(:question) { Question.new(what_is) }
  let(:what_is) { "12345:what is 5 + 6" }
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
  it 'should correctly answer what is'
    expect(what_is_solver.solve).to eq(11) 
  end
  it 'should correctly answer which is' do
    expect(which_is_solver.solve).to eq(123)
  end
end
