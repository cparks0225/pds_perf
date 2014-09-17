class TestsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    if current_system().nil?
      @tests = []
    else
      @tests = Test.where("system=?", current_system().id )
    end
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
    @test.system = current_system().id
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