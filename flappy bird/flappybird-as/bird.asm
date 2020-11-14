;-----------------TABELA DE CONSTANTES-----------------------
ORIG                    8000h

END_PILHA       EQU     FDFFh

IO_WRITE        EQU     FFFEh
IO_POINTER      EQU     FFFCh
IO_LCD_WRITE    EQU     FFF5h
IO_LCD_POINTER  EQU     FFF4h
IO_DISPLAY_1    EQU     FFF0h
IO_DISPLAY_2    EQU     FFF1h
IO_DISPLAY_3    EQU     FFF2h
IO_DISPLAY_4    EQU     FFF3h
IO_LEDS         EQU     FFF8h
IO_END_FRASE1   EQU     0B22h
IO_END_FRASE2   EQU     0D1Ch
IO_END_FRASE3   EQU     0F20h
IO_END_PONT     EQU     0D2Ch

TEMP_END_CTRL   EQU     FFF7h
TEMP_END_CONT   EQU     FFF6h

END_MASC_INT    EQU     FFFAh
MASC_INT        EQU     1000110000000111b
LIMITE_INF      EQU     1700h
POS_INICIAL     EQU     0B14h

CAR_PASS1       EQU     '0'
CAR_PASS2       EQU     '>'
CAR_OBST        EQU     'X'
CAR_LIM         EQU     '-'
CAR_LIMPEZA     EQU     ' '
CAR_FIM_STR     EQU     '@'

INTERV_TEMPO    EQU     0019h ; 0019h - 0.976
MASC_PRNG       EQU     8016h ; PseudoRandomNumberGenerator
INTERV_OBST     EQU     000Bh ; 11
FIM_TAB_OBS     EQU     8018h

ESTADO_TEMPOR   WORD    0000h
CONTADOR_TEMPOR WORD    0000h               
LC_ATUAL_PASS   WORD    0B14h
NUM_PRNG        WORD    84D6h
ESTADO_JOGO     WORD    0000h
DIST_PERCORRIDA WORD    0000h
OBS_PERCORRIDOS WORD    0000h
NIVEIS_JOGO     WORD    C000h
NIVEL_JOGO      WORD    0008h
JOGO_PAUSA      WORD    0000h
ACCELERACAO     WORD    09CCh ; 09CCh - 9.8
VELOC_SALTO     WORD    F780h ; F780h    
                ORIG    8010h
TAB_OBST        TAB     8
                ORIG    8020h
MSG_I_1         STR     'Prepare-se@'
MSG_I_2         STR     'Prima o interruptor I1@'
MSG_F_1         STR     'Fim do Jogo@'
MSG_F_2         STR     'Pontuacao final: @'
MSG_F_3         STR     'I1 - Novo jogo@'
MSG_LCD_1       STR     'Distancia: @'
MSG_LCD_2       STR     'colunas@'
;Documentação:
;   R7    - Posição atual do passaro
;   R6    - Velocidade atual do passaro
;----------------------------------------------------------

;-----------------TABELA DE INTERRUPCOES-------------------

                ORIG    FE00h
INT0            WORD    I0
INT1            WORD    I1
INT2            WORD    I2
                ORIG    FE0Ah
INTA            WORD    IA
INTB            WORD    IB
                ORIG    FE0Fh
INT15           WORD    Temporizador

; --------------------- CORPO PROGRAMA ---------------------------------
                
                ORIG    0000h
                JMP     Jogo


; Temporizador: Rotina Atendimento temporizador
;#######################################################################
Temporizador:   INC     M[ESTADO_TEMPOR]
                RTI


; I0: Rotina Atendimento interrupcao, muda a veloc. atual
;#######################################################################
I0:             CMP     M[ESTADO_JOGO], R0
                BR.Z    I0_F
                MOV     R6, M[VELOC_SALTO]
I0_F:           RTI

; I1: Rotina Atendimento interrupcao
;#######################################################################
I1:             PUSH    R1
                CMP     M[ESTADO_JOGO], R0
                BR.Z    I1_F
                MOV     R1, C000h
                CMP     M[NIVEIS_JOGO], R1
                BR.Z    I1_F
                SHL     M[NIVEIS_JOGO], 2
                INC     M[NIVEL_JOGO]
                CALL    AtualizaLEDs
