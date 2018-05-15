; Compiled from Delphi source code

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

MoveModel:

var_4		= -4
arg_0		=  8

		push	ebp
		mov	ebp, esp
		push	ecx
		push	ebx
		push	esi
		push	edi
		mov	ebx, [ebp+arg_0]
		lea	eax, [ebx+48h]
		mov	edi, [eax]
		push	ebp
		lea	eax, [ebx+44h]
		mov	edx, [eax]
		mov	eax, edi
		call	sub_3056BC4
		pop	ecx
		push	ebp
		lea	eax, [ebx+70h]
		mov	edx, 3
		call	sub_3056BC4
		pop	ecx
		push	ebp
		lea	eax, [ebx+0ACh]
		mov	edx, 1
		call	sub_3056BC4
		pop	ecx
		lea	eax, [ebx+54h]
		mov	eax, [eax]
		mov	[ebp+var_4], eax
		add	ebx, 4Ch
		mov	eax, [ebx]
		dec	eax
		test	eax, eax
		jl	short loc_3056E0B
		inc	eax
		mov	ebx, eax
		xor	esi, esi

loc_3056DF5:				; CODE XREF: MoveModel+69j
		push	ebp
		imul	eax, esi, 134h
		add	eax, [ebp+var_4]
		mov	edx, edi
		call	sub_3056BFC
		pop	ecx
		inc	esi
		dec	ebx
		jnz	short loc_3056DF5

loc_3056E0B:				; CODE XREF: MoveModel+4Ej
		pop	edi
		pop	esi
		pop	ebx
		pop	ecx
		pop	ebp
		retn	14h

; ---------------------------------------------------------------------------
		align 10h
; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_3056BC4:
					; MoveModel+26p ...

arg_0		=  8

		push	ebp
		mov	ebp, esp
		push	ebx
		push	esi
		mov	ebx, edx
		dec	ebx
		test	ebx, ebx
		jl	short loc_3056BF7
		inc	ebx
		xor	edx, edx

loc_3056BD3:				; CODE XREF: sub_3056BC4+31j
		mov	esi, [ebp+arg_0]
		mov	esi, [esi+0Ch]
		lea	ecx, [edx+edx*2]
		add	[eax+ecx*4], esi
		mov	esi, [ebp+arg_0]
		mov	esi, [esi+10h]
		add	[eax+ecx*4+4], esi
		mov	esi, [ebp+arg_0]
		mov	esi, [esi+14h]
		add	[eax+ecx*4+8], esi
		inc	edx
		dec	ebx
		jnz	short loc_3056BD3

loc_3056BF7:				; CODE XREF: sub_3056BC4+Aj
		pop	esi
		pop	ebx
		pop	ebp
		retn

; ---------------------------------------------------------------------------
		align 10h

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_3056BFC:

