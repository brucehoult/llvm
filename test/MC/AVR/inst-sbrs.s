; RUN: llvm-mc -triple avr-none -show-encoding < %s | FileCheck %s


foo:

  sbrs r2, 3
  sbrs r0, 7

; CHECK: sbrs r2, 3                  ; encoding: [0x23,0xfc]
; CHECK: sbrs r0, 7                  ; encoding: [0x07,0xfe]

