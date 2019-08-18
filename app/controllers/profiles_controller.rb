require_relative "../models/user_profile"
require_relative "../services/profiles_service"

class ProfilesController < ApplicationController

  def get_profile

    # Call service to find the profile by its ID.
    found_profile = ProfilesService.get_profile(params[:id])

    # If profile wasn't found, return HTTP Code 404 (Not Found)
    if found_profile == nil
      return render :json => nil, :status => 404
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(found_profile.as_json), :status => 200
    end

  end

  def post_profile

    # List of parameters to look for in the request.
    required_parameters = [:user_id, :firstname, :lastname, :email, :phonenumber, :address]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's already a profile with this name.
    find_profile = ProfilesService.get_profile_by_user(params[:user_id])

    # If there's already a profile with this name, return error.
    if find_profile != nil
      return render :json => "There's already a profile for this user.", :status => 409
    else
      # Create new profile object and fill it with request data.
      created_profile = UserProfile.new
      created_profile.user_id = params[:user_id].to_i
      created_profile.firstname = params[:firstname].to_s
      created_profile.lastname = params[:lastname].to_s
      created_profile.email = params[:email].to_s
      created_profile.phonenumber = params[:phonenumber].to_s
      created_profile.address = params[:address].to_s
      newest_profile = ProfilesService.create_profile(created_profile)
      # If the service failed for some reason, return HTTP Code 400 (Bad Request)
      if newest_profile == nil
        return render :json => nil, :status => 400
      else
        return render :json => JSON.pretty_generate(newest_profile.as_json), :status => 201
      end
    end

  end

  def put_profile

    # List of parameters to look for in the request.
    required_parameters = [:firstname, :lastname, :email, :phonenumber, :address]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's a profile with that ID.
    profile_id = ProfilesService.get_profile(params[:id])

    if profile_id == nil
      return render :json => nil, :status => 404
    end

    # Create new profile object and populate it with the new data.
    profile = UserProfile.new
    profile.firstname = params[:firstname].to_s
    profile.lastname = params[:lastname].to_s
    profile.email = params[:email].to_s
    profile.phonenumber = params[:phonenumber].to_s
    profile.address = params[:address].to_s

    # Execute the service to update the existing profile.
    updated_profile = ProfilesService.update_profile(params[:id], profile)
    if updated_profile == nil
      return render :json => nil, :status => 400
    else
      # Return the data in JSON Format, with HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(updated_profile.as_json), :status => 200
    end

  end

  def delete_profile

    # Check if there's a profile with that ID.
    profile_id = ProfilesService.get_profile(params[:id])

    # If it doesn't exist, return null.
    if profile_id == nil
      return render :json => nil, :status => 404
    else
    # In case it does, execute the service and use HTTP Code 200 (OK)
      deleted_profile = ProfilesService.delete_profile(params[:id])
      return render :json => JSON.pretty_generate(deleted_profile.as_json), :status => 200
    end

  end

end