require_relative "../models/department"

class DepartmentsService

  def self.list_department
    return Department.all
  end

  def self.get_department(department_id)
    return Department.find_by(id: department_id)
  end

  def self.get_department_by_name(department_name)
    return Department.where('lower(name) = ?', department_name.downcase).first 
  end

  def self.create_department(department_object)

    # Create a new department object and populate it.
    createdDepartment = Department.new
    createdDepartment.name = department_object.name.to_s
    createdDepartment.employees = 0

    # If the model is valid.
    if createdDepartment.valid?
      # Save the department into the database.
      createdDepartment.save
      # Return the newest department created.
      return Department.last
    else
    # Otherwise return null.
      return nil
    end
    

  end

  def self.update_department(department_id, department_object)

    if department_object.valid?
      # Find department by its ID.
      department = Department.find_by(id: department_id)
      # Update the object with the new information.
      department.name = department_object.name
      # Save changes.
      department.save
      # Return the updated department.
      return department
    else
      return nil
    end

  end

  def self.delete_department(department_id)

    # Find department by its ID.
    department = Department.find_by(id: department_id)
    # Delete the current department from the database and return the result.
    department.destroy
    return department

  end

end