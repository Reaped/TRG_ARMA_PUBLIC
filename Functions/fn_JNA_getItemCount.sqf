/*
     Description:
        Get the Count of an Item in the Database

    Parameters:
        0: ARRAY - Items to be Found in the Database

     Returns:
        ARRAY - Array of Arrays of Names and Quantitys of items

     Example:
        [unlockedWeapons] call AS_JNA_getItemCount;
        ["U_BG_Guerilla2_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3"] call AS_JNA_getItemCount;
*/

params [["_array",[],[[]]]];
private ["_className","_category","_index","_returnArray"];

if (count _array > 0) then {
    { 
        if (typeName _x != "STRING") exitWith {_wrongDataType = true};
    } forEach _array;
} else {
    exitWith {diag_log "Error in JNA_setupGear: empty input array"};
};

{ 
    _className = _x;
    category = _className call AS_fnc_JNA_classifyItem;
    _index = missionNamespace getVariable [format ["jna_index_%1",category],-1];
    
    for[{private _i=0},{_i < (count (jna_dataList select index))},{_i =_i +1}] do 
        { 
		if ((((jna_dataList select _index) select _i) select 0) isEqualto _className) then {
		_returnArray pushback [_Classname,(((jna_dataList select _index) select _i) select 1)];
		};
        };
} forEach _array; 


_returnArray;