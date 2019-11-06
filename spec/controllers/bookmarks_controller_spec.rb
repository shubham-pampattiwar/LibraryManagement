require 'rails_helper'

RSpec.describe BookmarksController do
    describe "GET #index" do
        subject { get :index }
        it "renders the index template" do
            expect(subject).to render_template(:index)
            expect(subject).to render_template("index")
        end
      end

      describe "GET #new" do
        subject { get :new }
        it "renders the new template" do
            expect(subject).to render_template(:new)
            expect(subject).to render_template("new")
        end
      end
end

