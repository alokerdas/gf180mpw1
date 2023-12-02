// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [63:0] la_data_in,
    output [63:0] la_data_out,
    input  [63:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

wire memenb0, memenb1, memenb2, memenb3, memenb4, memenb5, memenb6, memenb7, memenb8, memenb9;
wire [8:0] adr_mem0, adr_mem1, adr_mem2, adr_mem3, adr_mem4, adr_mem5, adr_mem6, adr_mem7, adr_mem8, adr_mem9;
wire [11:0] adr_cpu0, adr_cpu1, adr_cpu2, adr_cpu3, adr_cpu4, adr_cpu5, adr_cpu6, adr_cpu7, adr_cpu8, adr_cpu9;
wire [15:0] cpdatin0, cpdatin1, cpdatin2, cpdatin3, cpdatin4, cpdatin5, cpdatin6, cpdatin7, cpdatin8, cpdatin9;
wire [15:0] cpdatout0, cpdatout1, cpdatout2, cpdatout3, cpdatout4, cpdatout5, cpdatout6, cpdatout7, cpdatout8, cpdatout9;
wire [15:0] memdatin0, memdatin1, memdatin2, memdatin3, memdatin4, memdatin5, memdatin6, memdatin7, memdatin8, memdatin9;
wire [15:0] memdatout0, memdatout1, memdatout2, memdatout3, memdatout4, memdatout5, memdatout6, memdatout7, memdatout8, memdatout9;
wire cpuen0, cpuen1, cpuen2, cpuen3, cpuen4, cpuen5, cpuen6, cpuen7, cpuen8, cpuen9;
wire cpurw0, cpurw1, cpurw2, cpurw3, cpurw4, cpurw5, cpurw6, cpurw7, cpurw8, cpurw9;
wire memrwb0, memrwb1, memrwb2, memrwb3, memrwb4, memrwb5, memrwb6, memrwb7, memrwb8, memrwb9;
wire endisp0, endisp1, endisp2, endisp3, endisp4, endisp5, endisp6, endisp7, endisp8, endisp9;
wire enkbd, rst, clk;
wire [7:0] spi_cpu8, cpu_spi8, spi_cpu9, cpu_spi9, spi_cpu6, cpu_spi6, spi_cpu7, cpu_spi7;

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

soc_config mprj (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif

    .user_clock2(user_clock2),
    .wb_rst_i(wb_rst_i),

    // Logic Analyzer
    .la_data_in(la_data_in[36:0]),
    .la_oenb (la_oenb[36:0]),

    // IO Pads
    .io_in (io_in[21:20]),
    .io_oeb(io_oeb[37:0]),

    // CPU specific
    .en_keyboard(enkbd),
    .soc_clk(clk),
    .soc_rst(rst),

    // CPU0/MEM0 specific
    .addr_from_cpu0(adr_cpu0),
    .data_from_cpu0(cpdatout0),
    .data_to_cpu0(cpdatin0),
    .addr_to_mem0(adr_mem0),
    .data_from_mem0(memdatin0),
    .data_to_mem0(memdatout0),
    .rw_from_cpu0(cpurw0),
    .en_from_cpu0(cpuen0),
    .rw_to_mem0(memrwb0),
    .en_to_memB0(memenb0),
    .en_display0(endisp0),

    // CPU1/MEM1 specific
    .addr_from_cpu1(adr_cpu1),
    .data_from_cpu1(cpdatout1),
    .data_to_cpu1(cpdatin1),
    .addr_to_mem1(adr_mem1),
    .data_from_mem1(memdatin1),
    .data_to_mem1(memdatout1),
    .rw_from_cpu1(cpurw1),
    .en_from_cpu1(cpuen1),
    .rw_to_mem1(memrwb1),
    .en_to_memB1(memenb1),
    .en_display1(endisp1),

    // CPU2/MEM2 specific
    .addr_from_cpu2(adr_cpu2),
    .data_from_cpu2(cpdatout2),
    .data_to_cpu2(cpdatin2),
    .addr_to_mem2(adr_mem2),
    .data_from_mem2(memdatin2),
    .data_to_mem2(memdatout2),
    .rw_from_cpu2(cpurw2),
    .en_from_cpu2(cpuen2),
    .rw_to_mem2(memrwb2),
    .en_to_memB2(memenb2),
    .en_display2(endisp2),

    // CPU3/MEM3 specific
    .addr_from_cpu3(adr_cpu3),
    .data_from_cpu3(cpdatout3),
    .data_to_cpu3(cpdatin3),
    .addr_to_mem3(adr_mem3),
    .data_from_mem3(memdatin3),
    .data_to_mem3(memdatout3),
    .rw_from_cpu3(cpurw3),
    .en_from_cpu3(cpuen3),
    .rw_to_mem3(memrwb3),
    .en_to_memB3(memenb3),
    .en_display3(endisp3),

    // CPU4/MEM4 specific
    .addr_from_cpu4(adr_cpu4),
    .data_from_cpu4(cpdatout4),
    .data_to_cpu4(cpdatin4),
    .addr_to_mem4(adr_mem4),
    .data_from_mem4(memdatin4),
    .data_to_mem4(memdatout4),
    .rw_from_cpu4(cpurw4),
    .en_from_cpu4(cpuen4),
    .rw_to_mem4(memrwb4),
    .en_to_memB4(memenb4),
    .en_display4(endisp4),

    // CPU5/MEM5 specific
    .addr_from_cpu5(adr_cpu5),
    .data_from_cpu5(cpdatout5),
    .data_to_cpu5(cpdatin5),
    .addr_to_mem5(adr_mem5),
    .data_from_mem5(memdatin5),
    .data_to_mem5(memdatout5),
    .rw_from_cpu5(cpurw5),
    .en_from_cpu5(cpuen5),
    .rw_to_mem5(memrwb5),
    .en_to_memB5(memenb5),
    .en_display5(endisp5),

    // CPU6/MEM6 specific
    .addr_from_cpu6(adr_cpu6),
    .data_from_cpu6(cpdatout6),
    .data_to_cpu6(cpdatin6),
    .addr_to_mem6(adr_mem6),
    .data_from_mem6(memdatin6),
    .data_to_mem6(memdatout6),
    .rw_from_cpu6(cpurw6),
    .en_from_cpu6(cpuen6),
    .rw_to_mem6(memrwb6),
    .en_to_memB6(memenb6),
    .en_display6(),

    // CPU7/MEM7 specific
    .addr_from_cpu7(adr_cpu7),
    .data_from_cpu7(cpdatout7),
    .data_to_cpu7(cpdatin7),
    .addr_to_mem7(adr_mem7),
    .data_from_mem7(memdatin7),
    .data_to_mem7(memdatout7),
    .rw_from_cpu7(cpurw7),
    .en_from_cpu7(cpuen7),
    .rw_to_mem7(memrwb7),
    .en_to_memB7(memenb7),
    .en_display7(),

    // CPU8/MEM8 specific
    .addr_from_cpu8(adr_cpu8),
    .data_from_cpu8(cpdatout8),
    .data_to_cpu8(cpdatin8),
    .addr_to_mem8(adr_mem8),
    .data_from_mem8(memdatin8),
    .data_to_mem8(memdatout8),
    .rw_from_cpu8(cpurw8),
    .en_from_cpu8(cpuen8),
    .rw_to_mem8(memrwb8),
    .en_to_memB8(memenb8),
    .en_display8(),

    // CPU9/MEM9 specific
    .addr_from_cpu9(adr_cpu9),
    .data_from_cpu9(cpdatout9),
    .data_to_cpu9(cpdatin9),
    .addr_to_mem9(adr_mem9),
    .data_from_mem9(memdatin9),
    .data_to_mem9(memdatout9),
    .rw_from_cpu9(cpurw9),
    .en_from_cpu9(cpuen9),
    .rw_to_mem9(memrwb9),
    .en_to_memB9(memenb9),
    .en_display9()
);

cpu cpu0 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu0),
    .datain(cpdatin0),
    .dataout(cpdatout0),
    .en_inp(enkbd),
    .en_out(endisp0),
    .rdwr(cpurw0),
    .en(cpuen0),
    .keyboard(io_in[7:0]),
    .display(io_out[7:0])
);
gf180_mem512x8 memLword0 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem0),
    .D(memdatout0[7:0]),
    .Q(memdatin0[7:0]),
    .GWEN(memrwb0),
    .CEN(memenb0),
    .WEN({8{cpuen0}})
);
gf180_mem512x8 memHword0 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem0),
    .D(memdatout0[15:8]),
    .Q(memdatin0[15:8]),
    .GWEN(memrwb0),
    .CEN(memenb0),
    .WEN({8{cpuen0}})
);

