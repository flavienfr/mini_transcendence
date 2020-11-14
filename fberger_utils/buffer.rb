require 'cloudinary'
cloudinary_res = Cloudinary::Uploader.upload("#{User.last.student_id.to_s}.jpg", { cloud_name: ENV["cloudinary_Cloud_name"], api_key: ENV["cloudinary_API_Key"], api_secret: ENV["cloudinary_API_Secret"] })

        File.delete(Rails.root.to_s + "/#{user.student_id.to_s}.jpg")
        puts 'cloudinary_res:', cloudinary_res
        # puts 'cloudinary_res["url"]:', cloudinary_res["url"]
        user.avatar = cloudinary_res["url"]