.data
b: .space 12        # Space for 3 integers (3 x 4 bytes)
space: .asciiz " "
newline: .asciiz "\n"

.text
.globl main

main:
    add s0, x0, x0       # i = 0
    addi s1, x0, 7       # a = 7
    la s2, b             # s2 = base address of b
    addi t0, x0, 3       # loop limit (3 iterations)

loop:
    bge s0, t0, print   # if i >= 3, go to printing

    mul t1, s0, s1           # t1 = i * a
    add t1, t1, s1           # t1 = a + (i * a)

    slli t2, s0, 2           # t2 = i * 4
    add t3, s2, t2           # t3 = &b[i]
    sw t1, 0(t3)             # store result at b[i]

    addi s0, s0, 1           # i++
    j loop

print:
    li s0, 0                 # reset i = 0

print_values:
    bge s0, t0, end          # if i >= 3, end

    slli t2, s0, 2           # t2 = i * 4
    add t3, s2, t2           # t3 = &b[i]
    lw a1, 0(t3)             # load b[i] into a1
    li a0, 1                 # syscall: print integer
    ecall

    # print space after number
    la a1, space
    li a0, 4                 # syscall: print string
    ecall

    addi s0, s0, 1
    j print_values

end:
    la a1, newline
    li a0, 4                 # syscall: print newline
    ecall

    li a0, 10                # syscall: exit
    ecall
