class CharacterStat < ActiveRecord::Base
    belongs_to :avatar
    belongs_to :weapon
    belongs_to :spell
end