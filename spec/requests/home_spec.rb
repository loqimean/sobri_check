RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "returns a success response" do
      get root_path

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Sobri Check")
    end
  end

  describe "POST /analyze" do
    context "with valid message" do
      let(:valid_params)   { { message: "Hello world" } }
      let(:html_params)    { { message: "Test message" } }

      it "analyzes the message and returns success" do
        post analyze_path, params: valid_params

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Safe to Send")
      end

      it "processes the request successfully with HTML format" do
        post analyze_path, params: html_params

        expect(response).to be_successful
        expect(response.content_type).to include("text/html")
      end
    end

    context "with empty message" do
      let(:empty_params)   { { message: "" } }
      let(:nil_params)     { {} }

      it "returns an error result" do
        post analyze_path, params: empty_params

        expect(response).to be_successful
        expect(response.body).to include("enter a message")
      end

      it "handles nil message parameter" do
        post analyze_path, params: nil_params

        expect(response).to be_successful
        expect(response.body).to include("enter a message")
      end
    end

    context "with dangerous message in demo mode" do
      let(:danger_params)  { { message: "I hate everyone" } }

      it "processes dangerous messages" do
        post analyze_path, params: danger_params

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Demo Mode")
      end
    end

    context "with turbo stream format" do
      let(:turbo_params)   { { message: "Hello" } }
      let(:html_params)    { { message: "Test message" } }

      it "responds with turbo stream when requested" do
        post analyze_path(format: :turbo_stream), params: turbo_params

        expect(response).to be_successful
        expect(response.content_type).to include("text/vnd.turbo-stream.html")
        expect(response.body).to include("turbo-stream")
      end

      it "includes results container update in turbo stream" do
        post analyze_path,
             params: html_params,
             headers: { "Accept" => "text/vnd.turbo-stream.html" }

        expect(response).to be_successful
        expect(response.body).to include("results-container")
      end
    end

    context "different response formats" do
      let(:turbo_params)   { { message: "Hello" } }
      let(:form_params)    { { message: "Test analysis" } }

      it "handles HTML format by default" do
        post analyze_path, params: turbo_params

        expect(response).to be_successful
        expect(response.content_type).to include("text/html")
      end

      it "processes form submission correctly" do
        expect do
          post analyze_path, params: form_params
        end.not_to raise_error

        expect(response).to be_successful
      end
    end
  end
end
