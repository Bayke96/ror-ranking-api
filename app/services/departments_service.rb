require_relative "../models/department"

class DepartmentsService

  def self.get_department
  end

  def self.get_department(id)
  end

  def self.create_department(department_object)

  # Create a new department object and populate it.
  @createdDepartment = Department.new
  @createdDepartment.name = department_object.name.to_s
  @createdDepartment.employees = 0

  # Save the department into the database.
  @createdDepartment.save

  end

  def self.update_department(id, department_object)
  end

  def self.delete_department(id)
  end

end