class Api::MessagesController < ApplicationController
  respond_to :json

  def index
    @messages = Message.all
    respond_with @messages
  end

  def create
    @message = Message.create message_params
    respond_with :api, @message
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
