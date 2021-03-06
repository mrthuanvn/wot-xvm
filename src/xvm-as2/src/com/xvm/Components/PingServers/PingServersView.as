import com.xvm.Components.PingServers.PingFieldProxy;

class com.xvm.Components.PingServers.PingServersView
{
    public static var QUALITY_BAD:String = "bad";
    public static var QUALITY_POOR:String = "poor";
    public static var QUALITY_GOOD:String = "good";
    public static var QUALITY_GREAT:String = "great";
    public static var STYLE_NAME_PREFIX:String = "xvm_ping_";
    
    private var cfg:Object;
    private var tfProxy:PingFieldProxy;
    private var fields:Array = [];

    public function PingServersView(cfg:Object, holder:MovieClip)
    {
        this.cfg = cfg;
        tfProxy = new PingFieldProxy(cfg, holder);
    }
    
    public function update(responseTimeList:Array)
    {
        tfProxy.clearAllFields();
        
        for (var i:Number = 0; i < responseTimeList.length; i++)
        {
            appendRowToFields(makeStyledRow(responseTimeList[i]));
        }
    }
    
    // -- Private
    
    private function makeStyledRow(pingObj:Object):String
    {
        var time:Number = pingObj.time;
        var cluster:String = pingObj.cluster;
        var raw:String = cluster + cfg.delimiter + time;
        
        return "<span class='" + STYLE_NAME_PREFIX + defineQuality(time) + "'>" + raw + "</span>";
    }
    
    private function defineQuality(time):String
    {
        if (time < cfg.threshold[QUALITY_GREAT])
            return QUALITY_GREAT;
        if (time < cfg.threshold[QUALITY_GOOD])
            return QUALITY_GOOD;
        else if (time < cfg.threshold[QUALITY_POOR]) 
            return QUALITY_POOR;
            
        return QUALITY_BAD; 
    }
    
    private function appendRowToFields(row:String):Void
    {
        var receiverTf:TextField = tfProxy.getReceiverField();
        
        if (receiverTf.htmlText != "")
            receiverTf.htmlText += "\n";
            
        receiverTf.htmlText += row;
        
        tfProxy.alignFields();
    }
}
