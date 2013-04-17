class Admin::PlayersController < Admin::SharedController

  # GET /admin/players
  def index
    @players = Player.includes(:user)
  end
end
