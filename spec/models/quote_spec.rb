# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quote, type: :model do
  it 'has a valid factory' do
    expect(build(:quote)).to be_valid
  end

  context 'with database mapping' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'with callbacks' do
    subject(:quote) { create(:quote) }

    context 'when broadcasts_to inserts_by prepend on create' do
      it 'send broadcast to streams channel' do
        model = quote

        expect { model.save }.to have_broadcasted_to('quotes')
          .from_channel(Turbo::StreamsChannel).exactly(:once)
      end
    end

    context 'when broadcasts_to inserts_by prepend on update' do
      it 'send broadcast to streams channel' do
        model = quote

        expect { model.update(name: 'test') }.to have_broadcasted_to('quotes')
          .from_channel(Turbo::StreamsChannel).exactly(:once)
      end
    end

    context 'when broadcasts_to inserts_by prepend on destroy' do
      it 'send broadcast to streams channel' do
        model = quote

        expect { model.destroy }.to have_broadcasted_to('quotes')
          .from_channel(Turbo::StreamsChannel).exactly(:once)
      end
    end
  end
end
