require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  fixtures :events

  #Check that one user cant be save with empty attributes
  test "User attributes must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
    assert user.errors[:name].any?
  end

  #Check uniquenness mail user
  test "User is not valid without a unique email user" do
      user = User.new(email: "david.ruizdelarosa@gmail.com",
                      name: "Daniel Perez")

      assert user.invalid?
      assert_equal ["has already been taken"], user.errors[:email]
  end

  #Check user creation
  test "sign up" do

    user = User.new({
      :email => "javierzo@gmail.com",
      :name => "David Ruiz",
      :password => "devisetest",
      :password_confirmation => "devisetest"
      })

    assert user.save, "User not signed up!"

  end

  #Check an user can update without password confirmation
  test "user edit without password" do
      user = users(:david)
      new_data = {
        :email => "david.ruizdelarosa@gmail.com",
        :name => "hafizlubis"
      }
      new_data = ActionController::Parameters.new(new_data)
      new_data = new_data.permit(:email, :name)
      user.update_without_password(new_data)

      assert_equal user.name, 'hafizlubis', "User is not updated"
  end


end
