//Ricardo Adley da Silva Sena
//DESCRIPTION: Exercicios display de 7 segmentos Exercicos em : < http://lad.dsc.ufcg.edu.br/loac/index.php?n=OAC.Seg7 >

parameter NINSTR_BITS = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;
module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NINSTR_BITS-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
             lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

  always_comb begin
    lcd_WriteData <= SWI;
    lcd_pc <= 'h12;
    lcd_instruction <= 'h34567890;
    lcd_SrcA <= 'hab;
    lcd_SrcB <= 'hcd;
    lcd_ALUResult <= 'hef;
    lcd_Result <= 'h11;
    lcd_ReadData <= 'h33;
    lcd_MemWrite <= SWI[0];
    lcd_Branch <= SWI[1];
    lcd_MemtoReg <= SWI[2];
    lcd_RegWrite <= SWI[3];
    for(int i=0; i<NREGS_TOP; i++) lcd_registrador[i] <= i+i*16;
    lcd_a <= {56'h1234567890ABCD, SWI};
    lcd_b <= {SWI, 56'hFEDCBA09876543};
  end
  parameter segmentos = 7;
  logic w;
  logic x;
  logic y;
  logic z;
  logic [segmentos-1:0] controlador ;
  logic [3:0] notas; 
	logic opcao;
always_comb begin
	w <= SWI[0];
    	x <= SWI[1];
    	y <= SWI[2];
    	z <= SWI[3];
	controlador <= {SWI[5], SWI[4], z, y, x, w};
	
	//Exibicao em hexadecimal
	case(controlador[5:0])
	0: SEG[segmentos-1:0]<=7'b0111111;
	1: SEG[segmentos-1:0] <= 7'b0000110;
        2: SEG[segmentos-1:0] <= 7'b1011011;
        3: SEG[segmentos-1:0] <= 7'b1001111;
        4: SEG[segmentos-1:0] <= 7'b1100110;
        5: SEG[segmentos-1:0] <= 7'b1101101;
        6: SEG[segmentos-1:0] <= 7'b1111101;
        7: SEG[segmentos-1:0] <= 7'b0000111;
        8: SEG[segmentos-1:0] <= 7'b1111111;
        9: SEG[segmentos-1:0] <= 7'b1101111;
	10: SEG[segmentos-1:0] <= 7'b1110111;
        11: SEG[segmentos-1:0] <= 7'b1111100;
        12: SEG[segmentos-1:0] <= 7'b0111001;
        13: SEG[segmentos-1:0] <= 7'b1011110;
        14: SEG[segmentos-1:0] <= 7'b1111001;
        15: SEG[segmentos-1:0] <= 7'b1110001;
        
        
        
        // Alfabeto
        16: SEG[segmentos-1:0] <= 7'b1110111; // A
        17: SEG[segmentos-1:0] <= 7'b1111100; // b
        18: SEG[segmentos-1:0] <= 7'b0111001; // C
        19: SEG[segmentos-1:0] <= 7'b1011000; // c
        20: SEG[segmentos-1:0] <= 7'b1011110; // d
        21: SEG[segmentos-1:0] <= 7'b1111001; // E
        22: SEG[segmentos-1:0] <= 7'b1110001; // F
        23: SEG[segmentos-1:0] <= 7'b1101111; // g
        24: SEG[segmentos-1:0] <= 7'b1110110; // H
        25: SEG[segmentos-1:0] <= 7'b1110100; // h
        26: SEG[segmentos-1:0] <= 7'b0000110; // I
        27: SEG[segmentos-1:0] <= 7'b0000100; // i
        28: SEG[segmentos-1:0] <= 7'b0011110; // J
        29: SEG[segmentos-1:0] <= 7'b0111000; // L
        30: SEG[segmentos-1:0] <= 7'b1010100; // n
        31: SEG[segmentos-1:0] <= 7'b0111111; // O
        32: SEG[segmentos-1:0] <= 7'b1011100; // o
        33: SEG[segmentos-1:0] <= 7'b1110011; // P
        34: SEG[segmentos-1:0] <= 7'b1100111; // q
        35: SEG[segmentos-1:0] <= 7'b1010000; // r
        36: SEG[segmentos-1:0] <= 7'b1101101; // S
        37: SEG[segmentos-1:0] <= 7'b1111000; // t
        38: SEG[segmentos-1:0] <= 7'b0111110; // U
        39: SEG[segmentos-1:0] <= 7'b0011100; // u
        40: SEG[segmentos-1:0] <= 7'b1101110; // y
        41: SEG[segmentos-1:0] <= 7'b1100011; // º 
	default: SEG[segmentos-1:0] <= 7'b1000000;  
    endcase
    opcao <= SWI[7];
    notas <= SWI[3:0];
    if(opcao)
	case(notas[3:0])
	//mostra situacao P,A,F
		0: SEG[segmentos-1:0]<=7'b1110011;
		1: SEG[segmentos-1:0] <= 7'b1110011;
		2: SEG[segmentos-1:0] <= 7'b1110011;
		3: SEG[segmentos-1:0] <= 7'b1110011;
		4: SEG[segmentos-1:0] <= 7'b1110001;
		5: SEG[segmentos-1:0] <= 7'b1110001;
		6: SEG[segmentos-1:0] <= 7'b1110001;
		7: SEG[segmentos-1:0] <= 7'b1110111;
		8: SEG[segmentos-1:0] <= 7'b1110111;
		9: SEG[segmentos-1:0] <= 7'b1110111;
		default: SEG[segmentos-1:0] <= 7'b1000000; 
        endcase
        else 
        	case(notas[3:0])
        	//mostra valor notas
		0: SEG[segmentos-1:0]<=7'b0111111;
		1: SEG[segmentos-1:0] <= 7'b0000110;
		2: SEG[segmentos-1:0] <= 7'b1011011;
		3: SEG[segmentos-1:0] <= 7'b1001111;
		4: SEG[segmentos-1:0] <= 7'b1100110;
		5: SEG[segmentos-1:0] <= 7'b1101101;
		6: SEG[segmentos-1:0] <= 7'b1111101;
		7: SEG[segmentos-1:0] <= 7'b0000111;
		8: SEG[segmentos-1:0] <= 7'b1111111;
		9: SEG[segmentos-1:0] <= 7'b1101111;
		default: SEG[segmentos-1:0] <= 7'b1000000; 
        endcase
  end
  
endmodule
