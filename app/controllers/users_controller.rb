require_relative "../models/User"
require_relative "../services/users_service"

class UsersController < ApplicationController

  def list_users

    # Call service to return all user records.
    user_list = UsersService.list_users

    # If user list is empty, return HTTP Code 204 (No Content)
    if user_list.length == 0
      return render :json => nil, :status => 204
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(user_list.as_json), :status => 200
    end

  end

  def get_user

    # Call service to find the user by its ID.
    found_user = UsersService.get_user(params[:id])

    # If user wasn't found, return HTTP Code 404 (Not Found)
    if found_user == nil
      return render :json => nil, :status => 404
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(found_user.as_json), :status => 200
    end

  end

  def post_user

    # List of parameters to look for in the request.
    required_parameters = [:department_id, :rank_id, :name, :password]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's already a user with this name.
    find_user = UsersService.get_user_by_name(params[:name])

    # If there's already a user with this name, return error.
    if find_user != nil
      return render :json => "There's already a user with this name.", :status => 409
    else
      # Create new user object and fill it with request data.
      created_user = User.new
      created_user.department_id = params[:department_id].to_i
      created_user.rank_id = params[:rank_id].to_i
      created_user.name = params[:name].to_s
      created_user.password = params[:password]
      newest_user = UsersService.create_user(created_user)
      # If the service failed for some reason, return HTTP Code 400 (Bad Request)
      if newest_user == nil
        return render :json => nil, :status => 400
      else
        return render :json => JSON.pretty_generate(newest_user.as_json), :status => 201
      end
    end

  end

  def put_user

    # List of parameters to look for in the request.
    required_parameters = [:department_id, :rank_id, :name]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's a user with that ID.
    user_id = UsersService.get_user(params[:id])

    if user_id == nil
      return render :json => nil, :status => 404
    end

    # Check if the new name conflicts with another one.
    find_user = UsersService.get_user_by_name(params[:name])

    # If there's another user with that name already, return error.
    if find_user != nil && params[:id].to_i != find_user.id.to_i
      return render :json => "There's already an user with this name.", :status => 409
    else
      # If everything is fine, execute the service.

      # Create new user object and populate it with the new data.
      user = User.new
      user.department_id = params[:department_id].to_i
      user.rank_id = params[:rank_id].to_i
      user.name = params[:name].to_s

      # Execute the service to update the existing user.
      updated_user = UsersService.update_user(params[:id], user)
      if updated_user == nil
        return render :json => nil, :status => 400
      else
        # Return the data in JSON Format, with HTTP Code 200 (OK)
        return render :json => JSON.pretty_generate(updated_user.as_json), :status => 200
      end

    end
  end

  def delete_user

    # Check if there's a user with that ID.
    user_id = UsersService.get_user(params[:id])

    # If it doesn't exist, return null.
    if user_id == nil
      return render :json => nil, :status => 404
    else
    # In case it does, execute the service and use HTTP Code 200 (OK)
      deleted_user = UsersService.delete_user(params[:id])
      return render :json => JSON.pretty_generate(deleted_user.as_json), :status => 200
    end

  end

end