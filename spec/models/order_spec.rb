RSpec.describe Order, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:return_date).of_type(:date) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to define_enum_for(:status).with_values(%w[open closed]) }

    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'model relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:order_items) }
  end
end
