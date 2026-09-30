require 'test_helper'

class Game::CategoryScheduleTest < ActiveSupport::TestCase
  test 'requiere dia y categoria' do
    schedule = Game::CategorySchedule.new

    assert_not schedule.valid?
    assert_includes schedule.errors[:day], 'no puede estar en blanco'
    assert_includes schedule.errors[:club_category], 'debe existir'
  end
end
