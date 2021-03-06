import com.xvm.*;
import wot.Minimap.dataTypes.Player;

/**
 * PlayersPanelProxy class
 * provides simple wrapper to PlayersPanel.m_list._dataProvider Array
 * which contains information about players.
 *
 * Each array element contains following player data:
 *
  "uid": 2079007,
  "vehicle": "M18",
  "position": 6,
  "denunciations": 4,
  "team": "team1",
  "squad": 0,
  "level": 6,
  "himself": true,
  "vehId": 24036245,
  "userName": "Fei_Wong",
  "teamKiller": false,
  "VIP": false,
  "icon": "../maps/icons/vehicle/contour/usa-M18_Hellcat.png",
  "vipKilled": 0,
  "muted": false,
  "vehicleState": 3,   3 - alive; 2 - dead
  "speaking": false,
  "roster": 0,
  "isPostmortemView": true,
  "clanAbbrev": "ALONE",
  "frags": 0,
  "label": "Fei_Wong",
  "vehAction": 0
 *
 * @author ilitvinov87@gmail.com
 */

class wot.PlayersPanel.PlayersPanelProxy
{
    public static function get leftPanel():net.wargaming.ingame.PlayersPanel
    {
        //Logger.add("PlayersPanelProxy.leftPanel()");
        return net.wargaming.ingame.PlayersPanel(_root.leftPanel);
    }

    public static function get rightPanel():net.wargaming.ingame.PlayersPanel
    {
        //Logger.add("PlayersPanelProxy.rightPanel()");
        return net.wargaming.ingame.PlayersPanel(_root.rightPanel);
    }

    public static function getPlayerInfo(uid:Number):Player
    {
        //Logger.add("PlayersPanelProxy.getPlayerInfo()");
        return _getPlayerInfoFrom(_allyPlayers, uid) || _getPlayerInfoFrom(_enemyPlayers, uid);
    }

    public static function get allyUids():Array
    {
        //Logger.add("PlayersPanelProxy.allyUids()");
        return _allUidsOfTeam(_allyPlayers);
    }

    public static function get enemyUids():Array
    {
        //Logger.add("PlayersPanelProxy.enemyUids()");
        return _allUidsOfTeam(_enemyPlayers);
    }

    public static function get allUids():Array
    {
        //Logger.add("PlayersPanelProxy.allUids()");
        return allyUids.concat(enemyUids);
    }

    public static function isDead(uid:Number):Boolean
    {
        //Logger.add("PlayersPanelProxy.isDead()");
        var player:Object = getPlayerInfo(uid);
        return (player.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0;
    }

    public static function get self():Player
    {
        //Logger.add("PlayersPanelProxy.self()");
        var myTeam:Array = _allyPlayers;
        for (var i in myTeam)
        {
            var player:Player = myTeam[i];
            if (player.himself == true)
                return player;
        }

        return null;
    }

    // -- Private

    private static function _getPlayerInfoFrom(players:Array, uid:Number):Player
    {
        for (var i:Number = 0; i < players.length; i++)
            if (players[i].uid == uid)
                return players[i];

        return null;
    }

    private static function _allUidsOfTeam(players:Array):Array
    {
        var all:Array = [];

        for (var i:Number = 0; i < players.length; i++)
            all.push(players[i].uid);

        return all;
    }

    private static function get _allyPlayers():Array
    {
        return leftPanel.m_list._dataProvider;
    }

    private static function get _enemyPlayers():Array
    {
        return rightPanel.m_list._dataProvider;
    }
}
