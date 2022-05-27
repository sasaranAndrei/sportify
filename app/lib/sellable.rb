module Sellable
  def price
    raise NotImplementedError, 'Define price in the concrete products!'
  end
end
