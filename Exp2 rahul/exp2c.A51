ORG 0H ; Start of the program

MOV DPTR, #9000H ; Point to the beginning of the truth table
MOV R1, #0 ; Initialize R1 for looping through input combinations

INITIALIZE:
    MOV P1, R1 ; Display the current input combination on LEDs

    MOV A, R1 ; Load the current input combination to A
    MOVX A, @DPTR ; Load the corresponding truth value from the table
    MOV P2.7, A ; Display the output on an additional LED (assuming P2.7 for output)

    ACALL DELAY ; Introduce a delay for visibility

    INC R1 ; Move to the next input combination
    CJNE R1, #16, INITIALIZE ; Continue the loop until all combinations are displayed

    SJMP $ ; Infinite loop to keep the program running

;----- DELAY FUNCTION -----
DELAY:
    MOV R5, #50 ; Outer loop counter
H3:
    MOV R4, #20 ; Middle loop counter
H2:
    MOV R3, #255 ; Inner loop counter
H1:
    DJNZ R3, H1 ; Decrement inner loop counter
    DJNZ R4, H2 ; Decrement middle loop counter
    DJNZ R5, H3 ; Decrement outer loop counter
    RET ; Return from the delay function
