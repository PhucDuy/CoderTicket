require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'get index' do
    it 'should return a 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  it 'loads upcoming events' do
    a = Event.new(starts_at: 2.day.ago)
    b = Event.new(starts_at: 1.day.from_now)
    c = Event.new(starts_at: Time.now + 2.months)
    [a,b,c].each { |event| event.save(validate: false) }
    get :index

    expect(Event.upcoming).to match_array [b,c]
  end


end
