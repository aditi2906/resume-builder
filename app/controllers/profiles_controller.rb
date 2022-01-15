class ProfilesController < ApplicationController
  include HomeHelper
  include ProfilesHelper

  before_action :logged_in_user, only: [:update]
  before_action :correct_user,   only: [:update]

  def new
    id = params[:format]
    project = Project.create(experience_id: id)
    if project.valid?
      flash[:success] = "Project added."
      redirect_to edit_url
    else
      flash[:danger] = 'Failed to add projects'
      redirect_to root_url
    end
  end

  def update
    params_with_projects = project_params
    @project = Project.find_by(experience_id: params[:id])
    if @project.update(params_with_projects)
      flash[:success] = 'Projects added successfully'
      redirect_to edit_url
    else
      flash[:danger] = 'Failed to add projects'
      redirect_to root_url
    end
  end

  def correct_user
    @profile = Profile.find(params[:id])
    @user = User.find(@profile.user_id)
    redirect_to(root_url) unless @user == current_user
  end

  def share
    @profile = Profile.find_by_id(params[:id])
    if @profile
      render('home/public')
    else
      flash[:danger] = 'Profile doesnt exist'
      redirect_to root_url
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :avatar, :job_title, :total_experience, :overview,
                                    :career_highlights, :primary_skills, :secondary_skills,
                                    educations_attributes: %i[id school degree description start end _destroy],
                                    experiences_attributes: [:id, :company, :position, :start_date, :end_date, :description, :_destroy, { projects_attributes: %i[id title url tech_stack description _destroy] }])
  end
end