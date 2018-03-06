
.cpu cortex-m4
.thumb

.word 0x20020000
.word _start

.align 12, 0

.thumb_func
.global _start
_start:
    /* Enable GPIOB clock (bit 1 at 0x4002104c) */
    ldr r1, =0x4002104c
    ldr r0, [r1]
    mov r2, #0x2
    orr r0, r0, r2
    str r0, [r1]

    /* Wait for 2 cycles */
    and r0, r0, r0
    and r0, r0, r0

    /* Set GPIO PB14 mode to digital out (bit 28, 29 = 01 at 0x48000418) */
    ldr r1, =0x48000400
    ldr r0, [r1]
    mov r2, #0x3
    lsl r2, #28
    bic r0, r0, r2
    mov r2, #0x01
    lsl r2, #28
    orr r0, r0, r2
    str r0, [r1]


    /* Set GPIO PB14 (bit 14 at 0x48000418) */
    ldr r1, =0x48000418
    mov r0, #1
    lsl r0, r0, #14
    str r0, [r1]

    mov r3, #1
    lsl r3, r3, #30
    mov r4, #1
    lsl r4, r4, #14
    orr r3, r3, r4

toggle_loop:
    /* Loop for some time*/
    ldr r2, =0x10000
busy_loop:
    sub r2, r2, #1
    cmp r2, #0
    bge busy_loop

    /* Toggle GPIO PB14 */
    eor r0, r0, r3
    str r0, [r1]

    b toggle_loop
