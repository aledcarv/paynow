require 'rails_helper'

describe 'visitor visit homepage' do
    it 'successfully' do
        visit root_path

        expect(page).to have_content('Paynow')
        expect(page).to have_content('Seja bem-vindo(a) ao Paynow!')
    end
end