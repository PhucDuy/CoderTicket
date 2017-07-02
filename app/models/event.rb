# create_table "events", force: :cascade do |t|
#   t.datetime "starts_at"
#   t.datetime "ends_at"
#   t.integer  "venue_id"
#   t.string   "hero_image_url"
#   t.text     "extended_html_description"
#   t.integer  "category_id"
#   t.string   "name"
#   t.datetime "created_at",                null: false
#   t.datetime "updated_at",                null: false
#   t.index ["category_id"], name: "index_events_on_category_id", using: :btree
#   t.index ["venue_id"], name: "index_events_on_venue_id", using: :btree
# end

class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    Event.where("starts_at > ?",Time.now)
  end
  def self.search(query)
    Event.where("name like ?",query)
  end
end