var_1C		= -1Ch
var_18		= -18h
var_14		= -14h
var_10		= -10h
var_C		= -0Ch
var_6		= -6
var_4		= -4
arg_0		=  8

		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFE4h
		push	ebx
		push	esi
		push	edi
		mov	[ebp+var_4], eax
		mov	ebx, [ebp+var_4]
		mov	eax, [ebp+arg_0]
		movzx	eax, word ptr [eax+0Ch]
		add	[ebx+116h], ax
		mov	eax, [ebp+arg_0]
		movzx	eax, word ptr [eax+10h]
		add	[ebx+11Ah], ax
		mov	eax, [ebp+arg_0]
		movzx	eax, word ptr [eax+14h]
		add	[ebx+11Eh], ax
		mov	eax, [ebp+arg_0]
		movzx	eax, word ptr [eax+0Ch]
		add	[ebx+118h], ax
		mov	eax, [ebp+arg_0]
		movzx	eax, word ptr [eax+10h]
		add	[ebx+11Ch], ax
		mov	eax, [ebp+arg_0]
		movzx	eax, word ptr [eax+14h]
		add	[ebx+120h], ax
		movsx	eax, word ptr [ebx+20h]
		lea	eax, [eax+eax*2]
		lea	eax, [edx+eax*4]
		mov	esi, [eax]
		mov	edx, [eax+4]
		mov	[ebp+var_C], edx
		mov	eax, [eax+8]
		mov	[ebp+var_10], eax
		mov	edi, [ebx]
		imul	edi, esi
		mov	eax, [ebx+4]
		imul dword [ebp+var_C]
		add	edi, eax
		mov	eax, [ebx+8]
		imul dword [ebp+var_10]
		add	edi, eax
		neg	edi
		mov	[ebx+0Ch], edi
		cmp	dword ptr [ebx+8], 0
		jz	short loc_3056CB6
		mov	eax, [ebx+8]
		cdq
		push	edx
		push	eax
		push	0
		push	10000h
		mov	eax, edi
		neg	eax
		cdq
		call	unknown_libname_65 ; BDS 2005-2007 and Delphi6-7 Visual	Component Library
		call	System_lldiv ; System::__linkproc__ _lldiv(void)
		mov	[ebx+18h], eax

loc_3056CB6:				; CODE XREF: sub_3056BFC+99j
		mov	eax, [ebp+arg_0]
		add	esi, [eax+18h]
		mov	eax, [ebp+arg_0]
		mov	eax, [eax+18h]
		add	[ebp+var_C], eax
		mov	eax, [ebp+arg_0]
		mov	eax, [eax+18h]
		add	[ebp+var_10], eax
		mov	ecx, [ebx+8]
		test	ecx, ecx
		jnz	short loc_3056CF4
		mov	ecx, [ebx+4]
		neg	ecx
		imul	ecx, esi
		mov	eax, [ebx]
		imul dword	[ebp+var_C]
		add	ecx, eax
		shr	ecx, 10h
		movzx	eax, word ptr [ebp+var_10]
		neg	ax
		mov	[ebp+var_6], ax
		jmp	short loc_3056D4C
; ---------------------------------------------------------------------------

loc_3056CF4:				; CODE XREF: sub_3056BFC+D7j
		mov	eax, ecx
		cdq
		xor	eax, edx
		sub	eax, edx
		cmp	eax, 0E6CAh
		jl	short loc_3056D11
		mov	ecx, esi
		movzx	eax, word ptr [ebp+var_C]
		neg	ax
		mov	[ebp+var_6], ax
		jmp	short loc_3056D4C
; ---------------------------------------------------------------------------

loc_3056D11:				; CODE XREF: sub_3056BFC+104j
		mov	eax, [ebx+4]
		neg	eax
		mov	[ebp+var_1C], eax
		mov	eax, [ebx]
		mov	[ebp+var_18], eax
		xor	eax, eax
		mov	[ebp+var_14], eax
		lea	ecx, [ebp+var_1C] ; _DWORD
		call absolute %GetU%
		mov	ecx, [ebp+var_1C]
		imul	ecx, esi
		mov	eax, [ebp+var_18]
		imul dword	[ebp+var_C]
		add	ecx, eax
		shr	ecx, 10h
		movzx	eax, word ptr [ebp+var_10]
		neg	ax
		mov	[ebp+var_6], ax

loc_3056D4C:				; CODE XREF: sub_3056BFC+F6j
					; sub_3056BFC+113j
		sub	cx, [ebx+48h]
		movzx	eax, word ptr [ebx+70h]
		sub	[ebp+var_6], ax
		sub	[ebx+112h], cx
		movzx	eax, word [ebp+var_6]
		sub	[ebx+114h], ax
		movsx	eax, byte ptr [ebx+12Eh]
		cmp	eax, 13h
		jle	short loc_3056D7B
		mov	eax, 13h

