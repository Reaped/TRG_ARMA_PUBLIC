ts1 = 0;
ts2 = 0;
[] spawn {
	while{true}do{
		ts1= ts1 +1;
	};
};

ts2 = 2;




_veh = _this select 0;
_vehType = typeof cursorObject;
_cfg = (configfile >> "CfgVehicles" >> _vehType >> "HitPoints");
_type = "";

if(count _cfg == 0)then{
	_type =  "static";
	_array = [["HULL",0]];
}else{

	if( isClass (_cfg >> "HitLBWheel"))then{
		_type =  "car";
		_array = [["HULL",0],["ENG",0],["FUEL",0],["WHS",0]];
	}else{
		if( isClass (_cfg >> "HitHRotor"))then{
			_array = [["HULL",0],["ENG",0],["INST",0],["ATRQ",0],["MROT",0]];
		}else{
			if( isClass (_cfg >> "HitLAileron"))then{
				_type =  "plane";
				_array = [["HULL",0],["ENG",0],["FUEL",0],["CTRL",0],["INST",0],["GEAR",0]];
			}else{

				if( isClass (_cfg >> "HitRTrack"))then{
					_type =  "tank";
					_array = [["HULL",0],["ENG",0],["GUN",0],["L-TR",0],["R-TR",0],["TRRT",0]];
				}else{
					_type =  "ship";
					_array = [["ENG",0]];
				};
			};
		};
	};
};





this addAction [
	localize "str_act_gameOptions", {
		hint format ["Arma 3 - Antistasi\n\nVersion: %1",antistasiVersion];
		nul=CreateDialog "game_options_commander";
	},nil,0,false,true,"","(isPlayer _this) and (_this == Slowhand) and (_this == _this getVariable ['owner',objNull])"
];

