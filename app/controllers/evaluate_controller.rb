require 'json'

class EvaluateController < ApplicationController
  # GET /evaluate
  def index

  end

  # POST /evaluate
  def run
    parameters = params[:parameters] || {}
    parameters = parameters.empty? ? {} : JSON.parse(params[:parameters]) if parameters.is_a?(String)

    evaluate_scope = EvaluateScope.new(self)
    b = evaluate_scope::get_binding
    parameters.each { |k, v| b.local_variable_set(k, v) }

    b.eval params[:code]
  rescue Exception => ex
    render :text => ex, status: 500
  end
end

class EvaluateScope
  def initialize(ctrl)
    @ctrl = ctrl
  end

  def get_binding
    return binding
  end

  def done(result)
    @ctrl.render :json => result
  end
end