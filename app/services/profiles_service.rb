require_relative "../models/user_profile"

class ProfilesService

  def self.get_profile(profile_id)
    return UserProfile.find_by(id: profile_id)
  end

  def self.get_profile_by_user(user_fk)
    return UserProfile.find_by(user_id: user_fk)
  end

  def self.create_profile(profile_object)

    # Create a new user profile and populate it.
    created_profile = UserProfile.new
    created_profile.user_id = profile_object.user_id
    created_profile.firstname = profile_object.firstname
    created_profile.lastname = profile_object.lastname
    created_profile.email = profile_object.email
    created_profile.phonenumber = profile_object.phonenumber
    created_profile.address = profile_object.address

    # If the model is valid.
    if created_profile.valid?
      # Save the user profile into the database.
      created_profile.save
      # Return the newest user profile created.
      return UserProfile.last
    else
    # Otherwise return null.
      return nil
    end

  end

  def self.update_profile(profile_id, profile_object)

    # Find user profile by its ID.
      profile = UserProfile.find_by(id: profile_id)
      profile_object.user_id = profile.user_id
      # Update the object with the new information.
      profile.firstname = profile_object.firstname
      profile.lastname = profile_object.lastname
      profile.email = profile_object.email
      profile.phonenumber = profile_object.phonenumber
      profile.address = profile_object.address
      # Save changes.
      if profile.save
        # Return the updated user profile.
        profile = UserProfile.find_by(id: profile_id)
        return profile
      else
        return nil
      end

  end

  def self.delete_profile(profile_id)
    # Find user profile by its ID.
    profile = UserProfile.find_by(id: profile_id)
    # Delete the current user profile from the database and return the result.
    profile.destroy
    return profile
  end

end