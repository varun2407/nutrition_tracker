class ProfilesController < ApplicationController
  def edit
    @profile = current_user.profile
    if @profile.height.present?
      conversion = UnitConversionHelper.cm_to_ft_in(@profile.height)
      @profile.height_feet = conversion[:feet]
      @profile.height_inches = conversion[:inches]
    end
  end

  def update
    @profile = current_user.profile

    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :birth_date,
      :height,
      :height_feet,
      :height_inches,
      :unit_preference
    )
  end
end
