class Bug < ApplicationRecord
    belongs_to :user
    belongs_to :project

    enum bug_typee: %i[ Feature Bug ]
    enum bug_status: %i[ New_Bug Started_Bug Resolved ]
    enum feature_status: %i[ New_Feature Started_Feature Completed ]

    validates_uniqueness_of :title,
                            message: 'This Title Already Exists'
    validates_presence_of :status,
                          message: 'Assign a Status'
    validates_presence_of :bug_type,
                          message: 'Assign a Type'
    validates_presence_of :user,
                          message: 'Specify a User'
    validates_presence_of :project,
                          message: 'Specify a Project'
end
