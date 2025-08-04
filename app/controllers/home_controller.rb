class HomeController < ApplicationController
  def index
    @result = nil
  end

  def analyze
    text = params[:message]
    @original_message = text

    if text.blank?
      @result = error_result("Please enter a message to analyze")

      return respond
    end

    service = select_service
    @result = service.analyze_message(text)
    @result[:demo_mode] = service.is_a?(DemoSobriCheckService)

    respond
  end

  private

  def select_service
    real_service = SobriCheckService.new
    real_service.configured? ? real_service : DemoSobriCheckService.new
  end

  def error_result(message)
    {
      status: "error",
      message: message,
      suggestions: [],
      confidence: 0
    }
  end

  def respond
    respond_to do |format|
      format.turbo_stream
      format.html { render :index }
    end
  end
end
