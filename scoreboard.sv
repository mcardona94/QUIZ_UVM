class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  function new(string name="scoreboard",uvm_component parent=null);
    super.new(name, parent);
  endfunction

  bit[`LENGTH-1:0]  ref_pattern;
  bit[`LENGTH-1:0]  curr_pattern;
  bit               exp_out;//ifrjio

  uvm_analysis_imp #(Item, scoreboard) m_analysis_imp;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_analysis_imp = new("m_analysis_imp",this);
    if(!uvm_config_db#(bit[`LENGTH-1:0])::get(this,"*","ref_pattern",ref_pattern))
      `uvm_fatal("SCBD","Did not get ref_pattern !")
  endfunction

  virtual function write(Item item);

    curr_pattern = curr_pattern << 1 | item.in;

    `uvm_info("SCBD", $sformatf("in = %0d out = %0d / Reference Pattern = 0b%0b / Current Pattern = 0b%0b", item.in, item.out, ref_pattern, curr_pattern), UVM_LOW)
    
    if(item.out != exp_out) begin
      `uvm_error("SCBD",$sformatf("ERROR: output = %0d / expected output = %0d", item.out, exp_out))
    end else begin
      `uvm_info("SCBD",$sformatf("PASS: output = %0d / expected output = %0d",item.out, exp_out), UVM_LOW)
    end
    if(curr_pattern == 4'b101) begin
      if(item.in == 1) begin
        `uvm_info("SCBD",$sformatf("\n A patterns' match is expected on next state! \n"), UVM_LOW)
      end
    end

    if(!(ref_pattern ^ curr_pattern))begin
      `uvm_info("SCBD",$sformatf(" \n DUT detected that patterns match!! \n"),UVM_LOW)
      exp_out = 1;
    end else begin
      exp_out = 0;
    end
  endfunction

endclass