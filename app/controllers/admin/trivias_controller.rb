class Admin::TriviasController < Admin::SharedController
  def index
    @topics = Topic.order('created_at DESC')
  end

end
