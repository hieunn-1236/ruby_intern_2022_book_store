module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t "title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def toastr_flash
    flash_messages = ""
    flash.each do |type, message|
      case type
      when "success" then type = "success"
      when "alert", "danger" then type = "error"
      end

      flash_messages << "toastr.#{type}('#{message}');" if message
    end
    javascript_tag flash_messages
  end

  def load_image photo
    photo.image.attached? ? photo.image : "p1.png"
  end
end
