; RUN: llvm-mc -triple avr-none -show-encoding < %s | FileCheck %s


foo:

  xch Z, r13
  xch Z, r0
  xch Z, r31
  xch Z, r3

; CHECK: xch Z, r13                  ; encoding: [0xd4,0x92]
; CHECK: xch Z, r0                   ; encoding: [0x04,0x92]
; CHECK: xch Z, r31                  ; encoding: [0xf4,0x93]
; CHECK: xch Z, r3                   ; encoding: [0x34,0x92]
