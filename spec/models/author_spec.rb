RSpec.describe Author, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'model relations' do
    it { is_expected.to have_many(:authors_books).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:authors_books) }
  end
end
