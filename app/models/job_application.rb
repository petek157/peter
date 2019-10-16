class JobApplication < ApplicationRecord

    has_many :trackers, dependent: :destroy
    has_one :resume
    
end
