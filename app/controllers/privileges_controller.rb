require_relative "../models/rank_privilege"
require_relative "../services/privileges_service"

class PrivilegesController < ApplicationController

  def get_privileges

    # Call service to find the privileges by its ID.
    found_privileges = PrivilegesService.get_privileges(params[:rank])

    # If privileges wasn't found, return HTTP Code 404 (Not Found)
    if found_privileges == nil
      return render :json => nil, :status => 404
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(found_privileges.as_json), :status => 200
    end

  end

  def post_privileges

    # List of parameters to look for in the request.
    required_parameters = [:department_id, :rank_id, :create, :read, :update, :delete]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's already a privileges with this name.
    find_privileges = PrivilegesService.get_privileges(params[:rank_id])

    # If there's already a privileges with this name, return error.
    if find_privileges != nil
      return render :json => "There's already privileges for this rank.", :status => 409
    else
      # Create new privileges object and fill it with request data.
      created_privileges = RankPrivilege.new
      created_privileges.department_id = params[:department_id].to_i
      created_privileges.rank_id = params[:rank_id].to_i
      created_privileges.create = ActiveModel::Type::Boolean.new.cast(params[:create])
      created_privileges.read = ActiveModel::Type::Boolean.new.cast(params[:read])
      created_privileges.update = ActiveModel::Type::Boolean.new.cast(params[:update])
      created_privileges.delete = ActiveModel::Type::Boolean.new.cast(params[:delete])

      newest_privileges = PrivilegesService.create_privileges(created_privileges)
      # If the service failed for some reason, return HTTP Code 400 (Bad Request)
      if newest_privileges == nil
        return render :json => nil, :status => 400
      else
        return render :json => JSON.pretty_generate(newest_privileges.as_json), :status => 201
      end
    end

  end

  def put_privileges

    # List of parameters to look for in the request.
    required_parameters = [:department_id, :rank_id, :create, :read, :update, :delete]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's a privileges with that ID.
    privileges_id = PrivilegesService.get_privileges(params[:rank_id])

    if privileges_id == nil
      return render :json => nil, :status => 404
    end

    # If there's another privileges with that name already, return error.
    if privileges_id != nil && params[:rank_id].to_i != privileges_id.rank_id.to_i
      return render :json => "There's already privileges for this rank.", :status => 409
    else
      # If everything is fine, execute the service.

      # Create new privileges object and populate it with the new data.
      privileges = RankPrivilege.new
      privileges.department_id = params[:department_id].to_i
      privileges.rank_id = params[:rank_id].to_i
      privileges.create = ActiveModel::Type::Boolean.new.cast(params[:create])
      privileges.read = ActiveModel::Type::Boolean.new.cast(params[:read])
      privileges.update = ActiveModel::Type::Boolean.new.cast(params[:update])
      privileges.delete = ActiveModel::Type::Boolean.new.cast(params[:delete])

      # Execute the service to update the existing privileges.
      updated_privileges = PrivilegesService.update_privileges(params[:id], privileges)
      if updated_privileges == nil
        return render :json => nil, :status => 400
      else
        # Return the data in JSON Format, with HTTP Code 200 (OK)
        return render :json => JSON.pretty_generate(updated_privileges.as_json), :status => 200
      end

    end
  end

  def delete_privileges

    # Check if there's a privileges with that ID.
    privileges_id = PrivilegesService.get_privileges(params[:rank_id])

    # If it doesn't exist, return null.
    if privileges_id == nil
      return render :json => nil, :status => 404
    else
    # In case it does, execute the service and use HTTP Code 200 (OK)
      deleted_privileges = PrivilegesService.delete_privileges(params[:id])
      return render :json => JSON.pretty_generate(deleted_privileges.as_json), :status => 200
    end

  end

end