private ["_toDelete"];

[[petros,"hint","Deleting Garbage. Please wait"],"commsMP"] call BIS_fnc_MP;

_toDelete = nearestObjects [markerPos "base_4", ["WeaponHolderSimulated", "GroundWeaponHolder", "WeaponHolder"], 16000] ;
for "_i" from 0 to ((count _toDelete) - 1) do
{
	if !((_toDelete select _i) distance _posHQ < 100) then 
	{
		deleteVehicle (_toDelete select _i);
	}
};

{deleteVehicle _x} forEach allDead;

[[petros,"hint","Garbage deleted"],"commsMP"] call BIS_fnc_MP;