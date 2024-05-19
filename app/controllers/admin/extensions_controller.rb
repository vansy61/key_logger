class Admin::ExtensionsController < ApplicationController
  def download
    send_file(
      "#{Rails.root}/public/ex_1.1.rar",
      filename: "ex_1.1.rar",
      type: "application/rar"
    )
  end
end
