
RSpec.describe Account, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:password).of_type(:string) }
    it { is_expected.to have_db_column(:provider).of_type(:integer) }
    it { is_expected.to define_enum_for(:provider).with_values(%w[email facebook google]) }
    it { is_expected.to have_db_column(:uuid).of_type(:string) }

    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'model relations' do
    it { is_expected.to have_one(:user) }
  end
end
