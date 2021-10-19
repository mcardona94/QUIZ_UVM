class Item extends uvm_sequence_item;
  rand bit in; //se crea la variable de entrada aleatoria 
  bit out; //Se crea la variable de salida fija    //Se incribe el objeto Item en la fabrica
  `uvm_object_utils_begin(Item)
  `uvm_field_int(in, UVM_DEFAULT)
  `uvm_field_int(out, UVM_DEFAULT)
  `uvm_object_utils_end 
  
  
  virtual function string convert2str();
    return $sformatf("in=%0d, out=%0d",in,out);
  endfunction

  function new(string name = "Item");
    super.new(name);
  endfunction

endclass