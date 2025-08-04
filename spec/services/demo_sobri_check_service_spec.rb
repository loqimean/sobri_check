require "rails_helper"

RSpec.describe DemoSobriCheckService, type: :service do
  let(:service) { DemoSobriCheckService.new }
  let(:result) { nil }

  describe "#analyze_message" do
    context "with empty text" do
      let(:result) { service.analyze_message("") }

      it "returns an error" do
        expect(result[:status]).to eq("error")
        expect(result[:message]).to include("empty")
      end
    end

    context "with dangerous keywords" do
      let(:result) { service.analyze_message("I hate you and will never speak to you again") }

      it "returns danger status" do
        expect(result[:status]).to eq("danger")
        expect(result[:confidence]).to be 0
        expect(result[:suggestions]).not_to be_empty
      end
    end

    context "with warning keywords" do
      let(:result) { service.analyze_message("I am drunk and confused right now") }

      it "returns warning status" do
        expect(result[:status]).to eq("warning")
        expect(result[:confidence]).to be > 0
        expect(result[:suggestions]).not_to be_empty
      end
    end

    context "with safe message" do
      let(:result) { service.analyze_message("Hello, how are you doing today?") }

      it "returns safe status" do
        expect(result[:status]).to eq("safe")
        expect(result[:confidence]).to be > 0
      end
    end

    context "with all caps message" do
      let(:result) { service.analyze_message("WHY ARE YOU IGNORING ME") }

      it "returns warning status" do
        expect(result[:status]).to eq("warning")
      end
    end

    context "with too many exclamation marks" do
      let(:result) { service.analyze_message("Hello!!!! How are you!!!!!") }

      it "returns warning status" do
        expect(result[:status]).to eq("warning")
      end
    end
  end
end
