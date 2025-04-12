class ProfilesController < ApplicationController
  def edit
    @profile = current_user.profile
  end
end
