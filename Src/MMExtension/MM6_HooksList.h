__HooksList MM6_HooksList[] =
{
	{0x43C7C0, (long)_MM6_ProcessEventStart, HKT_CALL, 6, &ProcessEventStartStd}, // EVT_ProcessEvent is called
	{0x43E3C8, (long)_MM6_ProcessEventReturn01, HKT_LONG}, // EVT_ProcessEvent finds a 01 command. Its Seq (line number) is used as return value now.
	{0x43C875, (long)_MM6_ProcessEventReturnOther, HKT_JMP, 6}, // EVT_ProcessEvent returns due to other reason
	{0x43E20A, (long)_MM6_ProcessEventReturnOther, HKT_JMP, 6}, // EVT_ProcessEvent returns due to other reason
	{0x43E2FD, (long)_MM6_ProcessEventReturnOther, HKT_JMP, 6}, // EVT_ProcessEvent returns due to other reason
	{0x43E3C1, (long)_MM6_ProcessEventReturnOther, HKT_JMP, 6}, // EVT_ProcessEvent returns due to other reason
	{0x453484, (long)_Start, HKT_CALL, 0, &StartStd}, // Start of mm6.exe
	{0x456A41, (long)_OnLoadMap, HKT_CALL, 0, (long*)&MM6_OnLoadMapStd}, // OnLoadMap
	{0x4399CD, (long)_MM6_OnLoadMapMiddle, HKT_CALL, 6}, // After parsing map evt
	{0x43994A, (long)_MM6_OnLoadMapNoEvt, HKT_JMP6 + HKT_JZ}, // If there's no map evt
	{0x439F64, (long)_MM6_OnGetEventHint, HKT_CALL, 6}, // Hints for doors etc.
	{0x439F11, (long)_MM6_OnGetMazeInfo, HKT_CALL, 6}, // Right click on minimap
	{0x45430B, (long)_MM6_MainLoopEnd, HKT_JMP}, // End of MainLoop
	{0x44EFA2, (long)_MM6_LoadGame, HKT_CALL}, // Load game opened game file, about to lead header.bin
	{0x44F87A, (long)_MM6_SaveGame, HKT_CALL}, // Save game, about to write npcdata.bin
	{0x42C141, (long)_MM6_LeaveMapWalk, HKT_CALL}, // Cross map border - load map dialog shown, autosave done
	{0x453F03, (long)_MM6_LeaveMapDie, HKT_CALL}, // Die - go to New Sorpigal, before load dialogs (bound to MM6_DeathMap)
	{0x453C1F, (long)_MM6_LeaveMapOther, HKT_CALL}, // Spell, horse or boat
	{0x453B12, (long)_OnTimer, HKT_CALL, 5, (long*)&OnTimerStd}, // called on every tick
	{0x458BD0, (long)_MM6_BeforeLoadMap, HKT_JMP, 6}, // loading level lod
	{0x4017CD, 0, HKT_BYTE}, // Allow Armageddon effect indoors
	//{0x45F8D0, 0x4623D9, HKT_JMP}, // test
	{0x4318C5, (long)MM6_CalcSpellDamage, HKT_CALL, 0, (long*)&MM6_CalcSpellDamageStd}, // Spell damage
	{0x47BCA0, (long)TravelWalk, HKT_JMP, 6}, // TravelWalkingChooseMap
	{(long)&TravelWalkStd, (long)MM6_TravelWalkStd, HKT_DWORD}, // TravelWalkingChooseMap std
	{0x47C3B1, (long)_MM6_SetFogRange, HKT_CALL, 6},
	{0x45894C, (long)_NewGameMap, HKT_CALL, 0, &NewGameMapStd}, // Choose starting map for a new game
	{0x453EF3, (long)MM6_DeathMap, HKT_CALL}, // Choose map after death (bound to _MM6_LeaveMapDie)
	{0x4534B9, (long)Initialize1, HKT_CALL, 0, (long*)&Initialize1Std}, // Initialized (loaded .bin data)
	{0x453588, (long)Initialize2, HKT_CALL, 0, (long*)&Initialize2Std}, // Initialized (loaded .txt data)
	{0x4820A0, (long)"90 90 90", HKT_PATCH}, // Choose class spell points stat
	{0x4820A5, 17, HKT_BYTE}, // Choose class spell points stat
	{0x4820B0, (long)MM6_SPStatKinds, HKT_DWORD}, // Choose class spell points stat
	{0x482554, (long)"32 25 48 00  08 22 48 00  BB 20 48 00  55 23 48 00", HKT_PATCH}, // Choose class spell points stat
	{0}
};