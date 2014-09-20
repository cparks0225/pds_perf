def isQueryInTest(query_id)
  Test.where("system=?", current_system().id ).all.each do |t|
    t["queries"].each do |q|
      if q["id"].to_i == query_id.to_i
        return true
      end
    end
  end
  return false
end

class TestsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    if current_system().nil?
      @tests = []
    else
      @tests = Test.where( "system=?", current_system().id )
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
    @test.can_delete = true

    @test.queries.each do |q|
      query = Query.find q["id"]
      query.can_delete = false
      query.save()
    end

    if @test.save()
      render "tests/show"
    else
      respond_with @test
    end
  end
  
  def destroy
    test = Test.find params[:id]
    test_queries = test.queries
    test.destroy()

    test_queries.each do |q|
      query_can_delete = true
      if isQueryInTest( q["id"] )
        query_can_delete = false
      end
      if query_can_delete
        query = Query.find( q["id"] )
        query.can_delete = true
        query.save()
      end
    end

    render json: {}
  end
end