I1_F:           MOV     R1, 0001h
                MOV     M[ESTADO_JOGO], R1
                POP     R1
                RTI


; I2: Rotina Atendimento interrupcao
;#######################################################################
I2:             PUSH    R1
                CMP     M[ESTADO_JOGO], R0
                BR.Z    I2_F                
                MOV     R1, FFFFh
                CMP     M[NIVEIS_JOGO], R1
                BR.Z    I2_F
                SHRA    M[NIVEIS_JOGO], 2
                DEC     M[NIVEL_JOGO]
                CALL    AtualizaLEDs
I2_F:           POP     R1
                RTI


; IA: Rotina Atendimento interrupcao
;#######################################################################
IA:             CMP     M[ESTADO_JOGO], R0
                BR.Z    IA_F
                NEG     M[ACCELERACAO]
                NEG     M[VELOC_SALTO]
IA_F:           RTI


; IB: Rotina Atendimento interrupcao
;#######################################################################
IB:             PUSH    R1
                CMP     M[ESTADO_JOGO], R0
                BR.Z    IB_F
                MOV     R1, 0001h
                XOR     M[JOGO_PAUSA], R1
IB_F:           POP     R1                
                RTI


; PausaJogo: Pausa o jogo ou recomeça o jogo
;#######################################################################
PausaJogo:      PUSH    R1              
PausaJogo_1:    MOV     R1, 0001h
                CMP     M[JOGO_PAUSA], R1
                BR.Z    PausaJogo_1    
PausaJogo_F:    POP     R1
                RET


; AtivaTempor: Ativa o temporizador e coloca-o com um intervalo 100ms
;#######################################################################
AtivaTempor:    PUSH    R1
                MOV     R1, 0001h
                MOV     M[TEMP_END_CONT],  R1
                MOV     R1, 0001h
                MOV     M[TEMP_END_CTRL], R1
                POP     R1
                RET


; LimpaMemoria: Coloca as posições de memoria da tabela dos obst. a 0
;#######################################################################
LimpaMemoria:   PUSH    R1
                MOV     R1, TAB_OBST
LimpaMemoria_1: MOV     M[R1],  R0
                INC     R1
                CMP     R1, FIM_TAB_OBS
                BR.NZ   LimpaMemoria_1
                POP     R1
                RET


; LimpaEcra: Limpa a janela de texto
;#######################################################################
LimpaEcra:      PUSH    R1
                PUSH    R2
                PUSH    R3
                
                MOV     R1, 0000h           ; LINHA + COLUNA ATUAL
                MOV     R2, 0000h           ; LINHA ATUAL

LimpaEcra_1:    MVBH    R1, R2
                MOV     M[IO_POINTER], R1   ; escrita de um carater ' '
                MOV     R3, CAR_LIMPEZA
                MOV     M[IO_WRITE], R3
                
                ADD     R2, 0100h
                CMP     R2, 1800h
                BR.NZ   LimpaEcra_1
                MOV     R2, R0
                MVBH    R1, R2
                INC     R1
                CMP     R1, 004Fh
                BR.NZ   LimpaEcra_1
                POP     R3
                POP     R2
                POP     R1
                RET


; NumAleatorio: Gera numero aleatorio 0 - 15 , devolve pela pilha
;#######################################################################
NumAleatorio:   PUSH    R1
                PUSH    R2
                MOV     R1, M[NUM_PRNG]
                RORC    R1, 1
                BR.Z    NumAleatorio_1
                MOV     R2, M[NUM_PRNG]
                XOR     R2, MASC_PRNG
                MOV     M[NUM_PRNG], R2
NumAleatorio_1: ROR     M[NUM_PRNG], 1
                MOV     R1, 000Fh           ; 0 - 15
                MOV     R2, M[NUM_PRNG]
                DIV     R2, R1
                MOV     M[SP+4], R1
                POP     R2
                POP     R1
                RET


; EscNumLCD: Escreve um numero de 16 bits no LCD na posicao que recebe
;            pela pilha
;#######################################################################
EscNumLCD:      PUSH    R1          
                PUSH    R2          
                PUSH    R3
                MOV     R1, M[SP+6]             ; NUMERO
                MOV     R3, M[SP+5]             ; POSICAO
                ADD     R3, 5                   ; R3 - ULTIMA POSICAO
