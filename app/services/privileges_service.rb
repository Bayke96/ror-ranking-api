require_relative "../models/rank_privilege"

class PrivilegesService

  def self.get_privileges(department_fk, rank_fk)
    return RankPrivilege.find_by(department_id: department_fk, rank_id: rank_fk)
  end

  def self.create_privileges(privilege_object)
    # Create a new privileges object and populate it.
    created_privileges = RankPrivilege.new
    created_privileges.department_id = privilege_object.department_id.to_i
    created_privileges.rank_id = privilege_object.rank_id.to_i
    created_privileges.create = privilege_object.create
    created_privileges.read = privilege_object.read
    created_privileges.update = privilege_object.update
    created_privileges.delete = privilege_object.delete

    # If the model is valid.
    if created_privileges.valid?
      # Save the department into the database.
      created_privileges.save
      # Return the newest department created.
      return RankPrivilege.last
    else
    # Otherwise return null.
      return nil
    end
  end

  def self.update_privileges(privilege_id, privilege_object)

    if privilege_object.valid?
      # Find the privileges by its ID.
      privileges = RankPrivilege.find_by(id: privilege_id)
      # Update the object with the new information.
      privileges.department_id = privilege_object.department_id.to_i
      privileges.rank_id = privilege_object.rank_id.to_i
      privileges.create = privilege_object.create
      privileges.read = privilege_object.read
      privileges.update = privilege_object.update
      privileges.delete = privilege_object.delete
      # Save changes.
      privileges.save
      # Return the updated privileges.
      return privileges
    else
      return nil
    end

  end

  def self.delete_privileges(privilege_id)

    # Find department by its ID.
    privileges = RankPrivilege.find_by(id: privilege_id)
    # Delete the current privileges from the database and return the result.
    privileges.destroy
    return privileges

  end

end