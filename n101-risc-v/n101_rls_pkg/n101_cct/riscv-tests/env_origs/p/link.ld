OUTPUT_ARCH( "riscv" )
ENTRY(_start)

SECTIONS
{
  __stack_size = 2K;

  /*#`ifdef N100_CFG_ADDR_SIZE_IS_20*/
  . = 0x80000;
  /*#`endif N100_CFG_ADDR_SIZE_IS_20*/

  /*#`ifndef N100_CFG_ADDR_SIZE_IS_20*/
  . = 0x80000000;
  /*#`endnif N100_CFG_ADDR_SIZE_IS_20*/
  .text.init : { *(.text.init) }
  .tohost ALIGN(0x1000) : { *(.tohost) }
  .text ALIGN(0x1000) : { *(.text) }
  .data ALIGN(0x1000) : 
  { 
    *(.data)
    . = ALIGN(8);
    PROVIDE( __global_pointer$ = . + 0x800 );
  }
  .bss : { *(.bss) }
  .stack 0x`N100_CFG_ILM_BASE_ADDR`+ 
  (1 << `N100_CFG_ILM_ADDR_WIDTH`) - __stack_size :
  {
    PROVIDE( _heap_end = . );
    /*#`ifdef N100_CFG_HAS_NDSE  */ 
    PROVIDE( _sp = 0x`N100_CFG_ILM_BASE_ADDR` + 0x8000);
    /*#`endif N100_CFG_HAS_NDSE  */ 
    /*#`ifndef N100_CFG_HAS_NDSE */ 
    PROVIDE( _sp = 2K);
    /*#`endnif N100_CFG_HAS_NDSE */ 
  }
  _end = .;
}

