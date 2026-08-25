-- Author: Prof. Dr. Edson Antonio Batista
-- Build Matrix F and Phi
-- Calculates Phi_Phi, Phi_F, Phi_Rs
-- Calcules DelataU and Y
-- Exemplo to simulate one step
-- two clock (gera), Yout = C*xk
-- Simulation until Mv and Yout
-- Update 24/03/2026
-- Example 1.2: Model Predictive Control System Design and Implementation Using MATLAB
-- ============================================================================
-- PRÁTICA:
-- Sempre declarar explicitamente as bibliotecas utilizadas
-- Evita ambiguidade e melhora portabilidade do código
-- ============================================================================
library ieee;
library ieee_proposed;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use ieee_proposed.real_matrix_pkg.all;

entity Exemplo1 is
  port( clk, gera : in std_logic;
         rst : in bit;
         Yout : in real_matrix (0 to 0, 0 to 0); 
--rki : in real;
         Mv : out real_matrix (0 to 0, 0 to 0));
 -- ============================================================================
-- ENTITY = Interface do hardware
-- Define entradas e saídas do sistema
-- ============================================================================

end entity;
-- ============================================================================
-- ARCHITECTURE = Implementação do hardware
-- Aqui descrevemos como o sistema funciona internamente
-- ============================================================================
architecture horizon of Exemplo1 is
-- Exemplo book
	       	
-- ============================================================================
-- SINAIS = Representam hardware (registradores/fios)
-- Persistem entre ciclos de clock
-- Devem ser usados para saída e armazenamento de estado
-- ============================================================================
signal A : real_matrix (0 to 2, 0 to 2); -- Matrix A
signal B : real_matrix (0 to 2, 0 to 0); -- Matrix B
signal C : real_matrix (0 to 0, 0 to 2); -- Matric C
signal F : real_matrix (0 to 4, 0 to 2);
signal Phi : real_matrix (0 to 4, 0 to 2);
signal PhiT : real_matrix (0 to 2, 0 to 4);
signal Rs_setpoint : real_matrix (0 to 0, 0 to 4);
signal Rbarra : real_matrix (0 to 2, 0 to 2);
signal PhiTPhi : real_matrix (0 to 2, 0 to 2);
signal PhiTF : real_matrix (0 to 2, 0 to 2);
signal PhiTPhiRbarra : real_matrix (0 to 2, 0 to 2);
signal InvPhiTPhiRbarra : real_matrix (0 to 2, 0 to 2);
signal InvFinal : real_matrix (0 to 2, 0 to 2);
signal Gain_Kmpc : real_matrix (0 to 0, 0 to 2);
signal Gain_Ky : real_matrix (0 to 0, 0 to 0);
signal Saida : real_matrix (0 to 0, 0 to 0);
--=====================================================================
--integrador
constant dt : real := 0.01; 
signal integra : real := 0.0;


begin
-- ============================================================================
-- PROCESSO SÍNCRONO
-- Executa com base em clk e rst
-- Representa lógica sequencial (hardware real)
-- ============================================================================
process (clk,rst)

-- ==========================================================================
  -- VARIÁVEIS = Uso interno ao processo
  -- Atualização IMEDIATA (diferente de sinais)
  -- Ideais para cálculos sequenciais/matemáticos
  -- ==========================================================================		
 variable am : real_matrix (0 to 1, 0 to 1);
 variable cm : real_matrix (0 to 0, 0 to 1);
 variable bm : real_matrix (0 to 1, 0 to 0);
 variable Om1 : real_matrix (0 to 0, 0 to 1);
 variable Om2 : real_matrix (0 to 1, 0 to 0);
    
 variable CmAm : real_matrix (0 to 0, 0 to 1);
 variable CmBm : real_matrix (0 to 0, 0 to 0);

 variable Ae1 : real_matrix (0 to 2, 0 to 2); -- build Matrix A, 
 --variable Ae2 : real_matrix (0 to 0, 0 to 0); 
 variable Be1 : real_matrix (0 to 2, 0 to 0); -- build matrix B
 variable Ce1 : real_matrix (0 to 0, 0 to 2); -- build matrix C
 --==========================================================
