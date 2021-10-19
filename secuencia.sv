class gen_item_seq extends uvm_sequence;
  `uvm_object_utils(gen_item_seq); //se inscribe el objeto en la fabrica 
  
  function new(string name="gen_item_seq"); //se le define el nombre el objeto creado
    super.new(name);
  endfunction
  
  rand int num; //numero de items que se van a enviar

  constraint c1{soft num inside {[10:100]};} //Se establece el intervalo de valores que el numero de items puede tener

  virtual task body();
    for(int i = 0; i<num;i++)begin
      Item m_item = Item::type_id::create("m_item");
      start_item(m_item);
      m_item.randomize();
      `uvm_info("SEQ",$sformatf("Generate new item: %s", m_item.convert2str()),UVM_HIGH)
      finish_item(m_item);
    end
    `uvm_info("SEQ",$sformatf("Done generation of %0d items", num),UVM_LOW);
  endtask

endclass