class TestsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    @tests = Test.all
  end

  def show
    @test = Test.find params[:id]
  end
  
  def update
    @test = Test.find params[:id]
    @test.name = params[:name]
    @test.queries = params[:queries]
    if @test.save()
      render "tests/show"
    else
      respond_with @test
    end
  end
  
  def create
    @test = Test.new
    @test.name = params[:name]
    @test.queries = params[:queries]
    if @test.save()
      render "tests/show"
    else
      respond_with @test
    end
  end
  
  def destroy
    test = Test.find params[:id]
    test.destroy()
    render json: {}
  end
  
end