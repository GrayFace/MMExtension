#pragma once

extern char TextBuffer[];

void RegisterFunctionCalls();

int __stdcall MM6_CallProcessEvent(int evtId, int seq, int vTargetMember, int param);
int __stdcall MM7_CallProcessEvent(int evtId, int seq, int vTargetMember, int param);
int __stdcall MM8_CallProcessEvent(int evtId, int seq, int vTargetMember, int param);

extern byte ReenterEvtBuf[];
extern byte* ReenterEvtLines;
extern int ReenterEvtLinesCount;