-- To build matrix F
variable Fnp5 : real_matrix (0 to 4, 0 to 2) := zeros(5,3);
variable CA : real_matrix (0 to 0, 0 to 2):= zeros(1,3);
variable CA2 : real_matrix (0 to 0, 0 to 2):= zeros(1,3);
variable CA3 : real_matrix (0 to 0, 0 to 2):= zeros(1,3);
variable CA4 : real_matrix (0 to 0, 0 to 2):= zeros(1,3);
variable CA5 : real_matrix (0 to 0, 0 to 2):= zeros(1,3);
--=========================================================
-- to build matrix Phi
variable Phi5 : real_matrix(0 to 4, 0 to 2) := zeros(5,3);
variable CB : real_matrix(0 to 0, 0 to 0) := zeros(1,1);
variable CAB : real_matrix(0 to 0, 0 to 0) := zeros(1,1);
variable CA2B : real_matrix(0 to 0, 0 to 0) := zeros(1,1);
variable CA3B : real_matrix(0 to 0, 0 to 0) := zeros(1,1);
variable CA4B : real_matrix(0 to 0, 0 to 0) := zeros(1,1);
------------------------------------------------------------
-- Phi transpose
variable PhiT5 : real_matrix(0 to 2, 0 to 4) := zeros(3,5);
------====================-----------------===================
--PhiTranspose*Phi, Inversa
variable PhiT_Phi : real_matrix(0 to 2, 0 to 2) := zeros(3,3);
variable PhiTPhi_Rbarra : real_matrix(0 to 2, 0 to 2) := zeros(3,3);
variable InvPhiTPhi_Rbarra : real_matrix(0 to 2, 0 to 2) := zeros(3,3);
variable InversaCorrigida : real_matrix(0 to 2, 0 to 2) := zeros(3,3);
--========================================================
--Phi tranpose * F
variable PhiT_F : real_matrix(0 to 2, 0 to 2) := zeros(3,3);

--=========================================================
-- Vector Rs
variable Rs : real_matrix(0 to 0, 0 to 4):= zeros(1,5);
variable Rs_rki : real_matrix(0 to 0, 0 to 4):= zeros(1,5);
variable TransposeRs : real_matrix(0 to 4, 0 to 0):= zeros(5,1);
--=============================================================
-- Phi transpose * Rs Transpose
variable TranspPhi_Rs : real_matrix(0 to 2, 0 to 0):= zeros(3,1);

--variable rki : real;

--============================================================
-- Matrix Rbarra
variable RbNc : real_matrix (0 to 2, 0 to 2) := zeros(3,3);
variable RbarraW : real_matrix (0 to 2, 0 to 2) := zeros(3,3);
variable peso : real;
--===========================================================
-- Calcule Ky
variable vectorHumZero : real_matrix (0 to 0, 0 to 2) := zeros(1,3);
variable vectorHum : real_matrix (0 to 4, 0 to 0) := zeros(5,1);
variable Kmpc : real_matrix (0 to 0, 0 to 2):= zeros(1,3);
variable Kx : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable Ky : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
--=========================================================
variable vectorDeltaU : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable Uk : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable Uk_Mv : real_matrix (0 to 0, 0 to 0):= zeros(1,1);

variable atraso1 : real_matrix (0 to 2, 0 to 0):= zeros(3,1);
variable atraso2 : real_matrix (0 to 2, 0 to 0):= zeros(3,1);
variable atraso3 : real_matrix (0 to 2, 0 to 0):= zeros(3,1);
variable atraso4 : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable atraso5 : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable vectorXK_Delay : real_matrix (0 to 2, 0 to 0):= zeros(3,1);

variable vectorXK : real_matrix (0 to 2, 0 to 0):= zeros(3,1);
variable vectorXKhum : real_matrix (0 to 2, 0 to 0):= zeros(3,1);

variable ki : real; 

