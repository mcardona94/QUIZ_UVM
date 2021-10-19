class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  function new(string name = "base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  env e0;
  bit[`LENGTH-1:0] pattern = 4'b1011;
  gen_item_seq  seq;
  virtual dut_if  vif;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e0 = env::type_id::create("e0",this);
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif",vif))
      `uvm_fatal("TEST","Did not get vif")
    uvm_config_db#(virtual dut_if)::set(this, "e0.a0.*","dut_vif",vif);
    
    uvm_config_db#(bit[`LENGTH-1:0])::set(this,"*","ref_pattern",pattern);
  endfunction

  virtual task run_phase(uvm_phase phase);
    gen_item_seq seq = gen_item_seq::type_id::create("seq");
    phase.raise_objection(this);
    apply_reset();
	seq.randomize();
    seq.start(e0.a0.s0);
    #200;
    phase.drop_objection(this);
  endtask

  virtual task apply_reset();
    vif.rstn <= 0;
    vif.in <= 0;
    repeat(5) @(posedge vif.clk);
    vif.rstn <=1;
    repeat(10) @(posedge vif.clk);
  endtask
endclass

