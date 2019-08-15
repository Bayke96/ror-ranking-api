class UsersService

  def get_user()
  end

  def get_user(id)
  end

  def create_user(user)

    insert_user = user.new

    insert_user.departmentfk = user.departmentfk
    insert_user.rankfk = user.rankfk
    insert_user.name = user.name
    insert_user.password = user.password

    insert_user.save

  end

  def edit_user(id, user)
  end

  def delete_user(id)
  end

end