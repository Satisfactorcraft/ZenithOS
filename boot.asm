ORG 0x7C00  
BITS 16  

start:
    mov si, message  
    call print_text  

    call wait_for_key  ; Warten auf eine Tasteneingabe  
    mov ah, 0x0E       ; BIOS-Interrupt für Zeichen-Ausgabe  
    int 0x10           ; Zeichen ausgeben  

    cli  
    hlt  

; Funktion: Zeichenkette ausgeben  
print_text:
    mov ah, 0x0E  
.loop:
    lodsb  
    cmp al, 0  
    je .done  
    int 0x10  
    jmp .loop  
.done:
    ret  

; Funktion: Tastatureingabe holen  
wait_for_key:
    mov ah, 0x00  
    int 0x16      ; Warten auf eine Taste  
    ret  

message db "Drücke eine Taste: ", 0  

times 510 - ($-$$) db 0  
dw 0xAA55  
