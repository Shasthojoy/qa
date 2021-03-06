require 'spec_helper'

describe AnswersController do
  context 'create' do
    it 'requires login' do
      -> { post :create }.should raise_error(QA::NotLoggedIn)
    end

    context 'when logged in' do
      let(:question) { FactoryGirl.create(:question) }
      let(:answer) { FactoryGirl.attributes_for(:answer) }

      before { sign_in(alice) }

      it 'creates answer with valid parameters' do
        post :create, answer: answer.merge(question_id: question.id)
        Answer.last.body.should == answer[:body]
        Answer.all.length.should == 1
      end
    end
  end
end