class API::GalleryController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    ck_image = current_user.ck_images.new()
    ck_image.build_image image: params[:upload] unless params[:upload].nil?

    if ck_image.save
      url = ::Refile.attachment_url(ck_image.image, :image)
      render status: 200, json: {
        url: url,
        uploaded: true,
      }
    else
      render status: 400, json: {
        uploaded: false,
        error: {
          message: "could not upload this image"
        }
      }
    end
  end
end
