module ProductsHelper
  def avatar_for(product)
    dicebear_seed = Digest::MD5::hexdigest(product.name)
    dicebear_url = "https://api.dicebear.com/5.x/shapes/svg?seed=#{dicebear_seed}"
    image_tag(dicebear_url, alt: product.name, class: "dicebear_avatars")
  end
end