EscNumLCD_1:    CMP     R3, M[SP+5]     
                BR.Z    EscNumLCD_F         
                MOV     R2, 10                  ; algarismo da direita
                DIV     R1, R2                  ; fica em R2
                OR      R2, 0030h               ; codigo ASCII do digito
                MOV     M[IO_LCD_POINTER], R3   ; escrita do digito no LCD
                MOV     M[IO_LCD_WRITE], R2
                DEC     R3
                BR      EscNumLCD_1
EscNumLCD_F:    POP     R3
                POP     R2
                POP     R1
                RETN    2


; IniciaLCD: Inicia o LCD, excreve as strings "Distancia:" e "colunas"
;#######################################################################
IniciaLCD:      PUSH    R1          
                PUSH    R2          
                PUSH    R3          
                
                MOV     R1, MSG_LCD_1           ; R1 - ENDEREÇO CARATER
                MOV     R2, M[R1]               ; R2 - CARATER ATUAL
                MOV     R3, 8000h               ; R3 - ENDERECO LCD

IniciaLCD_1:    MOV     M[IO_LCD_POINTER], R3
                MOV     M[IO_LCD_WRITE], R2
                INC     R1
                INC     R3
                MOV     R2, M[R1]
                CMP     R2, CAR_FIM_STR         ; carater = '@'?
                BR.NZ   IniciaLCD_1

                MOV     R1, MSG_LCD_2           ; R1 - ENDEREÇO CARATER
                MOV     R2, M[R1]               ; R2 - CARATER ATUAL
                MOV     R3, 8015h               ; R3 - ENDERECO LCD

IniciaLCD_2:    MOV     M[IO_LCD_POINTER], R3
                MOV     M[IO_LCD_WRITE], R2
                INC     R1
                INC     R3
                MOV     R2, M[R1]
                CMP     R2, CAR_FIM_STR         ; carater = '@'?
                BR.NZ   IniciaLCD_2

                POP     R3
                POP     R2
                POP     R1
                RET


; AtualizaLCD: Atualiza a escrita no LCD da distancia percorrida
;#######################################################################
AtualizaLCD:    PUSH    R1
                PUSH    R2
                
                MOV     R1, M[DIST_PERCORRIDA]  ; dist. perc. em colunas
                MOV     R2, 800Ah               ; endereço de escrita
                PUSH    R1
                PUSH    R2
                CALL    EscNumLCD
                
                POP     R2
                POP     R1
                RET


; LimpaLCD: Limpa o LCD
;#######################################################################
LimpaLCD:       PUSH    R1
                MOV     R1, 8020h               ; move 8020h para pointer do LCD
                MOV     M[IO_LCD_POINTER], R1   ; (Bit 5 a 1 para limpar o LCD)
                POP     R1
                RET


; EscString: Escreve na janela de texto uma string na posição que recebe
;            pela pilha no endereço da string que recebe pela pilha
;#######################################################################
EscString:      PUSH    R1
                PUSH    R2
                PUSH    R3
                
                MOV     R1, M[SP+6]         ; endereço escrita str
                MOV     R2, M[SP+5]         ; endereço do começo da str
                MOV     R3, M[R2]
EscString_1:    MOV     M[IO_POINTER],  R1
                MOV     M[IO_WRITE],    R3
                INC     R1
                INC     R2
                MOV     R3, M[R2]
                CMP     R3, CAR_FIM_STR     ; carater = '@'?
                BR.NZ   EscString_1
                
                POP     R3
                POP     R2
                POP     R1
                RETN    2


; EscMsgInicial: Escreve na janela de texto a mensagem inicial de jogo
;#######################################################################
EscMsgInicial:  PUSH    R1
                PUSH    R2
                
                MOV     R1, IO_END_FRASE1       ; END ESCRITA FRASE 1
                MOV     R2, MSG_I_1             ; END FRASE 1
                PUSH    R1
                PUSH    R2
                CALL    EscString

                MOV     R1, IO_END_FRASE2       ; END ESCRITA FRASE 2
                MOV     R2, MSG_I_2             ; END FRASE 2
                PUSH    R1
                PUSH    R2
                CALL    EscString

                POP     R2
                POP     R1
                RET


