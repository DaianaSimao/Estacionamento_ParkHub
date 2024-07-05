class VersionsController < ApplicationController
  def index
    @versions = PaperTrail::Version.order(created_at: :desc)
  end

  def show
    @version = PaperTrail::Version.where(item_id: params[:id])
  end
end
