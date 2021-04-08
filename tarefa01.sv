//119110702
//Ricardo Adley da Silva Sena
//DESCRIPTION: Circuitos referentes aos exercicios 1 a 4 
//Exercicos em : < http://lad.ufcg.edu.br/loac/index.php?n=OAC.Comb >

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
  
  
  
//Questao 01

// Fim de Expediente

  /*Variaveis de entrada */
  
//noite (passou das 18:00 h) - SWI[4];
  logic eh_noite;
// paradas (todas as máquinas estão fora de operação) - SWI[5];
  logic paradas;
//sexta (é sexta-feira) - SWI[6];
  logic eh_sexta;
//producao (produção do dia foi atendida) - SWI[7]. 
  logic producao_atendida;
  
  /*saida*/
  logic sirene;
  
//sirene (tocar alarme) - LED[2]. 

//Conexao de variaveis de entrada

always_comb eh_noite <= SWI[4];
always_comb paradas <= SWI[5] ;
always_comb eh_sexta <= SWI[6];
always_comb producao_atendida <= SWI[7];

//Conexao de variavel de saida
always_comb LED[2] <= sirene;

//condicoes de acionamento da sirene

always_comb sirene <= (eh_noite & paradas) | (eh_sexta & producao_atendida & paradas);

//Questao 02

//Uma Agencia bancaria

	/*variaveis de entrada*/
	
//porta do cofre esta aberta/fechada
logic porta_cofre;

//a agencia esta no horario de funcionamento
logic relogio;

//o interruptor esta ativado/desativado
logic interruptor;

	/*saida*/
//tocar alarme - SEG[0]
logic alarme;

//Conexao de variaveis de entrada
always_comb porta_cofre <= SWI[0];
always_comb relogio <= SWI[1];
always_comb interruptor <= SWI[2];

//Conexao de variavel de saida
always_comb SEG[0] <= alarme;

//Condicao de disparo do alarme ( porta esta aberta e interruptor ligado ou porta esta aberta e não esta no horario)
always_comb alarme <= (porta_cofre & interruptor) | (porta_cofre & ~relogio);

//Questao 03

	/*variaveis de entrada*/
//temperatura maior/iqual a 15 e menor que 20
logic temp_maior_15;

//temperatura maior/iqual a 20
logic temp_maior_20;

//conexao variaveis de entrada
always_comb temp_maior_15 <= SWI[3]; 
always_comb temp_maior_20  <= SWI[4];


	/*saida*/
//ligar aquecedor
logic aquecedor;

//ligar resfriador
logic resfriador;

//avisar inconsistencia entre termometros
logic inconsistencia;

//conexao variaveis de saida
always_comb LED[6] <= aquecedor;
always_comb LED[7] <= resfriador;
always_comb SEG[7] <= inconsistencia;

//condicao para acionamento resfriador
always_comb resfriador <= (temp_maior_15 & temp_maior_20)&( ~inconsistencia);

//condicao para acionamento inconsistencia de termometros
always_comb inconsistencia <= (~temp_maior_15 & temp_maior_20);

//condicao para acionamento aquecedor
always_comb aquecedor <= (~temp_maior_15 & ~temp_maior_20) & ~inconsistencia;

//Questao 04

    /* variaveis entrada*/
//lavatorio 1 livre/ocupado
logic lavatorio_01;

//lavatorio 2 livre/ocupado

logic lavatorio_02;

//lavatorio 3 livra/ocupado
logic lavatorio_03;

//conexao variaveis de entrada
always_comb lavatorio_01 <= SWI[0];
always_comb lavatorio_02 <= SWI[1];
always_comb lavatorio_03 <= SWI[2];

    /*saida*/
//lavatorio disponivel para mulheres
logic livre_mulheres;

//lavatorio disponivel para homens
logic livre_homens;

//conexao variaveis de saida
always_comb LED[0] <=livre_mulheres;
always_comb LED[1] <= livre_homens;


//condicoes para acionamento dos leds de saida
always_comb livre_homens <= ~lavatorio_02 + ~lavatorio_03;
always_comb livre_mulheres <= ~lavatorio_01+~lavatorio_02+~lavatorio_03;
endmodule
