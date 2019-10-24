class Resume < ApplicationRecord

    belongs_to :job_application
    has_and_belongs_to_many :projects
    has_and_belongs_to_many :certificates
    has_and_belongs_to_many :teches

    has_one_attached :res_pdf
end
