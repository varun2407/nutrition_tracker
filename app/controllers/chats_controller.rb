class ChatsController < ApplicationController
  # No need for set_conversation before action for show
  # before_action :set_conversation, only: [:show, :create]

  def show
    @conversations = Conversation.all # Display all conversations (or filter as needed)
  end

  def create
    user_input = params[:conversation][:user_input]

    # Send the user input to Ollama API running locally on 127.0.0.1:11434
    ai_response = get_ai_response(user_input)

    # Save the conversation to the database
    @conversation = Conversation.create(user_input: user_input, ai_response: ai_response, context: "nutrition")

    respond_to do |format|
      format.html { redirect_to chat_path }
      format.turbo_stream  # Turbo Stream to update the chat interface in real time
      format.json { render json: { user_input: user_input, ai_response: ai_response } }
    end
  end

  private

  def get_ai_response(user_input)
    response = HTTParty.post("http://127.0.0.1:11434", {
      body: {
        prompt: user_input,
        context: "nutrition"
      }.to_json,
      headers: { "Content-Type" => "application/json" }
    })

    if response.success?
      response_data = JSON.parse(response.body)
      response_data["ai_response"]  # Adjust this based on Ollama's actual response structure
    else
      "Sorry, I couldn't process that right now."
    end
  end
end
