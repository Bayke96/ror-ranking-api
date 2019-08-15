class DepartmentService

  def get_department()
  end

  def get_department(id)
  end

  def create_department(department)

  insert_department = department.new

  insert_department.name = department.name
  insert_department.employees = 0
  insert_department.save

  end

  def update_department(id, department)
  end

  def delete_department(id)
  end

end