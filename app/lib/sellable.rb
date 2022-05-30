module Sellable
  def price
    raise NotImplementedError, 'Define <<price>> in the concrete products!'
  end

  def photo
    raise NotImplementedError, 'Define <<photo>> in the concrete products!'
  end

  def sample
    raise NotImplementedError, 'Define <<sample>> in the concrete products!'
  end
end
