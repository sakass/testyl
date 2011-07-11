class DefaultController < ApplicationController
   def list
	@stocks = Stock.find(:all)
   end
   def show
	@stock = Stock.find(params[:id])
	@calculations = Calculation.find(:all, :conditions => ['stock_id = ?', params[:id]])
# 	@chart = GoogleVisualr::Interactive::AreaChart.new
# 	# Add Column Headers
# 	@chart.add_column('string', 'Year' )
# 	@chart.add_column('number', 'Sales')
# 	@chart.add_column('number', 'Expenses')
# 	# Add Rows and Values
# 	@chart.add_rows(4)
# 	@chart.set_value(0, 0, '2004')
# 	@chart.set_value(0, 1, 1000)
# 	@chart.set_value(0, 2, 400)
# 	@chart.set_value(1, 0, '2005')
# 	@chart.set_value(1, 1, 1170)
# 	@chart.set_value(1, 2, 460)
# 	@chart.set_value(2, 0, '2006')
# 	@chart.set_value(2, 1, 1500)
# 	@chart.set_value(2, 2, 660)
# 	@chart.set_value(3, 0, '2007')
# 	@chart.set_value(3, 1, 1030)
# 	@chart.set_value(3, 2, 540)
  end
	#g = Gruff::Line.new #Define a New Graph
	#g.title = "My Graph" #Title for the Graph
	#g.data("Apples", [1, 2, 3, 4, 4, 3]) #Graph Data
	#g.data("Oranges", [4, 8, 7, 9, 8, 9])
	##g.data("Watermelon", [2, 3, 1, 5, 6, 8])
	#g.data("Peaches", [9, 9, 10, 8, 7, 9])
	#g.labels = {0 => '2003', 2 => '2004', 4 => '2005'} #Labels for Each of the Graph
	#send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => "arbitaryfilename.png")
   
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
	  redirect_to :action => 'list'
	else
	   	@stocks = Stock.find(:all)
		render :action => 'new'
	end
   end
end
