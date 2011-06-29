require 'railtie.rb' 

module Rails960gs  
  module ViewHelper


  #Consiste a option[:class]
  @@options_build = lambda  do |options|
    unless options.has_key?(:class) then
		options[:class] = String.new
	else
		options[:class] = options[:class].to_s.downcase
	end  
  end  
  

  #Monta o Container principal do 960.gs	
  def gs_container(options={}, &block)
	@@options_build.call options
	content_body = capture(&block)
    options[:class].insert(-1, "container_12")
	@@out = content_tag(:div, content_body, options)
	@@out
  end 	
 	
  
  #Monta uma Linha inteira com 12 Colunas
  def gs_clear
	@@options_build.call options
    options[:class].insert(-1, " clear ")
	@@out = content_tag(:div, "", options)
	@@out
  end   
  
  
  #Monta uma coluna com X itens e todas as opcoes do 960.gs
  def gs_col cols=12, options={}, &block
  
  
    if cols.to_i > 12 then raise "O numero de colunas deve ser igual ou menor que 12."  end
     
    
    @@options_build.call options
    
    
    args = options
    
    args[:class].insert(-1, " grid_#{cols} " )
    
    
    if options.has_key?(:alpha) then
    	args[:class].insert(-1, " alpha ")
    end     
    
    
    if options.has_key?(:omega) then
    	args[:class].insert(-1, " omega ")
    end       
    
   
    
    if options.has_key?(:prefix) then
    	if options[:append].to_i >= 12 then raise "O numero de colunas deve ser igual ou menor que 12." end
    	args[:class].insert(-1, " prefix_#{options[:append]} ")
    end  
    
    
    if options.has_key?(:suffix) then
    	if options[:prepend].to_i >= 12 then raise "O numero de colunas deve ser igual ou menor que 12." end
    	args[:class].insert(-1, " suffix_#{options[:prepend]} ")
    end    
    
    
    if options.has_key?(:clear) then
    	args[:class].insert(-1, " clear ")
    end         	    	
	
	args[:class].rstrip!.lstrip!
	
	content_body = capture(&block)
    
	@@out = content_tag(:div, content_body, args)
	@@out
	
  end   

  end
end