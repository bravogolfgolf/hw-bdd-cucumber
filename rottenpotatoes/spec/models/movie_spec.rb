require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'searching Tmdb by keyword' do
    context 'with valid API key' do
      it 'calls Tmdb with title keywords' do
        expect(Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
    end
    context 'with invalid API key' do
      it 'raises an InvalidKeyError' do
        allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::InvalidApiKeyError)
        expect { Movie.find_in_tmdb('Inception') }
          .to raise_error(Movie::InvalidKeyError)
      end
    end
  end
end
