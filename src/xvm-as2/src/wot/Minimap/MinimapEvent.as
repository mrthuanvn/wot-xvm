class wot.Minimap.MinimapEvent
{
    public static var MINIMAP_READY:String = "MINIMAP_READY";
    public static var PANEL_READY:String = "PANEL_READY";
    public static var LOST_PLAYERS_UPDATE:String = "LOST_PLAYERS_UPDATE";
    public static var ENEMY_REVEALED:String = "ENEMY_REVEALED";

    /** Used for camera atachments redraw */
    public static var ON_ENTRY_INITED:String = "ON_ENTRY_INITED";

    private var _type:String;
    private var _payload:Object;

    public function MinimapEvent(type:String, payload:Object)
    {
        _type = type;
        if (payload)
            _payload = payload;
    }

    public function get type():String
    {
        return _type;
    }

    public function get payload():Object
    {
        return _payload;
    }
}
