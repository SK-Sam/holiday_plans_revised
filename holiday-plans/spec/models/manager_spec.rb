require 'rails_helper'

RSpec.describe Manager, type: :model do
  describe 'Relationships' do
    it { should have_many :workers }
  end