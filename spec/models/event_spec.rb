require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'upcoming events' do
    it 'should return empty array when no upcoming events' do
      expect(Event.upcoming).to eq []
    end

    it 'should return 1 event when there is one event' do
      b = Event.new(starts_at: 1.day.from_now)
      b.save(validate: false)
      expect(Event.upcoming).to match_array [b]
    end

    it 'only return upcoming events' do
      a = Event.new(starts_at: 2.day.ago)
      b = Event.new(starts_at: 1.day.from_now)
      c = Event.new(starts_at: Time.now + 2.months)
      [a,b,c].each { |event| event.save(validate: false) }
      expect(Event.upcoming).to match_array [b,c]
    end
  end
  describe 'search' do
    before(:each) do
      a = Event.new(starts_at: 2.day.ago)
      a.name = "abc"
      b = Event.new(starts_at: 1.day.from_now)
      b.name = "Maroon 5 live show"
      c = Event.new(starts_at: Time.now + 2.months)
      c.name = "Lady Gaga live show"
      [a,b,c].each { |event| event.save(validate: false) }

    end
    it 'should return empty array when event not found' do
      expect(Event.search("xyz")).to eq []
    end

    it 'only return events that have name match with query' do
      expect(Event.search("live show").to match_array [b,c])
    end
  end

end
