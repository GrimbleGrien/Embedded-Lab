ORG 8100H  ; Origin address of the program

; Load polynomial parameters
MOV DPTR, #9500H  ; Load the address of the polynomial parameters

; Load n value (degree of the polynomial)
MOV A, #3
MOVX @DPTR, A  ; n value loaded

INC DPTR  ; Move to the next memory location

; Load x value
MOV A, #2
MOVX @DPTR, A  ; x value loaded

INC DPTR  ; Move to the next memory location

; Load coefficient values
MOV A, #5
MOVX @DPTR, A

INC DPTR
MOV A, #4
MOVX @DPTR, A

INC DPTR
MOV A, #3
MOVX @DPTR, A

INC DPTR
MOV A, #4
MOVX @DPTR, A

; Polynomial calculation
MOV DPTR, #9500H  ; Reset the pointer to the start of the polynomial parameters

MOVX A, @DPTR  ; Load n value
MOV R0, A

INC DPTR  ; Move to the next memory location

MOVX A, @DPTR  ; Load x value
MOV R1, A

MOV R2, #1  ; Initialize R2 for accumulating the polynomial result

INC DPTR  ; Move to the next memory location

; Initialize R3 with the constant term of the polynomial
MOVX A, @DPTR
MOV R3, A

looop: 
    MOV A, R2
    MOV B, R1

    MUL AB  ; Multiply R2 and R1, result in A and B
    MOV R2, A

    INC DPTR  ; Move to the next coefficient
    MOVX A, @DPTR

    MOV B, R2
    MUL AB  ; Multiply result with the next coefficient

    ADD A, R3  ; Add to the accumulated result in R3
    MOV R3, A

    DJNZ R0, looop  ; Decrement n value and repeat if not zero

    MOV A, R3  ; Result in A
    MOV DPTR, #9550H  ; Store the result at location 9550H
    MOVX @DPTR, A

func:
    MOV R0, #2  ; Repeat the calculation twice (for demonstration purposes)
    DJNZ R0, func  ; Decrement and repeat if not zero

END  ; End of the program
