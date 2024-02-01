ORG 8100H  ; Origin address of the program

MOV DPTR, #9000H  ; Initialize DPTR with the starting address of the array
MOV R1, #100  ; Set the loop counter for entering values

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Enter values in descending order
loop: 
    MOV A, R1  ; Load the current value
    MOVX @DPTR, A  ; Store the value in external memory
    INC DPTR  ; Move to the next memory location
    DJNZ R1, loop  ; Decrement counter and repeat until all values are entered

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Sorting in ascending order
MOV R1, #100  ; Reset the outer loop counter

outer_loop: 
    MOV DPTR, #9000H  ; Reset the pointer to the start of the array
    MOV R2, #99  ; Set the inner loop counter

inner_loop:
    MOVX A, @DPTR  ; Load current element
    MOV R3, A  ; Store current element in R3
    MOV B, R3  ; Copy current element to B

    INC DPTR  ; Move to the next element
    MOVX A, @DPTR  ; Load next element
    MOV R4, A  ; Store next element in R4

    CJNE A, B, comp  ; Compare current and next elements

    LJMP deduct  ; Jump to deduct if elements are equal

comp: 
    JC swapp  ; Jump to swapp if carry is set (current element > next element)
    LJMP deduct  ; Jump to deduct if carry is not set (current element < next element)

swapp:
    MOV A, R3  ; Swap elements
    MOVX @DPTR, A

    DEC DPL  ; Move DPTR back to the previous memory location
    MOV A, R4
    MOVX @DPTR, A
    INC DPTR  ; Move to the next element

deduct: 
    DJNZ R2, inner_loop  ; Decrement inner loop counter and repeat if not zero
    DJNZ R1, outer_loop  ; Decrement outer loop counter and repeat if not zero

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Binary search
MOV DPTR, #9500H  ; Load the address of the value to be searched
MOVX A, @DPTR  ; Load the value to be searched
MOV R7, A  ; R7 stores the value to be searched

MOV DPTR, #9000H  ; Reset the pointer to the start of the array
MOV R1, #0  ; Set the start index
MOV R2, #99  ; Set the end index

bloop: 
    MOV A, R1  ; Calculate mid index
    ADD A, R2
    MOV B, #2
    DIV AB
    MOV R3, A
    ADD A, DPL
    MOV DPL, A

    MOVX A, @DPTR  ; Load middle element
    MOV B, R7
    CJNE A, B, func  ; Compare with the value to be searched

    MOV DPTR, #9550H  ; Store the index if value is found
    MOV A, R3
    MOVX @DPTR, A
    LJMP endd  ; Jump to end of the program

func: 
    JC func1  ; Jump to func1 if carry is set (current element > value)
    LJMP func2  ; Jump to func2 if carry is not set (current element < value)

func1:
    MOV A, R3  ; Adjust start index
    ADD A, #1
    MOV R1, A
    LJMP repeat

func2:
    MOV A, R3  ; Adjust end index
    SUBB A, #1
    MOV R2, A
    LJMP repeat

repeat:
    MOV A, R1  ; Repeat the binary search
    MOV B, R2
    CJNE A, B, check
    LJMP intial

check: 
    JC intial  ; Jump to intial if carry is set (start index > end index)
    
    MOV A, #0
    SUBB A, #1  ; Store -1 if value is not found
    MOV DPTR, #9550H
    MOVX @DPTR, A
    LJMP endd

intial:
    MOV DPTR, #9000H  ; Reset the pointer to the start of the array
    LJMP bloop

endd:
    RET  ; End of the program
END
