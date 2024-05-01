class Admin::ExtensionsController < ApplicationController
  def download
    send_file(
      "#{Rails.root}/public/ex.rar",
      filename: "ex.rar",
      type: "application/rar"
    )
  end
end
