# app/models/history_tracker.rb
class HistoryTracker
  include Mongoid::History::Tracker
end