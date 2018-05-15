__HooksList MM8_HooksList[] =
{
	{0x44378C, (long)_MM8_ProcessEventStart, HKT_CALL, 5, &ProcessEventStartStd}, // EVT_ProcessEvent is called
	{0x445768, (long)_MM8_ProcessEventReturn01, HKT_LONG}, // EVT_ProcessEvent finds a 01 command. Its Seq (line number) is used as return value now.
	{0x445752, (long)_MM8_ProcessEventReturnOther, HKT_JMP, 7}, // EVT_ProcessEvent returns due to other reason
	{0x443787, (long)_ProcessCanShowTopic, HKT_JMP}, // EVT_CanShowDialogItem return
	{0x4DC906, (long)_Start, HKT_CALL, 0, &StartStd}, // Start of mm8.exe
	{0x440E03, (long)_OnLoadMap, HKT_JMP, 6}, // OnLoadMap
	{0x440D22, 0, HKT_NOP, 0x440D2E - 0x440D22}, // Don't skip important stuff if there's no map evt
	{0x440D64, (long)_MM8_OnLoadMapNoEvt, HKT_CALL, 6}, // If there's no map evt
	{0x441633, (long)_MM8_OnGetEventHint, HKT_CALL, 6}, // Hints for doors etc.
	//{, (long)_MM7_OnGetMazeInfo, HKT_CALL, 6}, // Right click on minimap
	{0x4618DE, (long)_MM78_MainLoopEnd, HKT_CALL, 0, &MM78_MainLoopEndStd}, // LeaveGame to Main Manu
	{0x45C9B6, (long)_MM8_LoadGame, HKT_CALL}, // Load game opened game file, about to lead header.bin
	{0x45D2E1, (long)_MM8_SaveGame, HKT_CALL}, // Save game, about to write npcdata.bin
	{0x440DBF, (long)_MM8_LeaveMap, HKT_JMP, 6}, // LeaveMap
	{0x4613EF, (long)_OnTimer, HKT_CALL, 5, (long*)&OnTimerStd}, // called on every tick
	{0x45E058, (long)_MM8_BeforeLoadMap, HKT_JMP, 9}, // loading level lod
	{0x401ADA, 0, HKT_BYTE}, // Allow Armageddon effect indoors (just earthquake and damage part)
	{0x438B05, (long)CalcSpellDamage, HKT_JMP, 5}, // Spell damage
	{(long)&CalcSpellDamageStd, (long)MM8_CalcSpellDamageStd, HKT_DWORD}, // Spell damage std
	{0x4889A8, (long)TravelWalk, HKT_JMP, 6}, // TravelWalkingChooseMap
	{(long)&TravelWalkStd, (long)MM8_TravelWalkStd, HKT_DWORD}, // TravelWalkingChooseMap std
	{0x488E54, (long)_MM8_SetFogRange, HKT_CALL},
	{0x45E3B6, (long)_NewGameMap, HKT_CALL, 0, &NewGameMapStd}, // Choose starting map for a new game
	{0x461747, (long)MM78_DeathMap, HKT_CALL}, // Choose map after death
	{0x460D27, (long)Initialize1, HKT_CALL, 0, (long*)&Initialize1Std}, // Initialized (loaded .bin data)
	{0x460E12, (long)Initialize2, HKT_CALL, 0, (long*)&Initialize2Std}, // Initialized (loaded .txt data)
	{0x48DA2B, (long)MM8_SPStatKinds, HKT_DWORD}, // Choose class spell points stat
	{0x48DA9D, (long)"98 DA 48 00  36 DA 48 00  3F DA 48 00", HKT_PATCH}, // Choose class spell points stat
	{0x48DAA9, (long)&_MM8_SPStatIP, HKT_DWORD}, // Choose class spell points stat (add Intellect+Personality)
	{0}
};