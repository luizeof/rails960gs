# The program takes an initial word or phrase from
# the command line (or in the absence of a
# parameter from the first line of standard
# input).  In then reads successive words or
# phrases from standard input and reports whether
# they are angrams of the first word.
#
# Author::    Luiz Eduardo de Oliveira Fomseca - Agência Orangeweb  (mailto:atendimento@orangeweb.com.br)
# Copyright:: Copyright (c) 2011 Agência Orangeweb, MEI
# License::   MIT

# This class holds the letters in the original
# word or phrase. The is_anagram? method allows us
# to test if subsequent words or phrases are
# anagrams of the original

require 'railtie.rb'

# GEM Rails960gs 
module Rails960gs  
                
  # Extende os Helpers da Aplicação
  module ViewHelper

  #Consiste a option[:class]
  @@options_build = lambda  do |options|
    unless options.has_key?(:class) then
		   options[:class] = String.new
	  else
		   options[:class] = options[:class].to_s.downcase
	  end  
  end        
        
  
  # Carrega o CSS necessário para o funcionamento do 960.gs do CDN *cachedcommons.org*
  def cdn_960gs (options={ :min=>true, :reset => false})    
    
    if options[:min] then
     @@out = stylesheet_link_tag "http://cachedcommons.org/cache/960/0.0.0/stylesheets/960-min.css"
    else  
     @@out = stylesheet_link_tag "http://cachedcommons.org/cache/960/0.0.0/stylesheets/960.css" 
    end 
    
    if options[:reset] then
     @@out = stylesheet_link_tag "http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css"
    end    
    
    @@out      
  end
  

  # Monta o Container principal do 960.gs	
  def gs_container(options={}, &block)
	@@options_build.call options
	content_body = capture(&block)
    options[:class].insert(-1, "container_12")
	@@out = content_tag(:div, content_body, options)
	@@out
  end 	
 	
  
  # Monta uma Linha inteira com 12 Colunas + a classe "clear"
  def gs_clear
	@@options_build.call options
    options[:class].insert(-1, " clear ")
	@@out = content_tag(:div, "", options)
	@@out
  end   
  
  
  # Monta uma coluna com X itens e todas as opcoes do 960.gs 
  # O número de colunas deve ser passado como primeiro parâmetro 
  # Ex: <%= gs_col 12 do %> bla bla bla <% end %>                
  # As opções normais para Tags devem ser passados como segundo parâmetro 
  # Ex: <%= gs_col 4, :id => "sidebar" do %> bla bla bla <% end %> 
  # <b>Outros Parâmetros</b>
  # * <b>:alpha => (true|false)</b> - Especifica se a coluna é alpha - (Default = false)
  # * <b>:omega => (true|false)</b> - Especifica se a coluna é omega - (Default = false)      
  # * <b>:prefix => (1-12)</b> - Especifica se a coluna é do tipo prefix - (Default = nil)
  # * <b>:suffix => (1-12)</b> - Especifica se a coluna é do tipo suffix - (Default = nil) 
  
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