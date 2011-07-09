class CalculationController < ApplicationController
  def calcs
    @calculations = Calculation.find(:all)
  end
end
