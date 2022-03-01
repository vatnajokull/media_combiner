RSpec.describe Location, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:addressable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:addressable_type).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:street).of_type(:string) }
    it { is_expected.to have_db_column(:building_number).of_type(:integer) }
    it { is_expected.to have_db_column(:appartment_number).of_type(:integer) }
    it { is_expected.to have_db_column(:zip_code).of_type(:string) }

    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'model relations' do
    it { is_expected.to belong_to(:addressable) }
  end
end
