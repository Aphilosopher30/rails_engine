class Revenue
  attr_reader :id, :revenue, :name

  def initialize(id, revenue)
    @id = id
    @name = Merchant.find_by(id: id).name
    if revenue == nil
      @revenue = 0
    else
      @revenue = revenue
    end
  end
end
