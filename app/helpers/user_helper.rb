module UserHelper

    # Signs up the given user info.
    def sign_up(user)
        new_user = User.new({name: "John Doe", email:"johndoe@example.com", password:"password"})
        new_user.profile = Profile.new
        new_user.save
    end

end