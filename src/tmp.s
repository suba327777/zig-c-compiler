.text
.globl _main
_main:
    mov x0, #5          // x0 に 5 を代入
    add x0, x0, #20     // x0 に 20 を加算
    sub x0, x0, #4      // x0 から 4 を減算
    mov w0, w0          // 戻り値を設定
    ret                 // 戻る