this addAction [
	localize "str_act_gameOptions", {
		hint format ["Arma 3 - Antistasi\n\nVersion: %1",antistasiVersion];
		nul=CreateDialog "game_options_player";
	},nil,0,false,true,"","(isPlayer _this) and !(_this == Slowhand) and (_this == _this getVariable ['owner',objNull])"
];
this addAction [localize "str_act_mapInfo", {nul = [] execVM "cityinfo.sqf";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
this addAction [localize "str_act_tfar", {nul=CreateDialog "tfar_menu";},nil,0,false,true,"","(isClass (configFile >> ""CfgPatches"" >> ""task_force_radio""))", 5];
this addAction [localize "str_act_moveAsset", "moveObject.sqf",nil,0,false,true,"","(_this == Slowhand)", 5];


[] spawn {
	_car = vehicle player;
	_dir = direction _car;
	_pos = {position _car};
	sleep 0.1;
	_nr = 0;
	_testList = [];
	_p1 = objNull;
	_q = "M_Titan_AT"  createVehicle (position _car vectoradd [(vectordir _car select 0) * 4,(vectordir _car select 1) * 4, 20]);
	_test = objNull;

	[_q,_testList] spawn {
		_q = _this select 0;
		_testList = _this select 1;
		while {! (isNull _q)}do{

			{
				_s = velocity _x vectorMultiply -0.9;
				_s = _s vectoradd [0,0,100];
				_x addforce [_s,[0,0,0]];
			} forEach _testList;
			_q setVelocity (velocity _q vectorMultiply (100/(speed _q+1)));
			sleep 0.1;
		};

		{
			_t = "SatchelCharge_Remote_Ammo" createVehicle position _x;
			_t setDamage 1;
			deleteVehicle _x;
		} forEach _testList;
	};

	while {_nr <= 11}do{
		_nr = _nr + 1;
		_p2 = "B_UAV_01_F" createVehicle (position _car vectoradd [(vectordir _car select 0) * 4,(vectordir _car select 1) * 4,_nr/3]);
		_p2 allowDamage false;
		if(isNull _test)then{

			_test = _p2;

			_test attachTo [_q ,[0,-0.5,0]];



		}else{
			ropeCreate [_p1, [0,0,0], _p2, [0,0,0], 20];
			sleep 0.7;
		};

		_y = _dir;_p = 0; _r = 0;
		switch _nr do
		{
			case 1: {;_p = 90;};
			case 2: {;_p = 80;};
			case 3: {;_p = 70;};
			case 4: {;_p = 60;};
			case 5: {;_p = 50;};
			case 6: {;_p = 45;};
			case 7: {;_p = 45;};
			case 8: {;_p = 20;};
			case 9: {;_p = 10;};
			case 10: {;_p = 0;};
			case 11: {;_p = -10;};
			default {_y = _dir;_p = -45;};
		};
		_q setVectorDirAndUp [
			[ sin _y * cos _p,cos _y * cos _p,sin _p],
			[ [ sin _r,-sin _p,cos _r * cos _p],-_y] call BIS_fnc_rotateVector2D
		];

		_p1 = _p2;
		_testList pushBack _p2;

	};

};


//SHOOT PLANES
vehicle player removeAllEventHandlers "Fired";

vehicle player addEventHandler ["Fired", {
	_this select 6 spawn{
		sleep 0.01;
		_p = "I_C_Plane_Civil_01_F" createVehicle [0,0,0];
		_p setPosWorld (getPosWorld _this);
		_p setVectorDirAndUp [vectorDir _this, vectorup _this];
		_p setVelocity (velocity _this);
		[_p] spawn{
			sleep 10;
			deleteVehicle (_this select 0);
		};
	};

}]


player allowDamage false;
vehicle player removeAllEventHandlers "Fired";
vehicle player addEventHandler ["Fired", {
	_this select 6 spawn{
		_p = player;
		_p setPosWorld (getPosWorld _this);
		_p setVectorDirAndUp [vectorDir _this, vectorup _this];
		_p setVelocity (velocity _this);
	};

}]



//max rotation on turret
[] spawn {
	while{vehicle player != player}do{
		sleep 0.1;
		_turret = vehicle player;
		_rot = _turret animationSourcePhase "MainGun";
		diag_log ["MainGun", _rot];
		if(_rot > 0.3)then{
			_turret animateSource ["MainGun",0.3,1];
		};
		if(_rot < -0.3)then{
			_turret animateSource ["MainGun",-0.3,1];
		};
	};
};

//hold onto car
removeAllActions player;
player addAction ["Hold On", {
	private _nearestVehicle = objNull;
	private _nearestDistance = 3;
	{
		_distance = _x distance player;
		diag_log  ["dis",_distance];
		if(_distance < _nearestDistance && !(_x isEqualTo player)) then
		{
			diag_log  ["type",typeof _x];
			if(_x call jn_fnc_garage_getVehicleIndex != -1 && _x call jn_fnc_garage_getVehicleIndex != 5) then
			{
				_nearestVehicle = _x;
				_nearestDistance = _distance;
			};
		};
	} forEach vehicles;

	if(!isnil "_nearestVehicle")then{
		player attachto [_nearestVehicle];
		_index = (findDisplay 46) displayAddEventHandler ["KeyDown", "
			hint str (_this select 1);
			if((_this select 1) in [17,30,31,32,57])then{
				detach player;
				_index = missionnamespace getVariable 'jn_hold';
				(findDisplay 46) displayRemoveEventHandler ['KeyDown',_index];
			};
		"];
		missionnamespace setVariable ["jn_hold",_index];
	};

}];

//

_base = cursorObject;
_array2 =[getText (configfile >> "CfgVehicles" >> typeOf _base >> "model")];
_array1 = [];
_locBase = getPosWorld  _base;
{
 _type = typeOf _x;
 _offset = (getPosWorld  _x);
 _dir = vectorDir _x;
 _up = vectorUp _x;
 _tex = getObjectTextures _x;
 _array1 pushBack [1, _offset, []];
}foreach (attachedObjects _base);
_array2 pushBack _array1;
copyToClipboard str _array2;

//fus ro da
jn_fnc_forceRagdoll = {
	params ["_target","_player"];
	if!(local _target)exitWith{};

	private _dis = _target distance _player;
	diag_log _dis;
	if(_dis > 2)exitWith{};

	private _loc = (getpos _target) vectordiff (getpos _player);
	_loc = vectorNormalized _loc;
	private _vel = _loc vectorMultiply (50/_dis);
	_vel set [2,20];


	_target allowDamage false;

	private _rag = "Land_Can_V3_F" createVehicleLocal [0,0,0];
    _rag setMass 1e10;
    _rag attachTo [_target, [0,0,0], "Spine3"];
    _rag setVelocity _vel;

    detach _rag;
    [_rag,_target] spawn {
    	params ["_rag","_target"];
        deleteVehicle _rag;
        sleep 4;
        _target allowDamage true;
    };
};

player addAction [
	"Hit Shit",
	{
		[cursorObject,player] remoteExec ["jn_fnc_forceRagdoll",0];
	}, Nil, 0, true, false, "fire", "", 5, false, ""
];

//PVP
//find close enemy
_closedAI = objNull;
_closedDis = 10000;
{
	_ai = _x;
	if (side _ai isEqualTo resistance && {!(player isEqualTo _ai)} )then{
		{
			_dis = _ai distance _x;
			if(_dis < _closedDis)then{
				_closedDis = _dis;
				_closedAI = _ai;
			};
		} forEach (allPlayers - [player]);
	};
}foreach allunits;
selectPlayer _closedAI;
[player, ""] call BIS_fnc_setUnitInsignia;