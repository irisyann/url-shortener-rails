class UsageReportsController < ApplicationController
    def index
        # get all urls for current user
        @target_urls = TargetUrl.where(user_id: Current.user.id)
    end
end