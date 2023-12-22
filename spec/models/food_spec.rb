require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { build(:food) } # ! non persisting object. It's not saved in the database.

  describe 'validations' do
    context 'object itself' do
      it 'should be valid' do
        expect(food).to be_valid
      end
    end

    context 'name validations' do
      it 'should be valid' do
        expect(food.name).to be_present
      end

      it 'should be invalid' do
        food.name = nil
        expect(food).to_not be_valid
      end
    end

    context 'measurement_unit validations' do
      it 'should be valid' do
        expect(food.measurement_unit).to be_present
        expect(food.measurement_unit).to be_in(%w[mg g kg l ml])
      end

      it 'should be invalid' do
        food.measurement_unit = nil
        expect(food).to_not be_valid
      end
    end

    context 'price validations' do
      it 'should be valid' do
        expect(food.price).to be_present
        expect(food.price).to be_a(BigDecimal)
        expect(food.price).to be > 0
      end

      it 'should be invalid' do
        food.price = nil
        expect(food).to_not be_valid
      end
    end

    context 'quantity validations' do
      it 'should be valid' do
        expect(food.quantity).to be_present
        expect(food.quantity).to be_a(Integer)
        expect(food.quantity).to be > 0
      end

      it 'should be invalid' do
        food.quantity = nil
        expect(food).to_not be_valid
      end
    end

    context 'total_price validations' do
      it 'should be valid' do
        expect(food.total_price).to be_present
        expect(food.total_price).to be_a(BigDecimal)
        expect(food.total_price).to be > 0
      end
    end
  end
end
