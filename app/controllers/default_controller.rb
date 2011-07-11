class DefaultController < ApplicationController
   def list
	@stocks = Stock.find(:all)
   end
   def show
	@stock = Stock.find(params[:id])
	@calculations = Calculation.find(:all, :conditions => ['stock_id = ?', params[:id]])
	data_table = GoogleVisualr::DataTable.new
data_table.new_column('string', 'Year' ) 
data_table.new_column('number', 'Sales') 
data_table.new_column('number', 'Expenses') 

# Add Rows and Values 
data_table.add_rows([ 
  ['2004', 1000, 400], 
  ['2005', 1170, 460], 
  ['2006', 660, 1120], 
  ['2007', 1030, 540] 
])
option = { width: 400, height: 240, title: 'Company Performance' }
@chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
	#g = Gruff::Line.new #Define a New Graph
	#g.title = "My Graph" #Title for the Graph
	#g.data("Apples", [1, 2, 3, 4, 4, 3]) #Graph Data
	#g.data("Oranges", [4, 8, 7, 9, 8, 9])
	##g.data("Watermelon", [2, 3, 1, 5, 6, 8])
	#g.data("Peaches", [9, 9, 10, 8, 7, 9])
	#g.labels = {0 => '2003', 2 => '2004', 4 => '2005'} #Labels for Each of the Graph
	#send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => "arbitaryfilename.png")
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
	  redirect_to :action => 'list'
	else
	   	@stocks = Stock.find(:all)
		render :action => 'new'
	end
   end
end
