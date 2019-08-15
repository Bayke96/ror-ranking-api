require_relative "../models/department"
require_relative "../services/departments_service"

class DepartmentsController < ApplicationController

  def list_department
  end

  def get_department(id)
  end

  def post_department

  created_department = Department.new
  created_department.name = 'Nop'
  created_department.employees = 0
  DepartmentsService.create_department(created_department)

  end

  def put_department
  end

  def delete_department
  end

end