cpu cpu1 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu1),
    .datain(cpdatin1),
    .dataout(cpdatout1),
    .en_inp(enkbd),
    .en_out(endisp1),
    .rdwr(cpurw1),
    .en(cpuen1),
    .keyboard(io_in[37:30]),
    .display(io_out[37:30])
);
gf180_mem512x8 memLword1 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem1),
    .D(memdatout1[7:0]),
    .Q(memdatin1[7:0]),
    .GWEN(memrwb1),
    .CEN(memenb1),
    .WEN({8{cpuen1}})
);
gf180_mem512x8 memHword1 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem1),
    .D(memdatout1[15:8]),
    .Q(memdatin1[15:8]),
    .GWEN(memrwb1),
    .CEN(memenb1),
    .WEN({8{cpuen1}})
);

cpu cpu2 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu2),
    .datain(cpdatin2),
    .dataout(cpdatout2),
    .en_inp(enkbd),
    .en_out(endisp2),
    .rdwr(cpurw2),
    .en(cpuen2),
    .keyboard(io_in[7:0]),
    .display(io_out[7:0])
);
gf180_mem512x8 memLword2 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem2),
    .D(memdatout2[7:0]),
    .Q(memdatin2[7:0]),
    .GWEN(memrwb2),
    .CEN(memenb2),
    .WEN({8{cpuen2}})
);
gf180_mem512x8 memHword2 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem2),
    .D(memdatout2[15:8]),
    .Q(memdatin2[15:8]),
    .GWEN(memrwb2),
    .CEN(memenb2),
    .WEN({8{cpuen2}})
);

