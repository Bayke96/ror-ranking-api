require_relative "../models/rank"
require_relative "../services/ranks_service"

class RanksController < ApplicationController

  def list_ranks

    # Call service to return all rank records.
    rank_list = RanksService.list_ranks

    # If rank list is empty, return HTTP Code 204 (No Content)
    if rank_list.length == 0
      return render :json => nil, :status => 204
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(rank_list.as_json), :status => 200
    end

  end

  def get_rank

    # Call service to find the rank by its ID.
    found_rank = RanksService.get_rank(params[:id])

    # If rank wasn't found, return HTTP Code 404 (Not Found)
    if found_rank == nil
      return render :json => nil, :status => 404
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(found_rank.as_json), :status => 200
    end

  end

  def post_rank

    # List of parameters to look for in the request.
    required_parameters = [:department_id, :name]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's already a rank with this name.
    find_rank = RanksService.get_rank_by_name(params[:name])

    # If there's already a rank with this name, return error.
    if find_rank != nil
      return render :json => "There's already a rank with this name.", :status => 409
    else
      # Create new rank object and fill it with request data.
      created_rank = Rank.new
      created_rank.department_id = params[:department_id].to_i
      created_rank.name = params[:name].to_s
      newest_rank = RanksService.create_rank(created_rank)
      # If the service failed for some reason, return HTTP Code 400 (Bad Request)
      if newest_rank == nil
        return render :json => nil, :status => 400
      else
        return render :json => JSON.pretty_generate(newest_rank.as_json), :status => 201
      end
    end

  end

  def put_rank

    # List of parameters to look for in the request.
    required_parameters = [:department_id, :name]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's a rank with that ID.
    rank_id = RanksService.get_rank(params[:id])

    if rank_id == nil
      return render :json => nil, :status => 404
    end

    # Check if the new name conflicts with another one.
    find_rank = RanksService.get_rank_by_name(params[:name])

    # If there's another rank with that name already, return error.
    if find_rank != nil && params[:id].to_i != find_rank.id.to_i
      return render :json => "There's already a rank with this name.", :status => 409
    else
      # If everything is fine, execute the service.

      # Create new rank object and populate it with the new data.
      rank = Rank.new
      rank.department_id = params[:department_id].to_i
      rank.name = params[:name].to_s

      # Execute the service to update the existing rank.
      updated_rank = RanksService.update_rank(params[:id], rank)
      if updated_rank == nil
        return render :json => nil, :status => 400
      else
        # Return the data in JSON Format, with HTTP Code 200 (OK)
        return render :json => JSON.pretty_generate(updated_rank.as_json), :status => 200
      end

    end
  end

  def delete_rank

    # Check if there's a rank with that ID.
    rank_id = RanksService.get_rank(params[:id])

    # If it doesn't exist, return null.
    if rank_id == nil
      return render :json => nil, :status => 404
    else
    # In case it does, execute the service and use HTTP Code 200 (OK)
      deleted_rank = RanksService.delete_rank(params[:id])
      return render :json => JSON.pretty_generate(deleted_rank.as_json), :status => 200
    end

  end

end