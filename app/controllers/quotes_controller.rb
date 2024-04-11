# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[edit update destroy]

  # GET /quotes
  def index
    @quotes = Quote.order(created_at: :desc)
  end

  # GET /quotes/new
  def new
    @quote = Quote.new

    render :form
  end

  # GET /quotes/1/edit
  def edit
    render :form
  end

  # POST /quotes
  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      # respond_to do |format|
      #   format.html { redirect_to quotes_path, notice: 'Quote was successfully created.' }
      #   format.turbo_stream
      # end
      # render turbo_stream: [
      #   turbo_stream.prepend('quotes', @quote),
      #   turbo_stream.update('new_quote', '')
      # ]
      render :create, formats: :turbo_stream
    else
      render :form, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quotes/1
  def update
    if @quote.update(quote_params)
      render turbo_stream: turbo_stream.replace(@quote, @quote)
    else
      render :form, status: :unprocessable_entity
    end
  end

  # DELETE /quotes/1
  def destroy
    @quote.destroy!

    render turbo_stream: turbo_stream.remove(@quote)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quote
    @quote = Quote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def quote_params
    params.require(:quote).permit(:name)
  end
end