variable rki :real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable Yout : real_matrix (0 to 0, 0 to 0):= zeros(1,1); 
variable Error : real_matrix (0 to 0, 0 to 0):= zeros(1,1);

--======================================================
variable Xm : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable atraso6 : real_matrix (0 to 0, 0 to 0):= zeros(1,1);
variable atraso7 : real_matrix (0 to 0, 0 to 0):= zeros(1,1);



begin
-- ==========================================================================
  -- RESET (ASSÍNCRONO)
  -- Define condições iniciais do sistema
  -- Fundamental para evitar estados indefinidos (U, X)
  -- ==========================================================================
 if (rst = '1') then
-- State space am, bm and cm
-- matriz exemplo
 -- Inicialização do modelo do sistema
am := ((0.8187, 0.0), (0.09063, 1.0)); 
bm(0,0) := 0.1813;            
bm(1,0) := 0.009365; 

cm(0,0) := 0.1813;
cm(0,1) := 0.009365;

Om1(0,0) := 0.0;
Om1(0,1) := 0.0;
--rki := 10.0;
peso := 1.0;
RbNc := eye(3,3);

-- Estado inicial do sistema (condição inicial)
vectorXK(0,0) := 1.0;
vectorXK(1,0) := 4.0;
vectorXK(2,0) := 0.5;
ki := 0.0;
Uk(0,0) := 0.0;
vectorHumZero(0,0) := 1.0;
vectorHumZero(0,1) := 0.0;
vectorHumZero(0,1) := 0.0;
		

vectorHum(0,0) := 1.0;
vectorHum(1,0) := 1.0;
vectorHum(2,0) := 1.0;
vectorHum(3,0) := 1.0;
vectorHum(4,0) := 1.0;
		
		
--xi(0,0) := 0.1;
--xi(1,0) := 0.2;
rki(0,0) := 10.0;	
--Yout(0,0) := 0.0;	
--i <= 0;	
-- ==========================================================================
  -- BORDA DE SUBIDA DO CLOCK
  -- Define evolução temporal do sistema (k ? k+1)
  -- ==========================================================================
