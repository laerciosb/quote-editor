# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/quotes', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Quote. As you add validations to Quote, be sure to
  # adjust the attributes here as well.
  let(:quote) { create(:quote) }
  let(:valid_attributes) do
    { name: 'String' }
  end
  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Quote.create! valid_attributes
      get quotes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_quote_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_quote_url(quote)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Quote' do
        expect do
          post quotes_url, params: { quote: valid_attributes }
        end.to change(Quote, :count).by(1)
      end

      it 'send broadcast to streams channel' do
        expect do
          post quotes_url, params: { quote: valid_attributes }
        end.to have_broadcasted_to('quotes').from_channel(Turbo::StreamsChannel).exactly(:once)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Quote' do
        expect do
          post quotes_url, params: { quote: invalid_attributes }
        end.to change(Quote, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post quotes_url, params: { quote: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    before { quote }

    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'String2' }
      end

      it 'updates the requested quote' do
        patch quote_url(quote), params: { quote: new_attributes }
        quote.reload
        expect(quote.name).to eq('String2')
      end

      it 'send broadcast to streams channel' do
        expect do
          patch quote_url(quote), params: { quote: new_attributes }
        end.to have_broadcasted_to('quotes').from_channel(Turbo::StreamsChannel).exactly(:once)
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch quote_url(quote), params: { quote: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    before { quote }

    it 'destroys the requested quote' do
      expect do
        delete quote_url(quote)
      end.to change(Quote, :count).by(-1)
    end

    it 'send broadcast to streams channel' do
      expect do
        delete quote_url(quote)
      end.to have_broadcasted_to('quotes').from_channel(Turbo::StreamsChannel).exactly(:once)
    end
  end
end
