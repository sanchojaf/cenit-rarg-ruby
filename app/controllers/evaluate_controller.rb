require 'json'

class EvaluateController < ApplicationController
  # GET /evaluate
  def index

  end

  # POST /evaluate
  def run
    b = binding
    parameters = params[:parameters].is_a?(String) ? JSON.parse(params[:parameters]) : params[:parameters]
    parameters.each { |k, v| b.local_variable_set(k, v) }
    eval params[:code], b
  rescue Exception => ex
    render :text => ex, status: 500
  end

  private

  def done(result)
    render :json => result
  end

end
