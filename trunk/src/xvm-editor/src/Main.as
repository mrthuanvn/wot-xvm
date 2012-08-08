﻿import flash.events.Event;

import mx.core.UIComponent;
import mx.events.MenuEvent;

import utils.Config;
import utils.DefaultConfig;
import utils.Defines;
import utils.JSON;

public function debug(str:String):void
{
	preview.taDebug.text += str + "\n";
}

protected function createNewConfig():void
{
	lastFileName = "XVM.xvmconf";
	Config.s_config = DefaultConfig.config;
	Config.TuneupConfig();
    RefreshCurrentPage();
}

protected function onLoadConfigClick():void
{
	LoadConfig();
}

protected function onSaveConfigClick():void
{
	Config.s_config.editorVersion = Defines.EDITOR_VERSION;
	SaveConfig();
}

protected function mergeConfigs():void
{
    
}

protected function onExtraButtonClick(event:MenuEvent):void
{
    switch (event.item.value)
    {
        case "merge":
            mergeConfigs();
            break;
        case "newconfig":
            createNewConfig();
            break;
    }
}

protected function onVehicleStateChanged(event:Event):void
{
    if (vsMarkers == null)
        return;

    vsMarkers.enabled = (ally.selected || enemy.selected) &&
		(alive.selected || dead.selected) &&
		(normal.selected || extended.selected);

    RefreshCurrentPage();
}

// find all selected marker states
private function getActiveMarkerStates():Array
{
	var res:Array = [];
	if (ally.selected && alive.selected && normal.selected)
		res.push("ally.alive.normal");
	if (ally.selected && alive.selected && extended.selected)
		res.push("ally.alive.extended");
	if (ally.selected && dead.selected && normal.selected)
		res.push("ally.dead.normal");
	if (ally.selected && dead.selected && extended.selected)
		res.push("ally.dead.extended");
	if (enemy.selected && alive.selected && normal.selected)
		res.push("enemy.alive.normal");
	if (enemy.selected && alive.selected && extended.selected)
		res.push("enemy.alive.extended");
	if (enemy.selected && dead.selected && normal.selected)
		res.push("enemy.dead.normal");
	if (enemy.selected && dead.selected && extended.selected)
		res.push("enemy.dead.extended");
	return res;
}

private function getActiveMarkerElement():Object
{
	return elements.selectedItem;
}
