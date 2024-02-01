ORG 8100H  ; Origin address of the program

MOV R2, #0  ; Initialize R2 to 0

repeat:
    MOV A, R2  ; Load the value of R2 into A
    MOV R3, A  ; Copy the value of R2 to R3
    MOV R4, #0  ; Initialize R4 to 0

aend:
    MOV DPTR, #9200H  ; Set DPTR to the address of the second array

    ; Check the value at the address formed by adding R3 and DPL
    MOV A, R3
    ADD A, DPL
    MOV DPL, A  ; Update DPL with the new address
    MOVX A, @DPTR  ; Load the value from the second array

    CJNE A, #30H, bend  ; If the value is not 30H, jump to bend

    MOV DPTR, #9000H  ; Set DPTR to the address of the first array

    ; Check the value at the address formed by adding R4 and DPL
    MOV A, R4
    ADD A, DPL
    MOV DPL, A  ; Update DPL with the new address
    MOVX A, @DPTR  ; Load the value from the first array

    CJNE A, #30H, endd  ; If the value is not 30H, jump to endd

    MOV DPTR, #9500H  ; Set DPTR to the storage location

    ; Store the value of R2 in the storage location
    MOV A, R2
    MOVX @DPTR, A
    LJMP fini  ; Jump to fini

bend: 
    MOV DPTR, #9000H  ; Set DPTR to the address of the first array

    ; Check the value at the address formed by adding R4 and DPL
    MOV A, R4
    ADD A, DPL
    MOV DPL, A  ; Update DPL with the new address
    MOVX A, @DPTR  ; Load the value from the first array

    CJNE A, #30H, equalc  ; If the value is not 30H, jump to equalc

    MOV DPTR, #9500H  ; Set DPTR to the storage location

    ; Store the value of R2 in the storage location
    MOV A, R2
    MOVX @DPTR, A
    LJMP fini  ; Jump to fini

equalc: 
    MOV DPTR, #9200H  ; Set DPTR to the address of the second array

    ; Check the value at the address formed by adding R3 and DPL
    MOV A, R3
    ADD A, DPL
    MOV DPL, A  ; Update DPL with the new address
    MOVX A, @DPTR
    MOV B, A  ; Copy the value to B

    MOV DPTR, #9000H  ; Set DPTR to the address of the first array

    ; Check the value at the address formed by adding R4 and DPL
    MOV A, R4
    ADD A, DPL
    MOV DPL, A  ; Update DPL with the new address
    MOVX A, @DPTR
    CJNE A, B, update  ; If values are not equal, jump to update

    ; Increment R3 and R4
    MOV A, R3
    ADD A, #1
    MOV R3, A

    MOV A, R4
    ADD A, #1
    MOV R4, A

    LJMP aend  ; Jump to aend

update:
    MOV A, R2  ; Increment R2
    ADD A, #1
    MOV R2, A
    LJMP repeat  ; Jump to repeat

endd: 
    MOV A, #0
    SUBB A, #1
    MOV DPTR, #9500H

    ; Store -1 in the storage location
    MOVX @DPTR, A
    LJMP fini  ; Jump to fini

fini: 
    MOV R2, #2  ; Repeat the loop twice
    DJNZ R2, fini  ; Decrement and repeat if not zero

END  ; End of the program
