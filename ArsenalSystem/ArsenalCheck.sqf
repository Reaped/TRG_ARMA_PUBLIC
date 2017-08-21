arsenallist = getItemCargo caja;

arsenalcounter = count (arsenallist select 0);

overtwenty = [];

cargoquantity = arsenallist select 1;
{
        if ((cargoquantity select _x) >= 3) then 
        { 
                overtwenty pushBackUnique _x;
        }; 
} forEach cargoquantity;

itemnames = [];

{
        itemnames pushBackUnique ((arsenallist select 0) select _x); 
} forEach overtwenty;

{
         [Caja,_x,true] call BIS_fnc_addVirtualItemCargo;
        [[[_x], ["ist nun im Arsenal"], ["verfügbar", "<t align = 'center' shadow = '1' size = '0.7' font='puristaMedium'>%1</t>", 70] ] , 1, 0.75, "<t align = 'center' shadow = '1' size = '1.0'>%1</t>" ] spawn BIS_fnc_typeText;
} forEach itemnames;