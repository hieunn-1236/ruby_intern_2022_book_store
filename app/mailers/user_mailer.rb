class UserMailer < ApplicationMailer
  def approve_order order
    @order = order
    mail to: @order.user.email, subject: t("admin.approve_order")
  end

  def reject_order order
    @order = order
    mail to: @order.user.email, subject: t("admin.reject_order")
  end
end
