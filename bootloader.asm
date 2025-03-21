ORG 0x7C00    ; Der Bootloader wird bei Adresse 0x7C00 im Speicher geladen
BITS 16       ; 16-Bit-Modus (Real Mode)

start:
    ; Zeige eine Nachricht: "Lade Kernel, bitte warten..."
    mov si, message
    call print_text

    ; Setze die Adresse des Kernels auf 0x1000
    mov ax, 0x1000  ; Kernel-Startadresse
    mov ds, ax      ; Segment-Register DS auf 0x1000 setzen

    ; Warte 3 Sekunden, um zu sehen, ob die Nachricht vollständig angezeigt wird
    ; (Warte-Funktion hinzufügen)
    ;call wait_for_key

    ; Springe direkt zum Kernel, der nach dem Bootloader geladen wird
    jmp 0x1000

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

; Funktion, die auf eine Tasteneingabe wartet
wait_for_key:
    mov ah, 0x00
    int 0x16        ; BIOS-Interrupt, der auf eine Tasteneingabe wartet
    ret

message db "Lade Kernel, bitte warten...", 0   ; Nachricht

times 510 - ($-$$) db 0   ; Fülle das restliche Platz im Bootsektor mit Nullen
dw 0xAA55                 ; Bootsektor-Signatur (wichtig für das BIOS)
