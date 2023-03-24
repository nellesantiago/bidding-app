module UsersHelper
  def avatar_for(user)
    dicebear_seed = Digest::MD5::hexdigest(user.email.downcase)
    dicebear_url = "https://api.dicebear.com/5.x/lorelei/svg?seed=#{dicebear_seed}"
    image_tag(dicebear_url, alt: user.full_name, class: "dicebear_avatars")
  end

  def require_correct_user
    correct = current_user == User.find(params[:id])
    unless correct || current_user.admin?
      flash[:danger] = "Invalid user permission!"
      redirect_to products_path
    end
  end

  def restrict_admin
    if current_user.admin?
      flash[:danger] = "Invalid user permission!"
      redirect_to products_path
    end
  end
end
