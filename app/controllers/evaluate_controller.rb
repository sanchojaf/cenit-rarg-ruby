require 'json'

class EvaluateController < ApplicationController
  # GET /evaluate
  def index

  end

  # POST /evaluate
  def run
    parameters = params[:parameters] || {}
    parameters = parameters.empty? ? {} : JSON.parse(params[:parameters]) if parameters.is_a?(String)

    b = binding
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
