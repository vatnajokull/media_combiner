RSpec.describe OrderItem, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:book_id).of_type(:integer) }
    it { is_expected.to have_db_column(:order_id).of_type(:integer) }
  end

  describe 'model relations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:book) }
  end
end
