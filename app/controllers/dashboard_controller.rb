class DashboardController < ApplicationController
  before_action :require_authentication

  def show
    authorize :dashboard, :show?
  end
end
