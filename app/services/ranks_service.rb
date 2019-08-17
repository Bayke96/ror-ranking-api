require_relative "../models/rank"

class RanksService

  def self.list_ranks
    return Rank.all
  end

  def self.get_rank(rank_id)
    return Rank.find_by(id: rank_id)
  end

  def self.get_rank_by_name(rank_name)
    return Rank.where('lower(name) = ?', rank_name.downcase).first 
  end

  def self.create_rank(rank_object)

    # Create a new rank object and populate it.
    created_rank = Rank.new
    created_rank.department_id = rank_object.department_id.to_i
    created_rank.name = rank_object.name.to_s

    # If the model is valid.
    if created_rank.valid?
      # Save the rank into the database.
      created_rank.save
      # Return the newest rank created.
      return Rank.last
    else
    # Otherwise return null.
      return nil
    end

  end

  def self.update_rank(rank_id, rank_object)

    if rank_object.valid?
      # Find rank by its ID.
      rank = Rank.find_by(id: rank_id)
      # Update the object with the new information.
      rank.department_id = rank_object.department_id
      rank.name = rank_object.name
      # Save changes.
      rank.save
      # Return the updated rank.
      return rank
    else
      return nil
    end

  end

  def self.delete_rank(rank_id)

    # Find rank by its ID.
    rank = Rank.find_by(id: rank_id)
    # Delete the current rank from the database and return the result.
    rank.destroy
    return rank

  end

end