; EscMsgFinal: Escreve na janela de texto a mensagem final de jogo
;#######################################################################
EscMsgFinal:    PUSH    R1
                PUSH    R2
                PUSH    R3

                MOV     R1, IO_END_FRASE1       ; END ESCRITA FRASE 1
                MOV     R2, MSG_F_1             ; END FRASE 1
                PUSH    R1
                PUSH    R2
                CALL    EscString

                MOV     R1, IO_END_FRASE2       ; END ESCRITA FRASE 2
                MOV     R2, MSG_F_2             ; END FRASE 2
                PUSH    R1
                PUSH    R2
                CALL    EscString

                MOV     R1, M[OBS_PERCORRIDOS]  ; NUMERO
                MOV     R3, IO_END_PONT         ; R3 - POSICAO INICIAL
                ADD     R3, 5
EscMsgFinal_1:  CMP     R3, IO_END_PONT      
                BR.Z    EscMsgFinal_2           
                MOV     R2, 10                  ; algarismo da direita
                DIV     R1, R2                  ; Fica em R2
                OR      R2, 0030h               ; codigo ASCII do digito
                MOV     M[IO_POINTER], R3       ; escrita digito na janela
                MOV     M[IO_WRITE], R2
                DEC     R3
                BR      EscMsgFinal_1

EscMsgFinal_2:  MOV     R1, IO_END_FRASE3       ; END ESCRITA FRASE 3
                MOV     R2, MSG_F_3             ; END FRASE 3
                PUSH    R1
                PUSH    R2
                CALL    EscString

                POP     R3
                POP     R2
                POP     R1
                RET


; EscreveLim: Escreve limite inferior ou superior para o espaço do jogo
;             na linha que recebe pela pilha
;#######################################################################
EscreveLim:     PUSH    R1
                PUSH    R2
                PUSH    R3

                MOV     R3, 004Eh           ; ultima coluna
                MOV     R1, M[SP+5]         ; linha onde escrever lim.
EscreveLim_1:   MOV     M[IO_POINTER], R1
                MOV     R2, CAR_LIM
                MOV     M[IO_WRITE], R2
                CMP     R3, R0              ; chegamos ao fim?
                BR.Z    EscreveLim_F
                INC     R1
                DEC     R3
                BR      EscreveLim_1

EscreveLim_F:   POP     R3
                POP     R2
                POP     R1
                RETN    1


; ColPassaro: Coloca o passaro na posicao inicial
;#######################################################################
ColPassaro:     PUSH    R1
                PUSH    R2

                MOV     R2, M[LC_ATUAL_PASS]
                MOV     M[IO_POINTER],  R2
                MOV     R1, CAR_PASS1
                MOV     M[IO_WRITE],    R1
                INC     R2
                MOV     M[IO_POINTER],  R2
                DEC     R2
                MOV     R1, CAR_PASS2
                MOV     M[IO_WRITE],    R1

                POP     R2
                POP     R1
                RET

; EscPassaro: Escreve o passaro na nova posição se este mudou de linha
;#######################################################################
EscPassaro:     PUSH    R1
                PUSH    R2
                PUSH    R3

                MOV     R1, R7              ; passaro mudou de linha ?
                ADD     R1, 0080h
                SHR     R1, 8
                SHL     R1, 8
                MOV     R2, M[LC_ATUAL_PASS]
                SHR     R2, 8
                SHL     R2, 8
                CMP     R1, R2
                JMP.Z   EscPassaro_F
                
                MOV     R2, M[LC_ATUAL_PASS]   ; limpa passaro atual
                MOV     M[IO_POINTER], R2
                MOV     R3, CAR_LIMPEZA
                MOV     M[IO_WRITE],   R3
                INC     R2              
                MOV     M[IO_POINTER], R2
                DEC     R2
                MOV     M[IO_WRITE],   R3

                MVBL    R1, POS_INICIAL        ; atualiza linha + coluna
                MOV     M[LC_ATUAL_PASS], R1   ; atual do passaro

                MOV     R2, M[LC_ATUAL_PASS]   ; desenha pass na nova posicao
                MOV     M[IO_POINTER],  R2
                MOV     R1, CAR_PASS1
                MOV     M[IO_WRITE],    R1
                INC     R2
                MOV     M[IO_POINTER],  R2
                DEC     R2
                MOV     R1, CAR_PASS2
                MOV     M[IO_WRITE],    R1

