require_relative "../models/department"
require_relative "../services/departments_service"

class DepartmentsController < ApplicationController

  def list_departments

    # Call service to return all department records.
    department_list = DepartmentsService.list_departments

    # If department list is empty, return HTTP Code 204 (No Content)
    if department_list.length == 0
      return render :json => nil, :status => 204
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(department_list.as_json), :status => 200
    end

  end

  def get_department

    # Call service to find the department by its ID.
    found_department = DepartmentsService.get_department(params[:id])

    # If department wasn't found, return HTTP Code 404 (Not Found)
    if found_department == nil
      return render :json => nil, :status => 404
    else
      # If okay, return HTTP Code 200 (OK)
      return render :json => JSON.pretty_generate(found_department.as_json), :status => 200
    end

  end

  def post_department

    # List of parameters to look for in the request.
    required_parameters = [:name]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's already a department with this name.
    find_department = DepartmentsService.get_department_by_name(params[:name])

    # If there's already a department with this name, return error.
    if find_department != nil
      return render :json => "There's already a department with this name.", :status => 409
    else
      # Create new department object and fill it with request data.
      created_department = Department.new
      created_department.name = params[:name].to_s
      newest_department = DepartmentsService.create_department(created_department)
      # If the service failed for some reason, return HTTP Code 400 (Bad Request)
      if newest_department == nil
        return render :json => nil, :status => 400
      else
        return render :json => JSON.pretty_generate(newest_department.as_json), :status => 201
      end
    end

  end

  def put_department

    # List of parameters to look for in the request.
    required_parameters = [:name]
    # If there are parameters missing, return Bad Request error.
    if !required_parameters.all? {|k| params.has_key? k}
      return render :json => nil, :status => 400
    end

    # Check if there's a department with that ID.
    department_id = DepartmentsService.get_department(params[:id])

    if department_id == nil
      return render :json => nil, :status => 404
    end

    # Check if the new name conflicts with another one.
    find_department = DepartmentsService.get_department_by_name(params[:name])

    # If there's another department with that name already, return error.
    if find_department != nil && params[:id].to_i != find_department.id.to_i
      return render :json => "There's already a department with this name.", :status => 409
    else
      # If everything is fine, execute the service.

      # Create new department object and populate it with the new data.
      department = Department.new
      department.name = params[:name].to_s

      # Execute the service to update the existing department.
      updated_department = DepartmentsService.update_department(params[:id], department)
      if updated_department == nil
        return render :json => nil, :status => 400
      else
        # Return the data in JSON Format, with HTTP Code 200 (OK)
        return render :json => JSON.pretty_generate(updated_department.as_json), :status => 200
      end

    end
  end

  def delete_department

    # Check if there's a department with that ID.
    department_id = DepartmentsService.get_department(params[:id])

    # If it doesn't exist, return null.
    if department_id == nil
      return render :json => nil, :status => 404
    else
    # In case it does, execute the service and use HTTP Code 200 (OK)
      deleted_department = DepartmentsService.delete_department(params[:id])
      return render :json => JSON.pretty_generate(deleted_department.as_json), :status => 200
    end

  end

end