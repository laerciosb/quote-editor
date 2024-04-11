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
      @quote.broadcast_prepend_to('quotes')

      render :create, formats: :turbo_stream
    else
      render :form, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quotes/1
  def update
    if @quote.update(quote_params)
      @quote.broadcast_replace_to('quotes')

      render turbo_stream: turbo_stream.replace(@quote, @quote)
    else
      render :form, status: :unprocessable_entity
    end
  end

  # DELETE /quotes/1
  def destroy
    @quote.destroy!
    @quote.broadcast_remove_to('quotes')

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
