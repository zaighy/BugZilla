class Bug < ApplicationRecord
    belongs_to :user
    belongs_to :project

    enum bug_type_list: %i[ Feature Bug ]
    enum bug_status_list: %i[ New Started ]
    enum bug_feat_status: %i[ Completed Resolved ]
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