EscPassaro_F:   POP     R3
                POP     R2
                POP     R1
                RET

; NovaPosPass: Calcula a posição do passaro nova num mov. accelerado
;#######################################################################
NovaPosPass:    PUSH    R1
                PUSH    R2

                MOV     R1, M[ACCELERACAO]     ; ACCELERACAO
                MOV     R2, INTERV_TEMPO       ; CONSTANTE TEMPO

                TEST    R1, R1
                BR.NN   NovaPosPass_1
                NEG     R1
NovaPosPass_1:  MUL     R1, R2
                SHL     R1, 8
                ADD     R2, 0080h
                SHR     R2, 8
                MVBH    R2, R1
                MOV     R1, M[ACCELERACAO]
                TEST    R1, R1
                BR.NN   NovaPosPass_2
                NEG     R2
NovaPosPass_2:  ADD     R6, R2              ; nova velocidade do passaro

                MOV     R1, R6              ; VELOCIDADE - R6
                MOV     R2, INTERV_TEMPO    ; CONSTANTE TEMPO

                TEST    R6, R6
                BR.NN   NovaPosPass_3
                NEG     R1
NovaPosPass_3:  MUL     R1, R2
                SHL     R1, 8
                ADD     R2, 0080h
                SHR     R2, 8
                MVBH    R2, R1
                TEST    R6, R6
                BR.NN   NovaPosPass_F
                NEG     R2
NovaPosPass_F:  ADD     R7, R2              ; nova pos passaro

                POP     R2
                POP     R1
                RET


; EscObstaculo: Escreve obstaculo na coluna que recebe pela pilha
;#######################################################################
EscObstaculo:   PUSH    R1
                PUSH    R2
                PUSH    R3
                PUSH    R4
                PUSH    R5
                
                MOV     R1, M[SP+7]         ; nº aleatorio + col onde escrever obst
                MVBH    R4, R1              ; numero aleatorio
                
                ADD     R4, 0400h
                SHR     R4, 8
                SUBB    R4, 0002h           ;R4 - lim inf
                SHL     R4, 8
                MOV     R5, R4
                ADD     R5, 0600h           ;R5 - lim sup

                MOV     R2, 0100h           ;R2 - linha atual
                MVBH    R1, R2

EscObstaculo_1: CMP     R2, R4              ; verificacao do nao preenchimento
                BR.N    EscObstaculo_2      ; do espaço livre aleatorio
                CMP     R2, R5
                BR.P    EscObstaculo_2
                BR      EscObstaculo_3

EscObstaculo_2: MOV     M[IO_POINTER], R1   ; escrita de um carater 'X'
                MOV     R3, CAR_OBST
                MOV     M[IO_WRITE], R3
                
EscObstaculo_3: ADD     R2, 0100h           ; chegamos ao fim?
                MVBH    R1, R2
                CMP     R2, 1700h
                BR.NZ   EscObstaculo_1
                
                POP     R5
                POP     R4
                POP     R3
                POP     R2
                POP     R1
                RETN 1


; LimpaObstac: Limpa obstaculo que recebe pela pilha
;#######################################################################
LimpaObstac:    PUSH    R1
                PUSH    R2
                PUSH    R3
                PUSH    R4
                PUSH    R5
                
                MOV     R1, M[SP+7]         ; nº aleatorio + col onde escrever obst
                MVBH    R4, R1              ; numero aleatorio
                
                ADD     R4, 0400h
                SHR     R4, 8
                SUBB    R4, 0002h           ;R4 - lim inf
                SHL     R4, 8
                MOV     R5, R4
                ADD     R5, 0600h           ;R5 - lim sup

                MOV     R2, 0100h           ;R2 - linha atual
                MVBH    R1, R2

LimpaObstac_1:  CMP     R2, R4              ; verificacao do nao preenchimento
                BR.N    LimpaObstac_2       ; do espaço livre aleatorio
                CMP     R2, R5
                BR.P    LimpaObstac_2
                BR      LimpaObstac_3

LimpaObstac_2:  MOV     M[IO_POINTER], R1   ; escrita de um carater ' '
                MOV     R3, CAR_LIMPEZA
                MOV     M[IO_WRITE], R3
                
