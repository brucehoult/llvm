; RUN: llc < %s -mtriple=x86_64-linux-pc -mcpu=corei7 | FileCheck %s

declare <4 x i32> @llvm.x86.sse41.pminud(<4 x i32>, <4 x i32>)

define <2 x i16> @good(<4 x i32>*, <4 x i8>*) {
; CHECK-LABEL: good:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    movdqa (%rdi), %xmm0
; CHECK-NEXT:    pminud {{.*}}(%rip), %xmm0
; CHECK-NEXT:    pmovzxwq %xmm0, %xmm0
; CHECK-NEXT:    retq
entry:
  %2 = load <4 x i32>, <4 x i32>* %0, align 16
  %3 = call <4 x i32> @llvm.x86.sse41.pminud(<4 x i32> %2, <4 x i32> <i32 127, i32 127, i32 127, i32 127>)
  %4 = extractelement <4 x i32> %3, i32 0
  %5 = extractelement <4 x i32> %3, i32 1
  %6 = extractelement <4 x i32> %3, i32 2
  %7 = extractelement <4 x i32> %3, i32 3
  %8 = bitcast i32 %4 to <2 x i16>
  %9 = bitcast i32 %5 to <2 x i16>
  ret <2 x i16> %8
}

define <2 x i16> @bad(<4 x i32>*, <4 x i8>*) {
; CHECK-LABEL: bad:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    movdqa (%rdi), %xmm0
; CHECK-NEXT:    pminud {{.*}}(%rip), %xmm0
; CHECK-NEXT:    pextrd $1, %xmm0, %eax
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    pmovzxwq %xmm0, %xmm0
; CHECK-NEXT:    retq
entry:
  %2 = load <4 x i32>, <4 x i32>* %0, align 16
  %3 = call <4 x i32> @llvm.x86.sse41.pminud(<4 x i32> %2, <4 x i32> <i32 127, i32 127, i32 127, i32 127>)
  %4 = extractelement <4 x i32> %3, i32 0
  %5 = extractelement <4 x i32> %3, i32 1
  %6 = extractelement <4 x i32> %3, i32 2
  %7 = extractelement <4 x i32> %3, i32 3
  %8 = bitcast i32 %4 to <2 x i16>
  %9 = bitcast i32 %5 to <2 x i16>
  ret <2 x i16> %9
}
