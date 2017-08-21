ws_fnc_newGridArray = compile preprocessFileLineNumbers "warStatistics\fn_newGridArray.sqf";
ws_fnc_plotGrid = compile preprocessFileLineNumbers "warStatistics\fn_plotGrid.sqf";
ws_fnc_unplotGrid = compile preprocessFileLineNumbers "warStatistics\fn_unplotGrid.sqf";
ws_fnc_markersToGridArray = compile preprocessFileLineNumbers "warStatistics\fn_markersToGridArray.sqf";
ws_fnc_getRandomPosOnRoad = compile preprocessFileLineNumbers "warStatistics\fn_getRandomPosOnRoad.sqf";
ws_fnc_addGrid = compile preprocessFileLineNumbers "warStatistics\fn_addGrid.sqf";
ws_fnc_subGrid = compile preprocessFileLineNumbers "warStatistics\fn_subGrid.sqf";

//Get value
ws_fnc_getValue = compile preprocessFileLineNumbers "warStatistics\fn_getValue.sqf";
ws_fnc_getValueID = compile preprocessFileLineNumbers "warStatistics\fn_getValueID.sqf";
ws_fnc_getSmoothValueID = compile preprocessFileLineNumbers "warStatistics\fn_getSmoothValueID.sqf";
ws_fnc_getEdgeValueID = compile preprocessFileLineNumbers "warStatistics\fn_getEdgeValueID.sqf";
ws_fnc_getZeroCrossingValueID = compile preprocessFileLineNumbers "warStatistics\fn_getZeroCrossingValueID.sqf";

//Set value
ws_fnc_setValue = compile preprocessFileLineNumbers "warStatistics\fn_setValue.sqf";
ws_fnc_setValueID = compile preprocessFileLineNumbers "warStatistics\fn_setValueID.sqf";

//Change value
ws_fnc_addValue = compile preprocessFileLineNumbers "warStatistics\fn_addValue.sqf";
ws_fnc_addValueID = compile preprocessFileLineNumbers "warStatistics\fn_addValueID.sqf";

//Filtering functions
ws_fnc_filterEdge = compile preprocessFileLineNumbers "warStatistics\fn_filterEdge.sqf";
ws_fnc_filterSmooth = compile preprocessFileLineNumbers "warStatistics\fn_filterSmooth.sqf";
ws_fnc_filterZeroCrossing = compile preprocessFileLineNumbers "warStatistics\fn_filterZeroCrossing.sqf";