elsif (clk'event and clk = '1') then
-- Build Matrix A 
Ae1 := eye(3,3); -- inicia a montagem da matriz A_e (Matlab)
--buildmatrix(am, Ae1,0,0); -- Inseri a1 em Ae1 apartir de linha o e coluna 0
CmAm := cm*am; -- cria um vetor as matriz da planta
Om2 := transpose(Om1);
buildmatrix(am, Ae1, 0,0);
buildmatrix(CmAm, Ae1, 2,0); --  Monta parte da matriz A_e (Matlab)
buildmatrix(Om2, Ae1,0,2); -- Finaliza a montagem de A_e (Pode Simplicar)
-------------------------------------------------------------------------------------------------------------
-- Build Matrix B           
CmBm := cm*bm;
Be1 := ones(3,1);
buildmatrix(CmBm,Be1,2,0);
buildmatrix(bm,Be1,0,0);
-------------------------------------------------------------------------------------------------------------
-- Build Matrix C
Ce1 := ones(1,3);  
buildmatrix(Om1,Ce1,0,0);
--------------------------------------------------------
-- Matrix F
CA := Ce1*Ae1;
CA2 := CA*Ae1;
CA3 := CA2*Ae1;
CA4 := CA3*Ae1;
CA5 := CA4*Ae1;
buildmatrix(CA,Fnp5,0,0);
buildmatrix(CA2,Fnp5,1,0);
buildmatrix(CA3,Fnp5,2,0);
buildmatrix(CA4,Fnp5,3,0);
buildmatrix(CA5,Fnp5,4,0);
-------------------------------------------------------------------------------
--Matrix Phi
CB := Ce1*Be1;
CAB := CA*Be1;
CA2B := CA2*Be1;
CA3B := CA3*Be1;
CA4B := CA4*Be1;


buildmatrix(CB,Phi5,0,0);
buildmatrix(CB,Phi5,1,1);
buildmatrix(CB,Phi5,2,2);

buildmatrix(CAB,Phi5,1,0);
buildmatrix(CAB,Phi5,2,1);
buildmatrix(CAB,Phi5,3,2);

buildmatrix(CA2B,Phi5,2,0);
buildmatrix(CA2B,Phi5,3,1);
buildmatrix(CA2B,Phi5,4,2);

buildmatrix(CA3B,Phi5,3,0);
buildmatrix(CA3B,Phi5,4,1);

buildmatrix(CA4B,Phi5,4,0);
--===================================================
-- Phi transpose
PhiT5 := transpose(Phi5);
--===================================================
-- Vector Rs
Rs := ones(1,5);
Rs_rki := rki*Rs;
TransposeRs := transpose(Rs);
--=================================================
-- Phi transpose * Rs *rki
-- Verificar se é necessário
TranspPhi_Rs := PhiT5*TransposeRs;

--Rbarra
RbarraW := peso*(RbNc);
--=================================================
--PhiTPhi, ou seja, Phitranspose vezes Phi

PhiT_Phi := PhiT5*Phi;

PhiTPhi_Rbarra := PhiT_Phi + RbarraW;

InvPhiTPhi_Rbarra := inv(PhiTPhi_Rbarra);

InversaCorrigida(0,1):= (-1.0)*InvPhiTPhi_Rbarra(0,1);
InversaCorrigida(1,1):= (-1.0)*InvPhiTPhi_Rbarra(1,1);
InversaCorrigida(2,1):= (-1.0)*InvPhiTPhi_Rbarra(2,1);
--======================================================
-- Matrix Phi Transpose * F
PhiT_F := PhiT5*Fnp5;


--====================================================
-- Neste código, o uso de dois clocks foi mantido com fins educacionais,
-- para evidenciar a separação entre:
-- - atualização do modelo (estado)
-- - atualização do controlador (ganho)
--
-- ============================================================================
if (gera'event and gera = '1') then
--====================================================
-- Calculate of the Gain Kmpc
Kmpc := vectorHumZero*InversaCorrigida*PhiT_F;
--======================================================
-- Gain Ky
Ky := vectorHumZero*InversaCorrigida*PhiT5*vectorHum;
--======================================================
-- Gain Kk
Kx(0,0) := Kmpc(0,0);
--=====================================================
--vectorDeltaU
--If (ki = 3.0) then
--vectorDeltaU := Ky*(rki - Yout) - Kmpc*vectorXK;

vectorXKhum := Be1*Uk + Ae1*vectorXK;
atraso1 := vectorXKHum;
atraso2 := atraso1;
vectorXK := atraso2;

atraso3 := vectorXK;
vectorXK_Delay := atraso3;
atraso6(0,0) := vectorXK_Delay(0,0);
atraso7(0,0) := atraso6(0,0);
Xm(0,0) := atraso7(0,0);
--Yout := Ce1*vectorXK;
Error :=  Ky*(rki - Yout);
--vectorDeltaU := Error -Kmpc*vectorXK_Delay ;
vectorDeltaU := Error -Kx*Xm;

atraso4 := vectorDeltaU;
atraso5 := atraso4;
Uk := atraso5;

integra <= integra + dt;

Uk_Mv := integra*Uk;

Yout := Ce1*vectorXK;
end if;


end if;
 -- ==========================================================================
  -- INTERFACE INTERNA ? EXTERNA
  -- Variáveis ? sinais (visíveis na simulação/hardware)
  -- ==========================================================================
A <= Ae1;
B <= Be1;
C <= Ce1;
F <= Fnp5;
Phi <= Phi5;
PhiT <= PhiT5;
Rs_setpoint <= Rs_rki;
Rbarra <= RbarraW;
PhiTPhi <= PhiT_Phi;
PhiTPhiRbarra <= PhiTPhi_Rbarra;
InvPhiTPhiRbarra <= InvPhiTPhi_Rbarra;
InvFinal <= InversaCorrigida;
PhiTF <= PhiT_F;
Gain_Kmpc <= Kmpc;
Gain_Ky <= Ky;
Mv <= Uk_Mv;
Saida <= Yout;
end process;
    
end architecture;