LimpaObstac_3:  ADD     R2, 0100h           ; chegamos ao fim?
                MVBH    R1, R2
                CMP     R2, 1700h
                BR.NZ   LimpaObstac_1
                
                POP     R5
                POP     R4
                POP     R3
                POP     R2
                POP     R1
                RETN 1


; MvObstaculos: Move obstaculos para a esquerda
;#######################################################################
MvObstaculos:   PUSH    R1
                PUSH    R2
                PUSH    R3
                PUSH    R4

                MOV     R1, TAB_OBST        ; Obstaculo está vazio?
MvObstaculos_1: MOV     R2, M[R1]
                CMP     R2, R0
                BR.Z    MvObstaculos_4      ; passar ao próximo
                
MvObstaculos_2: PUSH    R2
                CALL    LimpaObstac         ; limpa obstaculo

                MOV     R2, M[R1]           ; verificacao ultima coluna
                SHL     R2, 8               ; impede escrita e limpa memoria
                CMP     R2, R0
                BR.NZ   MvObstaculos_3
                MOV     M[R1], R0
                BR      MvObstaculos_4

MvObstaculos_3: MOV     R2, M[R1]           ; escrita do obstaculo
                SUBB    R2, 0001h           ; 1 pos a frente
                PUSH    R2
                CALL    EscObstaculo
                MOV     M[R1], R2

MvObstaculos_4: INC R1
                CMP R1, FIM_TAB_OBS
                BR.NZ   MvObstaculos_1

                POP     R4
                POP     R3
                POP     R2
                POP     R1
                RET


; NovoObstaculo: Cria novo obstaculo
;#######################################################################
NovoObstaculo:  PUSH    R1
                PUSH    R2
                PUSH    R3

                PUSH    R0
                CALL    NumAleatorio
                POP     R1                  ; obtem num aleatorio
                CMP     R1, R0
                BR.NZ   NovoObstaculo_1
                INC     R1
NovoObstaculo_1:SHL     R1, 8
                MOV     R2, 004Eh
                MVBH    R2, R1              ; obtem posicao de escrita
                PUSH    R2                  ; + num aleatorio
                CALL    EscObstaculo        ; escreve obstaculo

                MOV     R1, TAB_OBST
NovoObstaculo_2:CMP     M[R1], R0           ; procurar posição de memoria livre
                BR.Z    NovoObstaculo_3
                INC     R1
                CMP     R1, FIM_TAB_OBS     ; chegamos ao fim da tabela de osbt?
                BR.NZ   NovoObstaculo_2
                BR      NovoObstaculo_F
NovoObstaculo_3:MOV     M[R1], R2           ; escrever posiçao atual do obst.
NovoObstaculo_F:POP     R3
                POP     R2
                POP     R1
                RET


; VerColisoes: Verifica se o passaro colidiu com um obstaculo
;#######################################################################
VerColisoes:    PUSH    R1
                PUSH    R2
                PUSH    R3
                PUSH    R4
                PUSH    R5

                MOV     R1, TAB_OBST

VerColisoes_1:  MOV     R2, M[R1]
                MVBH    R2, R0
                CMP     R2, 0014h           ; é necessario verificar
                JMP.N   VerColisoes_5       ; colisões?
                CMP     R2, 0015h
                JMP.P   VerColisoes_5

                MOV     R2, M[R1]
                MOV     R4, R2
                MVBL    R4, R0
                SHR     R4, 8
                ADD     R4, 0004h
                SUBB    R4, 0002h           ;R4 - lim inf
                MOV     R5, R4
                ADD     R5, 0006h           ;R5 - lim sup

                MOV     R3, R7              ; obter linha atual do pássaro
                ADD     R3, 0008h           ; arredondada
                SHR     R3, 8                

                CMP     R3, R4
                BR.N    VerColisoes_2
                CMP     R3, R5
                BR.P    VerColisoes_2
                BR      VerColisoes_5

VerColisoes_2:  MOV     R3, 0001h
                MOV     M[SP+7], R3

VerColisoes_5:  INC     R1                  ; próximo obstaculo
                CMP     R1, FIM_TAB_OBS     ; chegamos ao fim?
                JMP.NZ  VerColisoes_1
