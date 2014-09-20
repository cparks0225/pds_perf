def isTestInSuite(test_id)
  Suite.where("system=?", current_system().id ).all.each do |s|
    s["tests"].each do |t|
      if t["id"].to_i == test_id.to_i
        return true
      end
    end
  end
  return false
end

class SuitesController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    if current_system().nil?
      @suites = []
    else
      @suites = Suite.where("system=?", current_system().id )
    end
  end

  def show
    @suite = Suite.find params[:id]
  end
  
  def update
    @suite = Suite.find params[:id]
    @suite.name = params[:name]
    @suite.tests = params[:tests]
    if @suite.save()
      render "suites/show"
    else
      respond_with @suite
    end
  end
  
  def create
    @suite = Suite.new
    @suite.name = params[:name]
    @suite.tests = params[:tests]
    @suite.system = current_system().id

    @suite.tests.each do |t|
      test = Test.find t["id"]
      test.can_delete = false
      test.save()
    end

    if @suite.save()
      render "suites/show"
    else
      respond_with @suite
    end
  end

  def destroy
    suite = Suite.find params[:id]
    suite_tests = suite.tests
    suite.destroy()

    suite_tests.each do |t|
      test_can_delete = true
      if isQueryInTest( t["id"] )
        test_can_delete = false
      end
      if test_can_delete
        test = Test.find( t["id"] )
        test.can_delete = true
        test.save()
      end
    end

    render json: {}
  end
end
