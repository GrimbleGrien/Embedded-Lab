; Experiment 2 Part B

MOV P1, #0000H ; Initialize P1 : ALL LED OFF

; set-reset P1.[0:3] 1s delay
LOOP:
    MOV P1, #0001H ; Set P1.0
    ACALL DELAY     ; Call delay function
    MOV P1, #0000H ; Reset P1.0

    MOV P1, #0002H ; Set P1.1
    ACALL DELAY     ; Call delay function
    MOV P1, #0000H ; Reset P1.1

    MOV P1, #0004H ; Set P1.2
    ACALL DELAY     ; Call delay function
    MOV P1, #0000H ; Reset P1.2

    MOV P1, #0008H ; Set P1.3
    ACALL DELAY     ; Call delay function
    MOV P1, #0000H ; Reset P1.3

    SJMP LOOP ; Jump back to LOOP for continuous execution

; ----- 1 SECOND DELAY (do finetune iters)

DELAY:
    MOV R5, #44 ; Load R5 with a value for outer loop
H3:
    MOV R4, #248 ; Load R4 with a value for middle loop
H2:
    MOV R3, #255 ; Load R3 with a value for inner loop
H1:
    DJNZ R3, H1 ; Decrement R3, repeat inner loop until R3 is zero
    DJNZ R4, H2 ; Decrement R4, repeat middle loop until R4 is zero
    DJNZ R5, H3 ; Decrement R5, repeat outer loop until R5 is zero
    RET         ; Return from the delay function

END ; End of the program