cpu cpu3 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu3),
    .datain(cpdatin3),
    .dataout(cpdatout3),
    .en_inp(enkbd),
    .en_out(endisp3),
    .rdwr(cpurw3),
    .en(cpuen3),
    .keyboard(io_in[37:30]),
    .display(io_out[37:30])
);
gf180_mem512x8 memLword3 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem3),
    .D(memdatout3[7:0]),
    .Q(memdatin3[7:0]),
    .GWEN(memrwb3),
    .CEN(memenb3),
    .WEN({8{cpuen3}})
);
gf180_mem512x8 memHword3 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem3),
    .D(memdatout3[15:8]),
    .Q(memdatin3[15:8]),
    .GWEN(memrwb3),
    .CEN(memenb3),
    .WEN({8{cpuen3}})
);

cpu cpu4 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu4),
    .datain(cpdatin4),
    .dataout(cpdatout4),
    .en_inp(enkbd),
    .en_out(endisp4),
    .rdwr(cpurw4),
    .en(cpuen4),
    .keyboard(io_in[15:8]),
    .display(io_out[15:8])
);
gf180_mem512x8 memLword4 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem4),
    .D(memdatout4[7:0]),
    .Q(memdatin4[7:0]),
    .GWEN(memrwb4),
    .CEN(memenb4),
    .WEN({8{cpuen4}})
);
gf180_mem512x8 memHword4 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem4),
    .D(memdatout4[15:8]),
    .Q(memdatin4[15:8]),
    .GWEN(memrwb4),
    .CEN(memenb4),
    .WEN({8{cpuen4}})
);

cpu cpu5 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu5),
    .datain(cpdatin5),
    .dataout(cpdatout5),
    .en_inp(enkbd),
    .en_out(endisp5),
    .rdwr(cpurw5),
    .en(cpuen5),
    .keyboard(io_in[29:22]),
    .display(io_out[29:22])
);
gf180_mem512x8 memLword5 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem5),
    .D(memdatout5[7:0]),
    .Q(memdatin5[7:0]),
    .GWEN(memrwb5),
    .CEN(memenb5),
    .WEN({8{cpuen5}})
);
gf180_mem512x8 memHword5 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem5),
    .D(memdatout5[15:8]),
    .Q(memdatin5[15:8]),
    .GWEN(memrwb5),
    .CEN(memenb5),
    .WEN({8{cpuen5}})
);

