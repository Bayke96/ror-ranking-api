require_relative "../models/user"

class UsersService

  def self.list_users
    return User.all
  end

  def self.get_user(user_id)
    return User.find_by(id: user_id)
  end

  def self.get_user_by_name(username)
    return User.where('lower(name) = ?', username.downcase).first 
  end

  def self.create_user(user_object)

    # Create a new user object and populate it.
    created_user = User.new
    created_user.department_id = user_object.department_id
    created_user.rank_id = user_object.rank_id
    created_user.name = user_object.name.to_s
    created_user.password = BCrypt::Password.create( user_object.password, cost: 13 )

    # If the model is valid.
    if created_user.valid?
      # Save the user into the database.
      created_user.save
      # Return the newest user created.
      return User.last
    else
    # Otherwise return null.
      return nil
    end

  end

  def self.update_user(user_id, user_object)

      # Find user by its ID.
      user = User.find_by(id: user_id)
      # Update the object with the new information.
      user.department_id = user_object.department_id.to_i
      user.rank_id = user_object.rank_id.to_i
      user.name = user_object.name.to_s
      # Save changes.
      user.save
      # Return the updated user.
      user = User.find_by(id: user_id)
      return user

  end

  def self.delete_user(user_id)

    # Find user by its ID.
    user = User.find_by(id: user_id)
    # Delete the current user from the database and return the result.
    user.destroy
    return user

  end

end