VerColisoes_F:  POP     R5
                POP     R4
                POP     R3
                POP     R2
                POP     R1
                RET


; VerColisoesLm: Verifica se o passaro colidiu com os limites
;#######################################################################
VerColisoesLm:  PUSH    R1
                
                MOV     R1, R7              ; R1 - linha da pos atual do pass
                ADD     R1, 0080h           ; por arredondamento
                SHR     R1, 8
                CMP     R1, R0
                BR.NP   VerColisoesLm_1     ; pos menor ou igual lim?
                CMP     R1, 0017h
                BR.NN   VerColisoesLm_1     ; pos maior ou igual lim?
                BR      VerColisoesLm_F
VerColisoesLm_1:INC     M[SP+3]
VerColisoesLm_F:POP     R1
                RET


; ObsSuperados: Verifica se o obstaculo passou a coluna do passaro
;#######################################################################
ObsSuperados:   PUSH    R1
                PUSH    R2

                MOV     R1, TAB_OBST        ; percorre a tabela de obst.
ObsSuperados_1: MOV     R2, M[R1]           ; 
                MVBH    R2, R0
                CMP     R2, 0015h           ; obst. na coluna do pass?
                BR.Z    ObsSuperados_2      ; sair e incrementar var
                INC     R1
                CMP     R1, FIM_TAB_OBS     ; chegamos ao fim dos obst.?
                BR.NZ   ObsSuperados_1
                BR      ObsSuperados_F      ; sair sem incrementar var

ObsSuperados_2: INC     M[OBS_PERCORRIDOS]  ; mais um obst. percorrido
ObsSuperados_F: POP     R2
                POP     R1
                RET


; ObsDisplay: Atualiza o display 7 segmentos com os obst. superados
;#######################################################################
ObsDisplay:     PUSH    R1
                PUSH    R2

                MOV R2, M[OBS_PERCORRIDOS]  
                MOV R1, 10                  ; Tira o algarismo mais a direita do numero de objetos ultrapassados 
                DIV R2, R1                  ; ( Fica no resto da divisao do numero por 10 )
                MOV M[IO_DISPLAY_1], R1     ; E mete-o no primeiro numero da direita do D7S
                MOV R1, 10                  ; Utiliza o mesmo metodo para ir buscar cada algarismo e mete-o
                DIV R2, R1                  ; na posição do D7S correspondente
                MOV M[IO_DISPLAY_2], R1
                MOV R1, 10
                DIV R2, R1
                MOV M[IO_DISPLAY_3], R1
                MOV M[IO_DISPLAY_4], R2

                POP     R2
                POP     R1
                RET


; ResetJogo: Faz o reset das variaveis e do ambiente de jogo
;#######################################################################
ResetJogo:      PUSH    R1

                MOV     M[ESTADO_TEMPOR],   R0
                MOV     M[CONTADOR_TEMPOR], R0
                MOV     M[ESTADO_JOGO],     R0
                MOV     M[JOGO_PAUSA],      R0
                MOV     M[DIST_PERCORRIDA], R0
                MOV     M[OBS_PERCORRIDOS], R0
                MOV     R1, C000h
                MOV     M[NIVEIS_JOGO],     R1
                MOV     R1, 0B14h
                MOV     M[LC_ATUAL_PASS],   R1
                MOV     R1, 0008h
                MOV     M[NIVEL_JOGO],      R1
                MOV     R1, 09CCh
                MOV     M[ACCELERACAO],     R1
                MOV     R1, F780h
                MOV     M[VELOC_SALTO],     R1
                CALL    LimpaMemoria        
                CALL    LimpaLCD
                CALL    IniciaLCD
                CALL    AtualizaLCD
                CALL    AtualizaLEDs
                CALL    ObsDisplay
                MOV     R6, R0              ;VELOCIDADE INICIAL 0
                MOV     R7, 0B00h           ;POS INICIAL PASSARO
                POP     R1
                RET


; AtualizaLEDs: Atualiza os LEDs dos niveis de jogo
;#######################################################################
AtualizaLEDs:   PUSH    R1
                
                MOV     R1, M[NIVEIS_JOGO]
                MOV     M[IO_LEDS], R1

                POP     R1
                RET


; Jogo: Inicio da rotina principal do programa