loc_3056D7B:				; CODE XREF: sub_3056BFC+178j
		mov	edx, eax
		test	edx, edx
		jl	short loc_3056D96
		inc	edx
		xor	eax, eax

loc_3056D84:				; CODE XREF: sub_3056BFC+198j
		add	[ebx+eax*2+48h], cx
		movzx	esi, word [ebp+var_6]
		add	[ebx+eax*2+70h], si
		inc	eax
		dec	edx
		jnz	short loc_3056D84

loc_3056D96:				; CODE XREF: sub_3056BFC+183j
		pop	edi
		pop	esi
		pop	ebx
		mov	esp, ebp
		pop	ebp
		retn

; ---------------------------------------------------------------------------

align 10h

; =============== S U B	R O U T	I N E =======================================

; BDS 2005-2007	and Delphi6-7 Visual Component Library
; Attributes: library function

unknown_libname_65:

var_8		= -8
var_4		= -4
arg_0		=  4
arg_4		=  8

		push	edx
		push	eax
		mov	eax, [esp+8+arg_4]
		mul	dword [esp+8+var_8]
		mov	ecx, eax
		mov	eax, [esp+8+var_4]
		mul	dword [esp+8+arg_0]
		add	ecx, eax
		mov	eax, [esp+8+var_8]
		mul	dword [esp+8+arg_0]
		add	edx, ecx
		pop	ecx
		pop	ecx
		retn	8

; ---------------------------------------------------------------------------

align 10h

; =============== S U B	R O U T	I N E =======================================

; Attributes: library function

; __fastcall System::__linkproc__ _lldiv(void)
System_lldiv:

var_18		= -18h
var_14		= -14h
var_10		= -10h
arg_0		=  4
arg_4		=  8

		push	ebx
		push	esi
		push	edi
		mov	ebx, [esp+0Ch+arg_0]
		mov	ecx, [esp+0Ch+arg_4]
		mov	esi, edx
		mov	edi, ecx
		sar	esi, 1Fh
		xor	eax, esi
		xor	edx, esi
		sub	eax, esi
		sbb	edx, esi
		sar	edi, 1Fh
		xor	esi, edi
		xor	ebx, edi
		xor	ecx, edi
		sub	ebx, edi
		sbb	ecx, edi
		jnz	short loc_3005764
		cmp	edx, ebx
		jb	short loc_300575E
		mov	ecx, eax
		mov	eax, edx
		xor	edx, edx
		div	ebx
		xchg	eax, ecx

loc_300575E:				; CODE XREF: System::__linkproc__ _lldiv(void)+2Bj
		div	ebx
		mov	edx, ecx
		jmp	short loc_30057AB
; ---------------------------------------------------------------------------

loc_3005764:				; CODE XREF: System::__linkproc__ _lldiv(void)+27j
		sub	esp, 0Ch
		mov	[esp+18h+var_18], eax
		mov	[esp+18h+var_14], ebx
		mov	[esp+18h+var_10], edx
		mov	edi, ecx
		shr	edx, 1
		rcr	eax, 1
		ror	edi, 1
		rcr	ebx, 1
		bsr	ecx, ecx
		shrd	ebx, edi, cl
		shrd	eax, edx, cl
		shr	edx, cl
		rol	edi, 1
		div	ebx
		mov	ebx, [esp+18h+var_18]
		mov	ecx, eax
		imul	edi, eax
		mul	dword [esp+18h+var_14]
		add	edx, edi
		sub	ebx, eax
		mov	eax, ecx
		mov	ecx, [esp+18h+var_10]
		sbb	ecx, edx
		sbb	eax, 0
		xor	edx, edx
		add	esp, 0Ch

loc_30057AB:				; CODE XREF: System::__linkproc__ _lldiv(void)+3Aj
		xor	eax, esi
		xor	edx, esi
		sub	eax, esi
		sbb	edx, esi
		pop	edi
		pop	esi
		pop	ebx
		retn	8

