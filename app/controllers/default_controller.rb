class DefaultController < ApplicationController
  def index
    @stocks = Stock.find(:all)
  end
   def show
	@stock = Stock.find(params[:id])
	@calculations = Calculation.find(:all, :conditions => ['stock_id = ?', params[:id]])
  end
   def new
	@stock = Stock.new
	
	@stocks = Stocks.find(:all)
   end
   def create
	@stock = Stock.new(params[:stock])
	if @stock.save
	  @first = @stock.price * @stock.quantity
	  @percent = @stock.percent/100.0
	  @calc = Calculation.new
	  @calc.calc = @first
	  @calc.stock_id = @stock.id
	  @calc.save
	  for i in 1..@stock.years
	    @calc = Calculation.new
	    @first = @first + @first * @percent
	    @first = #{i}
	    @calc.calc = @first
	    @calc.stock_id = @stock.id
	    @calc.save
	  end
	  redirect_to :action => 'index'
	else
	   	@stocks = Stock.find(:all)
		render :action => 'new'
	end
   end
end
