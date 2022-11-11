library MMExtension;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  Windows;

//{$R *.res}
{$R MMExtension.res}

var
  Buffer: array[0..260] of Char;
  s: string;
  i: integer;
begin
  i:= GetModuleFileName(HInstance, Buffer, SizeOf(Buffer));
  repeat
    dec(i);
  until (i < 0) or (Buffer[i] in ['/', '\']);
  SetString(s, Buffer, i + 1);
  LoadLibrary(PChar(s + 'MMExtension\lua51.dll'));
  LoadLibrary(PChar(s + 'MMExtension\MMExtCore.dll'));
end.