cpu cpu6 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu6),
    .datain(cpdatin6),
    .dataout(cpdatout6),
    .en_inp(enkbd),
    .en_out(endisp6),
    .rdwr(cpurw6),
    .en(cpuen6),
    .keyboard(spi_cpu6),
    .display(cpu_spi6)
);
gf180_mem512x8 memLword6 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem6),
    .D(memdatout6[7:0]),
    .Q(memdatin6[7:0]),
    .GWEN(memrwb6),
    .CEN(memenb6),
    .WEN({8{cpuen6}})
);
gf180_mem512x8 memHword6 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem6),
    .D(memdatout6[15:8]),
    .Q(memdatin6[15:8]),
    .GWEN(memrwb6),
    .CEN(memenb6),
    .WEN({8{cpuen6}})
);

cpu cpu7 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu7),
    .datain(cpdatin7),
    .dataout(cpdatout7),
    .en_inp(enkbd),
    .en_out(endisp7),
    .rdwr(cpurw7),
    .en(cpuen7),
    .keyboard(spi_cpu7),
    .display(cpu_spi7)
);
gf180_mem512x8 memLword7 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem7),
    .D(memdatout7[7:0]),
    .Q(memdatin7[7:0]),
    .GWEN(memrwb7),
    .CEN(memenb7),
    .WEN({8{cpuen7}})
);
gf180_mem512x8 memHword7 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem7),
    .D(memdatout7[15:8]),
    .Q(memdatin7[15:8]),
    .GWEN(memrwb7),
    .CEN(memenb7),
    .WEN({8{cpuen7}})
);

cpu cpu8 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu8),
    .datain(cpdatin8),
    .dataout(cpdatout8),
    .en_inp(enkbd),
    .en_out(endisp8),
    .rdwr(cpurw8),
    .en(cpuen8),
    .keyboard(spi_cpu8),
    .display(cpu_spi8)
);
gf180_mem512x8 memLword8 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem8),
    .D(memdatout8[7:0]),
    .Q(memdatin8[7:0]),
    .GWEN(memrwb8),
    .CEN(memenb8),
    .WEN({8{cpuen8}})
);
gf180_mem512x8 memHword8 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem8),
    .D(memdatout8[15:8]),
    .Q(memdatin8[15:8]),
    .GWEN(memrwb8),
    .CEN(memenb8),
    .WEN({8{cpuen8}})
);

cpu cpu9 (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu9),
    .datain(cpdatin9),
    .dataout(cpdatout9),
    .en_inp(enkbd),
    .en_out(endisp9),
    .rdwr(cpurw9),
    .en(cpuen9),
    .keyboard(spi_cpu9),
    .display(cpu_spi9)
);
gf180_mem512x8 memLword9 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem9),
    .D(memdatout9[7:0]),
    .Q(memdatin9[7:0]),
    .GWEN(memrwb9),
    .CEN(memenb9),
    .WEN({8{cpuen9}})
);
gf180_mem512x8 memHword9 (
`ifdef USE_POWER_PINS
    .VDD(vdd),		// User area 5.0V supply
    .VSS(vss),		// User area ground
`endif
    .CLK(clk),
    .A(adr_mem9),
    .D(memdatout9[15:8]),
    .Q(memdatin9[15:8]),
    .GWEN(memrwb9),
    .CEN(memenb9),
    .WEN({8{cpuen9}})
);

spi_master spi_hub (
`ifdef USE_POWER_PINS
    .vdd(vdd),		// User area 5.0V supply
    .vss(vss),		// User area ground
`endif
// spi0
    .load0(endisp6),
    .unload0(enkbd),
    .datain0(cpu_spi6),
    .dataout0(spi_cpu6),
// spi1
    .load1(endisp7),
    .unload1(enkbd),
    .datain1(cpu_spi7),
    .dataout1(spi_cpu7),
// spi2
    .load2(endisp8),
    .unload2(enkbd),
    .datain2(cpu_spi8),
    .dataout2(spi_cpu8),
// spi3
    .load3(endisp9),
    .unload3(enkbd),
    .datain3(cpu_spi9),
    .dataout3(spi_cpu9),
// common
    .io_in(io_in[19:16]),
    .io_out(io_out[19:16]),
    .io_oeb(io_oeb[19:16]),
    .spirst(rst),
    .spiclk(clk)
);

endmodule	// user_project_wrapper

`default_nettype wire
