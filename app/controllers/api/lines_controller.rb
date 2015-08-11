class Api::LinesController < ApplicationController
  def show
    line = $redis.get "line:#{params[:id]}"

    if line.present?
      render text: line
    else
      render text: "Line does not exist! Please select a lower number.",
             status: 413
    end
  end
end
