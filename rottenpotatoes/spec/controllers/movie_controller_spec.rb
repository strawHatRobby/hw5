require 'rails_helper'

describe MoviesController, :type => :controller do
   describe "#director" do
    it 'When I follow "Find Movies With Same Director", I should be on the Similar Movies page for the Movie' do
      double = double('Movie')
      double.stub(:director).and_return('double director')
      similarMocks = [double('Movie'), double('Movie')]
      Movie.should_receive(:find).with('13').and_return(double)
      Movie.should_receive(:similar_director).with(double.director).and_return(similarMocks)
      get :similar_director, {:id => '13'}
    end
    it 'should redirect to index if movie does not have a director' do
      double = double('Movie')
      double.stub(:director).and_return(nil)
      double.stub(:title).and_return(nil)
      Movie.should_receive(:find).with('13').and_return(double)
      get :similar_director, {:id => '13'}
      response.should redirect_to(movies_path)
    end
  end
  
  describe "index action" do
    it 'should display title sort properly' do
       Movie.order(:title => :asc).to_sql.should =~ /ORDER BY "movies"."title" ASC/
       get :index, :sort => 'title'
    end
    it 'should display release_date sort properly' do
       Movie.order(:release_date => :asc).to_sql.should =~ /ORDER BY "movies"."release_date" ASC/
       get :index, :sort => 'release_date'
    end
  end

  describe "edit action" do
    before :each do
        @movie = double('Movie', :id => "123", :title => "Gladiator")
        Movie.stub(:find).with("123").and_return(@movie)
    end
    it "should allow movie date to be changed" do
        get :edit, :id => "123"
        response.should render_template("edit")
    end
  end
  
  describe "show action" do
    it "should show form for new movie" do
        @movie = double('Movie', :id => "123", :title => "Gladiator")
        Movie.stub(:find).with("123").and_return(@movie)
        get :show, :id => "123" 
        response.should render_template("show")
    end
  end
  
  describe 'update action' do
    before :each do
        @movie = double('Movie', :title => "Gladiator", :id => "123")
        Movie.stub(:find).and_return(@movie)
    end

    it 'should update and show movie' do
        @movie.should receive(:update_attributes!)
        put :update,  :movie => { :title => "Whatever"},  :id => "123" 
        response.should redirect_to(movie_path(@movie))
    end
  end
  
  describe 'destroy action' do
    it 'should destroy a movie' do
        @movie = double('Movie', :id => "123", :title => "Gladiator")
        Movie.stub(:find).and_return(@movie)
        @movie.should receive(:destroy)
        delete :destroy, :id => "123"
        response.should redirect_to(movies_path)
    end
  end

  describe 'create action' do
    it 'should redirect to movies_path once completed' do
        @movie = double(:title => "Gladiator", :director => "Me", :id => "123")
        post :create,  :movie => {:id => "123"} 
        response.should redirect_to(movies_path)
    end
  end
    
end