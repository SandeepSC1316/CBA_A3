#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

// Get button
_button = _this select 0;
// Get dialog
_display = uiNamespace getVariable "RscDisplayConfigure";

// Get listnbox
_lnb = _display displayCtrl 202;
// Get currently selected index
_lnbIndex = lnbCurSelRow _lnb;

// Get handler tracker index for key stored in listbox
_handlerIndex = parseNumber (_lnb lnbData [_lnbIndex, 0]);

// Get entry from handler tracker array
_handlerTracker = GVAR(handlers);
_keyConfig = _handlerTracker select _handlerIndex;

// Something must be selected.
if (!isNil "_keyConfig") then {
	_modName = _keyConfig select 0;
	_actionName = _keyConfig select 1;
	_oldKeyData = _keyConfig select 2;
	_functionName = _keyConfig select 3;

	// Blank the keybind.
	_keybind = [-1, false, false, false];

	// Re-register the handler with default keybind.
	[_modName, _actionName, _functionName, _keybind, true] call cba_fnc_registerKeybind;

	// Clear any input actions.
	GVAR(waitingForInput) = false;

	// Update the main dialog.
	[] call FUNC(updateGUI);
};