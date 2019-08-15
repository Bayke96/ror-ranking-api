require_relative "../models/department"
require_relative "../services/departments_service"

class DepartmentsController < ApplicationController

  def list_department
  end

  def get_department(id)
  end

  def post_department

  # Create new department object and fill it with Request data.
  created_department = Department.new
  created_department.name = params[:name].to_s
  DepartmentsService.create_department(created_department)

  # Return HTTP Code 200 (OK) if the process was successful.
  head 201
  end

  def put_department
  end

  def delete_department
  end

end