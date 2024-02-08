			ORG 8100H ; Start of the program

			MOV DPTR, #9000H ; Point to the beginning of the truth table
			MOV R1, #8 ; Initialize R1 for looping through input combinations
			MOV R2, #0B;
			MOV R6, #1B;
			MOV B, 2;

INITDPTR:
			MOV A, R2; INITIALIZING 0 IN EVEN ADDRESS
			MOVX @DPTR, A;
			INC DPTR;
			MOV A, R6; INITIALIZING 1 IN ODD ADDRESS
			MOVX @DPTR, A;
			INC DPTR;
			DJNZ R1, INITDPTR; Continue the loop until all combinations are displayed
			
START:
			MOV R1, #0;

MODE_SELECT:
			MOV P1, #0FFH;
			MOV A, P1; Read the status of the LDR (assuming connected to P1.6)
			MOV P1, #0H
			CJNE A, #0FFH, INITIALIZE;

BLINK_MODE:
			MOV P1, #2FH ; Turn on all five LEDs in blink mode
			ACALL DELAY ; Introduce a delay for visibility
			MOV P1, #00H ; Turn off all LEDs in blink mode
			ACALL DELAY ; Introduce a delay for visibility
			MOV R1, #0H;
			JMP MODE_SELECT ; Jump back to normal mode
	
			

INITIALIZE:
			MOV R2, #5;
			MOV DPTR, #9000H ; Point to the beginning of the truth table
			;MOV P1, R1 ; Display the current input combination on LEDs

			MOV A, R1 ; Load the current input combination to A
			ADD A, DPL ; 
			MOV DPL, A; Increment to that location
			MOVX A, @DPTR; Load the corresponding truth value from the table
			
MULTIPLY:
			MUL AB;
			MOV B, #2;
			DJNZ R2, MULTIPLY;
			
			ADD A, R1;
			MOV P1, A; Display the output on an additional LED (assuming P1.5 for output)

			ACALL DELAY ; Introduce a delay for visibility
	
			INC R1 ; Move to the next input combination
			JMP MODE_SELECT;
			CJNE R1, #16, INITIALIZE ; Continue the loop until all combinations are displayed
			
			JMP START;





;----- DELAY FUNCTION -----
DELAY:
    MOV R5, #7 ; Outer loop counter
L3:
    MOV R4, #255 ; Middle loop counter
L2:
    MOV R3, #255 ; Inner loop counter
L1:
    DJNZ R3, L1 ; Decrement inner loop counter
    DJNZ R4, L2 ; Decrement middle loop counter
    DJNZ R5, L3 ; Decrement outer loop counter
    RET ; Return from the delay function

END