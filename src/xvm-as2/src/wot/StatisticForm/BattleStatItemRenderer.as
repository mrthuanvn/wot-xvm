﻿/**
 * ...
 * @author sirmax2
 */
import com.xvm.*;
import net.wargaming.controls.UILoaderAlt;
import wot.StatisticForm.WinChances;

class wot.StatisticForm.BattleStatItemRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.BattleStatItemRenderer;
    private var base:net.wargaming.BattleStatItemRenderer;

    public function BattleStatItemRenderer(wrapper:net.wargaming.BattleStatItemRenderer, base:net.wargaming.BattleStatItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;
        BattleStatItemRendererCtor();
    }

    function updateData()
    {
        return this.updateDataImpl.apply(this, arguments);
    }

    function updateState()
    {
        return this.updateStateImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    static var DEBUG_TIMES = false;

    private static var s_state:Number = 0;
    private static var s_winChances:WinChances = null;

    var m_clanIcon: UILoaderAlt = null;
    var m_iconset: IconLoader = null;
    var m_iconLoaded: Boolean = false;

    public function BattleStatItemRendererCtor()
    {
        Utils.TraceXvmModule("StatisticForm");

        if (s_winChances == null)
            s_winChances = new WinChances();

        wrapper.col3.html = true;
        wrapper.col3._y = 0;
        wrapper.col3._height = wrapper._height;
        wrapper.col3.verticalAlign = "center";
        wrapper.col3.verticalAutoSize = true;

        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Stat.E_STAT_LOADED, wrapper, updateData);

        Config.LoadConfig();
    }

    private function get team(): Number
    {
        return (wrapper.owner._name == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
    }

    function completeLoad()
    {
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        wrapper.col3._width += 100;
        if (team == Defines.TEAM_ALLY)
        {
            wrapper.col3._x -= 100;
            //Logger.addObject(event.target);
        }
        if (!Config.s_config.battle.mirroredVehicleIcons)
        {
            if (team == Defines.TEAM_ENEMY)
            {
                wrapper.iconLoader._xscale = -wrapper.iconLoader._xscale;
                wrapper.iconLoader._x -= 80 - 5; // FIXIT: where I can get image width?
                wrapper.col3._x += 5;
            }
        }
    }

    public function onConfigLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);

        if (s_state <= 0)
        {
            s_state = 1;
            s_winChances.showChances = Config.s_config.statisticForm.showChances;
            s_winChances.showLive = Config.s_config.statisticForm.showChancesLive;
            s_winChances.showBattleTier = Config.s_config.statisticForm.showBattleTier;
            StatLoader.LoadData();
        }

        wrapper.col3.condenseWhite = true;
    }

    // override
    function updateDataImpl()
    {
        //Logger.add("updateData()");
        if (!wrapper.data)
        {
            base.updateData();
            return;
        }

        var start = new Date();

        wrapper.col3.condenseWhite = Stat.s_empty;

        var pname = Utils.GetNormalizedPlayerName(wrapper.data.label);
        var name = Utils.GetPlayerName(wrapper.data.label);
        Macros.RegisterPlayerData(pname, wrapper.data, team);

        var key = "SF/" + pname + "/" + (Stat.s_data[name] ? Stat.s_data[name].loadstate : "0");
        var saved_icon = wrapper.data.icon;
        var saved_label = wrapper.data.label;

        // Add data for Win Chance calculation
        //Logger.addObject(data);
        if (Config.s_config.rating.showPlayersStatistics) {
            if (Stat.s_data[name] && Stat.s_data[name].stat)
                Stat.s_data[name].stat.alive = (wrapper.data.vehicleState & 1) != 0;
        }
        // Chance
        if (!Stat.s_empty && (Config.s_config.statisticForm.showChances || Config.s_config.statisticForm.showBattleTier) && wrapper.selected == true)
            s_winChances.showWinChances();

        // Alternative icon set
        if (!m_iconset)
            m_iconset = new IconLoader(this, completeLoad);
        m_iconset.init(wrapper.iconLoader,
            [ wrapper.data.icon.split(Defines.WG_CONTOUR_ICON_PATH).join(Defines.XVMRES_ROOT + ((team == Defines.TEAM_ALLY)
            ? Config.s_config.iconset.statisticFormAlly
            : Config.s_config.iconset.statisticFormEnemy)), wrapper.data.icon ]);

        wrapper.data.icon = m_iconset.currentIcon;
        wrapper.data.label = Cache.Get("SF." + saved_label, function() { return Macros.Format(saved_label, "{{name}}") });

        // Player/clan icons
        attachClanIconToPlayer(wrapper.data);

        if (Config.s_config.statisticForm.removeSquadIcon && wrapper.squad)
            wrapper.squad._visible = false;

        base.updateData();

        wrapper.data.icon = saved_icon;
        wrapper.data.label = saved_label;

        var team:Number = (wrapper.owner._name == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;

        // Set Text Fields
        var c:String = "#" + Strings.padLeft(wrapper.textField.textColor.toString(16), 6, '0');

        wrapper.textField.htmlText = "<font color='" + c + "'>" + Cache.Get(key + "/n", function() { return Macros.Format(saved_label,
            (team == Defines.TEAM_ALLY) ? Config.s_config.statisticForm.formatLeftNick : Config.s_config.statisticForm.formatRightNick,
            { }) } ) + "</font>";
        wrapper.col3.htmlText = "<font color='" + c + "'>" + Cache.Get(key, function() { return Macros.Format(saved_label,
            (team == Defines.TEAM_ALLY) ? Config.s_config.statisticForm.formatLeftVehicle : Config.s_config.statisticForm.formatRightVehicle,
            { }) } ) + "</font>";

        if (DEBUG_TIMES)
        {
            Logger.add("DEBUG TIME: BattleStatItemRenderer[" + wrapper.data.label + "]: updateDataImpl(): " +
                Utils.elapsedMSec(start, new Date()) + " ms");
        }
    }

    // override
    function updateStateImpl()
    {
        base.updateState();

        if (Config.s_config.battle.highlightVehicleIcon == false && (wrapper.selected || wrapper.data.squad > 10))
        {
            var tr = new flash.geom.Transform(wrapper.iconLoader);
            tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(
                (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0 ? "normal" : "normal_dead").transform;
        }
    }

    function attachClanIconToPlayer(data)
    {
        var cfg = Config.s_config.statisticForm.clanIcon;
        if (!cfg.show)
            return;

        if (m_clanIcon == null)
        {
            var x = (!m_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
                ? wrapper.iconLoader._x : wrapper.iconLoader._x + 80 - 5;
            m_clanIcon = PlayerInfo.createIcon(wrapper._parent._parent._parent, "clanicon_" + data.uid,
                cfg, x + wrapper._parent._parent._x + wrapper._parent._x + wrapper._x,
                wrapper.iconLoader._y + wrapper._parent._parent._y + wrapper._parent._y + wrapper._y,
                team);
        }
        PlayerInfo.setSource(m_clanIcon, Utils.GetPlayerName(data.userName), data.clanAbbrev);
        m_clanIcon["holder"]._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0) ? 100 : 50;
    }
}
/*data: {
  "igrLabel": "",
  "uid": 7294494,
  "position": 7,
  "denunciations": 5,
  "userName": "M_r_A[RISER]",
  "icon": "../maps/icons/vehicle/contour/germany-G_Tiger.png",
  "teamKiller": false,
  "vehicleState": 3,
  "speaking": false,
  "VIP": false,
  "vipKilled": 0,
  "roster": 0,
  "frags": 0,
  "vehAction": 0,
  "vehicle": "G.W. Tiger",
  "team": "team2",
  "squad": 0,
  "level": 9,
  "himself": true,
  "vehId": 22644499,
  "isEnabledInRoaming": false,
  "muted": false,
  "isPostmortemView": true,
  "clanAbbrev": "RISER",
  "isIGR": false,
  "label": "Флаттершай - л.."
}*/
