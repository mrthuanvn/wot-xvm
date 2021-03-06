﻿package utils
{

import com.xvm.*;
	
public class ConfigUtils
{
    /**
     * Recursive walt default config and merge with loaded values.
     */
    /**
     * Recursive walt default config and merge with loaded values.
     */
    public static function MergeConfigs(config:*, def:*, prefix: String = null):*
    {
        if (!prefix)
            prefix = "def";
        
        switch (typeof def)
        {
            case 'object':
                if (def is Array)
                {
                    // warning: arrays are not checked now
                    return (config is Array) ? config : def;
                }
                if (def == null)
                    return (typeof config == 'string' || typeof config == 'number') ? config : null;
                var result: Object = { };
                for (var name:String in def)
                {
                    try
                    {
                        result[name] = config.hasOwnProperty(name)
                            ? MergeConfigs(config[name], def[name], prefix + "." + name)
                            : def[name];
                    }
                    catch (ex:Error)
                    {
                        result[name] = def[name];
                    }
                }
                return result;
                
            case 'number':
                if (!isNaN(parseFloat(config)))
                    return parseFloat(config);
                if (typeof config == 'string')
                    return config;
                return def;
                
            case 'boolean':
                if (typeof config == 'boolean')
                    return config;
                if (typeof config == 'string')
                    return config.toLowerCase() == "true";
                return def;
                
            case 'string':
                return (config == null || typeof config == 'string') ? config : def;
                
            case 'undefined':
            case 'null':
                return (typeof config == 'string' || typeof config == 'number') ? config : def;
                
            default:
                return def;
        }
    }
    

    /**
     * Modify some parameters to be with correct format.
     */
    public static function TuneupConfig():void
    {
        Config.config.battle.clanIconsFolder = Utils.fixPath(Config.config.battle.clanIconsFolder);

        Config.config.iconset.battleLoadingAlly = Utils.fixPath(Config.config.iconset.battleLoadingAlly);
        Config.config.iconset.battleLoadingEnemy = Utils.fixPath(Config.config.iconset.battleLoadingEnemy);
        Config.config.iconset.playersPanelAlly = Utils.fixPath(Config.config.iconset.playersPanelAlly);
        Config.config.iconset.playersPanelEnemy = Utils.fixPath(Config.config.iconset.playersPanelEnemy);
        Config.config.iconset.statisticFormAlly = Utils.fixPath(Config.config.iconset.statisticFormAlly);
        Config.config.iconset.statisticFormEnemy = Utils.fixPath(Config.config.iconset.statisticFormEnemy);
        Config.config.iconset.vehicleMarkerAlly = Utils.fixPath(Config.config.iconset.vehicleMarkerAlly);
        Config.config.iconset.vehicleMarkerEnemy = Utils.fixPath(Config.config.iconset.vehicleMarkerEnemy);

        if (isNaN(Config.config.battleLoading.clanIcon.xr))
            Config.config.battleLoading.clanIcon.xr = Config.config.battleLoading.clanIcon.x;
        if (isNaN(Config.config.battleLoading.clanIcon.yr))
            Config.config.battleLoading.clanIcon.yr = Config.config.battleLoading.clanIcon.y;
        if (isNaN(Config.config.statisticForm.clanIcon.xr))
            Config.config.statisticForm.clanIcon.xr = Config.config.statisticForm.clanIcon.x;
        if (isNaN(Config.config.statisticForm.clanIcon.yr))
            Config.config.statisticForm.clanIcon.yr = Config.config.statisticForm.clanIcon.y;
        if (isNaN(Config.config.playersPanel.clanIcon.xr))
            Config.config.playersPanel.clanIcon.xr = Config.config.playersPanel.clanIcon.x;
        if (isNaN(Config.config.playersPanel.clanIcon.yr))
            Config.config.playersPanel.clanIcon.yr = Config.config.playersPanel.clanIcon.y;
    }

    /**
     * Convert config to new format.
     */
    public static function FixConfig(config:Object):Object
    {
        if (!config)
            return undefined;

        var v: String = config.configVersion;

        if (!v || v == "")
            v = "1.0.0";

        if (v == "1.0.0")
        {
            // Convert XVM 1.0.0 => 1.1.0
            if (config.battle)
            {
                if (config.battle.mirroredVehicleIcons != null)
                    config.battle.mirroredVehicleIcons = Utils.toBool(config.battle.mirroredVehicleIcons, true);
                if (config.battle.showPostmortemTips != null)
                    config.battle.showPostmortemTips = Utils.toBool(config.battle.showPostmortemTips, true);
            }

            if (config.rating)
            {
                if (config.rating.showPlayersStatistics != null)
                    config.rating.showPlayersStatistics = Utils.toBool(config.rating.showPlayersStatistics, false);
                if (config.rating.battleLoading) {
                    if (config.rating.battleLoading.show != null)
                        config.rating.battleLoading.show = Utils.toBool(config.rating.battleLoading.show, true);
                }
                if (config.rating.playersPanel)
                {
                    if (config.rating.playersPanel.show != null)
                        config.rating.playersPanel.show = Utils.toBool(config.rating.playersPanel.show, true);
                }
                if (config.rating.statisticForm)
                {
                    if (config.rating.statisticForm.show != null)
                        config.rating.statisticForm.show = Utils.toBool(config.rating.statisticForm.show, true);
                }
                if (config.rating.colors)
                {
                    config.colors = config.rating.colors;
                    delete config.rating.colors;
                }
            }
            v = "1.1.0";
        }

        if (v == "1.1.0")
        {
            // Convert XVM 1.1.0 => 1.2.0
            if (config.battle)
            {
                if (config.battle.battleLoadingShowClock != null)
                {
                    if (!config.battleLoading)
                        config.battleLoading = { };
                    config.battleLoading.showClock = Utils.toBool(config.battle.battleLoadingShowClock, true);
                    delete config.battle.battleLoadingShowClock;
                }
                if (config.battle.playersPanelAlpha != null)
                {
                    if (!config.playersPanel)
                        config.playersPanel = { };
                    config.playersPanel.alpha = Utils.toInt(config.battle.playersPanelAlpha, 100);
                    delete config.battle.playersPanelAlpha;
                }
                if (config.battle.playersPanelLargeWidth != null)
                {
                    if (!config.playersPanel)
                        config.playersPanel = { };
                    config.playersPanel.large = { };
                    config.playersPanel.large.width = Utils.toInt(config.battle.playersPanelLargeWidth, 170);
                    delete config.battle.playersPanelLargeWidth;
                }
            }

            if (config.rating)
            {
                if (config.rating.battleLoading)
                {
                    if (config.rating.battleLoading.format)
                    {
                        if (!config.battleLoading)
                            config.battleLoading = { };
                        config.battleLoading.formatLeft = config.rating.battleLoading.format;
                        config.battleLoading.formatRight = config.rating.battleLoading.format;
                    }
                    delete config.rating.battleLoading;
                }

                if (config.rating.statisticForm)
                {
                    if (config.rating.statisticForm.format != null)
                    {
                        if (!config.statisticForm)
                            config.statisticForm = { };
                        config.statisticForm.formatLeft = config.rating.statisticForm.format;
                        config.statisticForm.formatRight = config.rating.statisticForm.format;
                    }
                    delete config.rating.statisticForm;
                }

                if (config.rating.playersPanel)
                {
                    if (config.rating.playersPanel.format != null)
                    {
                        if (!config.playersPanel)
                            config.playersPanel = { };
                        if (!config.playersPanel.large)
                            config.playersPanel.large = { };
                        config.playersPanel.large.nickFormatLeft = config.rating.playersPanel.format + " {{nick}}";
                        config.playersPanel.large.nickFormatRight = "{{nick}} " + config.rating.playersPanel.format;
                    }
                    if (config.rating.playersPanel.middleColor)
                    {
                        if (!config.playersPanel)
                            config.playersPanel = { };
                        if (!config.playersPanel.medium)
                            config.playersPanel.medium = { };
                        config.playersPanel.medium.formatLeft = "<font color='" + config.rating.playersPanel.middleColor + "'>{{nick}}</font>";
                        config.playersPanel.medium.formatRight = "<font color='" + config.rating.playersPanel.middleColor + "'>{{nick}}</font>";
                    }
                    delete config.rating.playersPanel;
                }
            }

            v = "1.2.0";
        }

        if (v == "1.2.0")
            v = "1.3.0";

        if (v == "1.3.0")
        {
            if (config.battleLoading)
            {
                if (config.battleLoading.showClock != null)
                {
                    config.battleLoading.clockFormat = config.battleLoading.showClock == true ? "hh:mm:ss" : "";
                    delete config.battleLoading.showClock;
                }
                if (config.battleLoading.formatLeft != null)
                    config.battleLoading.formatLeft = "{{vehicle}}" + (config.battleLoading.formatLeft ? " " + config.battleLoading.formatLeft : "");
                if (config.battleLoading.formatRight != null)
                    config.battleLoading.formatRight = (config.battleLoading.formatRight ? config.battleLoading.formatRight + " " : "") + "{{vehicle}}";
            }
            if (config.statisticForm)
            {
                if (config.statisticForm.formatLeft != null)
                    config.statisticForm.formatLeft = "{{vehicle}} " + (config.statisticForm.formatLeft ? " " + config.statisticForm.formatLeft : "");
                if (config.statisticForm.formatRight != null)
                    config.statisticForm.formatRight = (config.statisticForm.formatRight ? config.statisticForm.formatRight + " " : "") + " {{vehicle}}";
            }
            v = "1.4.0";
        }

        if (v == "1.4.0")
            v = "1.5.0";

        if (v == "1.5.0")
        {
			try
			{
	            if (!config.markers.ally.alive.normal.damageTextPlayer)
	                config.markers.ally.alive.normal.damageTextPlayer = config.markers.ally.alive.normal.damageText;
	            if (!config.markers.ally.alive.normal.damageTextSquadman)
	                config.markers.ally.alive.normal.damageTextSquadman = config.markers.ally.alive.normal.damageText;
	            if (!config.markers.ally.alive.extended.damageTextPlayer)
	                config.markers.ally.alive.extended.damageTextPlayer = config.markers.ally.alive.extended.damageText;
	            if (!config.markers.ally.alive.extended.damageTextSquadman)
	                config.markers.ally.alive.extended.damageTextSquadman = config.markers.ally.alive.extended.damageText;
	            if (!config.markers.ally.dead.normal.damageTextPlayer)
	                config.markers.ally.dead.normal.damageTextPlayer = config.markers.ally.dead.normal.damageText;
	            if (!config.markers.ally.dead.normal.damageTextSquadman)
	                config.markers.ally.dead.normal.damageTextSquadman = config.markers.ally.dead.normal.damageText;
	            if (!config.markers.ally.dead.extended.damageTextPlayer)
	                config.markers.ally.dead.extended.damageTextPlayer = config.markers.ally.dead.extended.damageText;
	            if (!config.markers.ally.dead.extended.damageTextSquadman)
	                config.markers.ally.dead.extended.damageTextSquadman = config.markers.ally.dead.extended.damageText;
	            if (!config.markers.enemy.alive.normal.damageTextPlayer)
	                config.markers.enemy.alive.normal.damageTextPlayer = config.markers.enemy.alive.normal.damageText;
	            if (!config.markers.enemy.alive.normal.damageTextSquadman)
	                config.markers.enemy.alive.normal.damageTextSquadman = config.markers.enemy.alive.normal.damageText;
	            if (!config.markers.enemy.alive.extended.damageTextPlayer)
	                config.markers.enemy.alive.extended.damageTextPlayer = config.markers.enemy.alive.extended.damageText;
	            if (!config.markers.enemy.alive.extended.damageTextSquadman)
	                config.markers.enemy.alive.extended.damageTextSquadman = config.markers.enemy.alive.extended.damageText;
	            if (!config.markers.enemy.dead.normal.damageTextPlayer)
	                config.markers.enemy.dead.normal.damageTextPlayer = config.markers.enemy.dead.normal.damageText;
	            if (!config.markers.enemy.dead.normal.damageTextSquadman)
	                config.markers.enemy.dead.normal.damageTextSquadman = config.markers.enemy.dead.normal.damageText;
	            if (!config.markers.enemy.dead.extended.damageTextPlayer)
	                config.markers.enemy.dead.extended.damageTextPlayer = config.markers.enemy.dead.extended.damageText;
	            if (!config.markers.enemy.dead.extended.damageTextSquadman)
	                config.markers.enemy.dead.extended.damageTextSquadman = config.markers.enemy.dead.extended.damageText;
			}
			catch (ex:Object)
			{
			}

			if (config.battle)
			{
				if (config.battle.clanIconsFolder == "../../../clanicons")
	                config.battle.clanIconsFolder = "clanicons";
			}

			try
			{
	            if (!config.colors.system.ally_alive)
	                config.colors.system.ally_alive = config.colors.system.ally_alive_normal;
	            if (!config.colors.system.ally_dead)
	                config.colors.system.ally_dead = config.colors.system.ally_dead_normal;
	            if (!config.colors.system.ally_blowedup)
	                config.colors.system.ally_blowedup = config.colors.system.ally_blowedup_normal;
	            if (!config.colors.system.squadman_alive)
	                config.colors.system.squadman_alive = config.colors.system.squadman_alive_normal;
	            if (!config.colors.system.squadman_dead)
	                config.colors.system.squadman_dead = config.colors.system.squadman_dead_normal;
	            if (!config.colors.system.squadman_blowedup)
	                config.colors.system.squadman_blowedup = config.colors.system.squadman_blowedup_normal;
	            if (!config.colors.system.teamKiller_alive)
	                config.colors.system.teamKiller_alive = config.colors.system.teamKiller_alive_normal;
	            if (!config.colors.system.teamKiller_dead)
	                config.colors.system.teamKiller_dead = config.colors.system.teamKiller_dead_normal;
	            if (!config.colors.system.teamKiller_blowedup)
	                config.colors.system.teamKiller_blowedup = config.colors.system.teamKiller_blowedup_normal;
	            if (!config.colors.system.enemy_alive)
	                config.colors.system.enemy_alive = config.colors.system.enemy_alive_normal;
	            if (!config.colors.system.enemy_dead)
	                config.colors.system.enemy_dead = config.colors.system.enemy_dead_normal;
	            if (!config.colors.system.enemy_blowedup)
	                config.colors.system.enemy_blowedup = config.colors.system.enemy_blowedup_normal;
			}
			catch (ex:Object)
			{
			}

            v = "4.0.0";
        }

        if (v == "4.0.0")
        {
            var s:Object = config.battleLoading;
            if (s != null)
            {
                if (s.formatLeft != null && s.formatLeftVehicle == null)
                {
                    s.formatLeftVehicle = s.formatLeft;
                    delete s.formatLeft;
                }
                if (s.formatRight != null && s.formatRightVehicle == null)
                {
                    s.formatRightVehicle = s.formatRight;
                    delete s.formatRight;
                }
            }
            s = config.statisticForm;
            if (s != null)
            {
                if (s.formatLeft != null && s.formatLeftVehicle == null)
                {
                    s.formatLeftVehicle = s.formatLeft;
                    delete s.formatLeft;
                }
                if (s.formatRight != null && s.formatRightVehicle == null)
                {
                    s.formatRightVehicle = s.formatRight;
                    delete s.formatRight;
                }
            }
            v = "5.0.0";
        }

        if (v == "5.0.0")
        {
            s = config.statisticForm;
            if (s != null)
            {
                if (s.showChancesExp != null && s.showChancesLive == null)
                    s.showChancesLive = s.showChancesExp;
            }
            v = "5.0.1";
        }

        if (v == "5.0.1")
        {
            s = config.battle;
            var s2:* = config.markers;
            if (s2 != null && s != null)
            {
                if (s2.useStandardMarkers == null && s.useStandardMarkers != null)
                    s2.useStandardMarkers = s.useStandardMarkers;
            }
            s2 = config.playersPanel;
            if (s2 != null && s != null)
            {
                if (s2.removePanelsModeSwitcher == null && s.removePanelsModeSwitcher != null)
                    s2.removePanelsModeSwitcher = s.removePanelsModeSwitcher;
            }
            v = "5.0.2";
        }

        if (v == "5.0.2")
        {
            // TODO replace aligned macros with printf format
            v = "5.1.0";
        }

/*
        if (v == "5.x.x")
        {
            v = "5.y.y";
        }
*/

        config.configVersion = v;
        return config;
    }
}

}
