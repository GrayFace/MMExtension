__HooksList MM7_HooksList[] =
{
	{0x44686D, (long)_MM7_ProcessEventStart, HKT_CALL, 6, &ProcessEventStartStd}, // EVT_ProcessEvent is called
	{0x44844B, (long)_MM7_ProcessEventReturn01, HKT_LONG}, // EVT_ProcessEvent finds a 01 command. Its Seq (line number) is used as return value now.
	{0x448442, (long)_MM7_ProcessEventReturnOther, HKT_JMP, 6}, // EVT_ProcessEvent returns due to other reason
	{0x446868, (long)_ProcessCanShowTopic, HKT_JMP}, // EVT_CanShowDialogItem return
	{0x462D8E, (long)_Start, HKT_CALL, 0, &StartStd}, // Start of mm7.exe
	{0x443FFF, (long)_OnLoadMap, HKT_JMP, 6}, // OnLoadMap
	{0x443F1E, 0, HKT_NOP, 0x443F2A - 0x443F1E}, // Don't skip important stuff if there's no map evt
	{0x443F60, (long)_MM7_OnLoadMapNoEvt, HKT_CALL}, // If there's no map evt
	{0x444758, (long)_MM7_OnGetEventHint, HKT_CALL, 6}, // Hints for doors etc.
	//{0x444569, (long)_MM7_OnGetMazeInfo, HKT_CALL, 6}, // Right click on minimap
	{0x463818, (long)_MM78_MainLoopEnd, HKT_JMP, 0, &MM78_MainLoopEndStd}, // LeaveGame to Main Manu
	{0x45F02D, (long)_MM7_LoadGame, HKT_CALL}, // Load game opened game file, about to lead header.bin
	{0x45F906, (long)_MM7_SaveGame, HKT_CALL}, // Save game, about to write npcdata.bin
	{0x443FBB, (long)_MM7_LeaveMap, HKT_JMP, 6}, // LeaveMap
	{0x46340F, (long)_OnTimer, HKT_CALL, 5, (long*)&OnTimerStd}, // called on every tick
	{0x460745, (long)_MM7_BeforeLoadMap, HKT_JMP, 9}, // loading level lod
	{0x401AB9, 0, HKT_BYTE}, // Allow Armageddon effect indoors (just earthquake and damage part)
	{0x43B006, (long)CalcSpellDamage, HKT_JMP, 6}, // Spell damage
	{(long)&CalcSpellDamageStd, (long)MM7_CalcSpellDamageStd, HKT_DWORD}, // Spell damage std
	{0x489014, (long)TravelWalk, HKT_JMP, 6}, // TravelWalkingChooseMap
	{(long)&TravelWalkStd, (long)MM7_TravelWalkStd, HKT_DWORD}, // TravelWalkingChooseMap std
	{0x489551, (long)_MM7_SetFogRange, HKT_CALL},
	{0x460A9C, (long)_NewGameMap, HKT_CALL, 0, &NewGameMapStd}, // Choose starting map for a new game
	{0x4636D3, (long)MM78_DeathMap, HKT_CALL}, // Choose map after death
	{0x462DB6, (long)Initialize1, HKT_CALL, 0, (long*)&Initialize1Std}, // Initialized (loaded .bin data)
	{0x462E7B, (long)Initialize2, HKT_CALL, 0, (long*)&Initialize2Std}, // Initialized (loaded .txt data)
	{0x48E56B, (long)"90 90 90", HKT_PATCH}, // Choose class spell points stat
	{0x48E570, 35, HKT_BYTE}, // Choose class spell points stat
	{0x48E57A, (long)MM7_SPStatKinds, HKT_DWORD}, // Choose class spell points stat
	{0x48E61F, (long)"15 E6 48 00  85 E5 48 00  8E E5 48 00  A1 E5 48 00", HKT_PATCH}, // Choose class spell points stat

	//{0x4638FF, (long)_EndPaint, HKT_CALL, 6}, // 
	//{0x4638A5, (long)_MM7_Validate, HKT_JMP, 6},
	//{0x49FBC7, (long)_LoopFlush, HKT_CALL, 6},
	{0}
};