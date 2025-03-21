ORG 0x1000  ; Der Kernel beginnt bei Adresse 0x1000

start:
    mov si, message   ; Zeiger auf die Nachricht setzen
    call print_text   ; Funktion aufrufen, um die Nachricht auszugeben

    ; Wenn der Kernel fertig ist, stoppe die CPU
    cli            ; Verhindert Interrupts (kritischer Abschnitt)
    hlt            ; Stoppt die CPU (Ende des Programms)

; Funktion zum Ausgeben der Nachricht
print_text:
    mov ah, 0x0E    ; BIOS-Interrupt für Textausgabe
.loop:
    lodsb           ; Lade das nächste Zeichen aus der Nachricht
    cmp al, 0       ; Wenn Null (Ende der Nachricht), beende die Schleife
    je .done
    int 0x10        ; Gib das Zeichen aus
    jmp .loop
.done:
    ret

message db "Kernel läuft!", 0  

times 510 - ($-$$) db 0   ; Füllt den Rest des Speicherplatzes mit Nullen auf
dw 0xAA55                 ; Bootsektor-Signatur (wichtig für das BIOS)
