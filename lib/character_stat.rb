class CharacterStat < ActiveRecord::Base
    belongs_to :stat
    belongs_to :avatar
end