Jogo:           MOV     R1, MASC_INT        ;inicializacao da
                MOV     M[END_MASC_INT], R1 ;mascara de interrupcoes

                MOV     R1, END_PILHA       ;inicializacao da pilha
                MOV     SP, R1              ;
                
                MOV     R1, FFFFh           ;inicializacao do porto
                MOV     M[IO_POINTER], R1   ;de controlo de escrita
                MOV     R1, R0
                
                CALL    ResetJogo           ; Inicializaçao de variaveis
                                            ; de ambiente do jogo
               
                ENI
                CALL    EscMsgInicial       ; escreve a mensagem inicial
Jogo_1:         MOV     R1, M[ESTADO_JOGO]  ; espera pela interrupcao
                CMP     R1, R0
                BR.Z    Jogo_1
                
                CALL    LimpaEcra           ; limpa o ecra
                PUSH    R0
                CALL    EscreveLim          ; |escreve limites
                PUSH    LIMITE_INF          ; |
                CALL    EscreveLim          ; |
                CALL    ColPassaro          ; coloca o passaro
                
                CALL    AtivaTempor

                CALL    NovoObstaculo       ; cria primeiro obstaculo
                MOV     R2, INTERV_OBST     ; var intervalo entre obst.
                

JogoLoop:       CALL    PausaJogo                ; Verifica se o jogo esta em pausa
                MOV     R1, M[NIVEL_JOGO]        ; atualiza a var nivel de jogo
                CMP     M[CONTADOR_TEMPOR], R1   ; intervalo de interrupçoes do temp
                BR.N    JogoLoop_1
                
                CALL    MvObstaculos             ; move os obstaculos

                PUSH    R0
                CALL    VerColisoes              ; verifica colisoes com obstaculos
                POP     R3
                CMP     R3, 0001h
                JMP.Z   FimJogo
                
                MOV     M[CONTADOR_TEMPOR], R0   ; nº de interr. do temporizador volta a 0
                
                INC     M[DIST_PERCORRIDA]       ; incrementa a distancia percorrida
                CALL    AtualizaLCD              ; e atualiza o LCD
                CALL    ObsSuperados             ; verifica se passamos um obst.
                CALL    ObsDisplay               ; atualiza Display 7 Segm.

                DEC     R2                       ; decrementa var interv. obst.
                CMP     R2, R0                   ; criar novo obstaculo?
                BR.NZ   JogoLoop_1
                CALL    NovoObstaculo            ; criar novo obstaculo
                MOV     R2, INTERV_OBST          ; reinicia var interv. obst.

JogoLoop_1:     CMP     M[ESTADO_TEMPOR], R0    ; * ROTINA INTERRUPCAO TEMPORIZADOR
                JMP.Z   JogoLoop
                ENI
                
                INC     M[CONTADOR_TEMPOR]      ; Incrementa contador do temporizador
                CALL    NovaPosPass             ; calcula nova pos. do passaro
                
                PUSH    R0                      ; Verifica a colisao do passaro
                CALL    VerColisoesLm           ; com os limites de jogo
                POP     R3 
                CMP     R3, 0001h
                JMP.Z   FimJogo

                CALL    EscPassaro              ; escreve o passaro nova pos se necessario

                PUSH    R0                      ; verifica colisoes com obstaculos
                CALL    VerColisoes
                POP     R3
                CMP     R3, 0001h
                JMP.Z   FimJogo

                MOV     M[ESTADO_TEMPOR], R0    ; * FIM ROTINA INT. TEMPORIZADOR
                CALL    AtivaTempor
                JMP     JogoLoop


; FimJogo: Rotina de fim de jogo

FimJogo:        CALL    LimpaEcra               ; limpa o ecra do espaço de jogo
                CALL    EscMsgFinal             ; escreve mensagem final com pontuacao
                MOV     M[ESTADO_JOGO], R0      ; atualiza estado do jogo
                
                MOV     R1, 0001h
FimJogo_1:      CMP     M[ESTADO_JOGO], R1      ; espera pela interrupcao
                BR.NZ   FimJogo_1
                CALL    LimpaEcra
                CALL    ResetJogo               ; reinicia as vars de jogo
                CALL    EscMsgInicial           ; escreve mensagem inicial
                JMP     Jogo_1
