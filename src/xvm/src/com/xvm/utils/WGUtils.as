﻿/**
 * XVM Utils
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.utils
{
    public class WGUtils
    {
        import org.idmedia.as3commons.util.StringUtils;

        public static function vehicleClassToVehicleType(vclass:String):String
        {
            switch (vclass)
            {
                case "lightTank": return "LT";
                case "mediumTank": return "MT";
                case "heavyTank": return "HT";
                case "SPG": return "SPG";
                case "AT-SPG": return "TD";
                default: return vclass;
            }
        }

        public static function GetPlayerName(fullplayername:String):String
        {
            if (fullplayername == null)
                return null;
            var pos:int = fullplayername.indexOf("[");
            return (pos < 0) ? fullplayername : StringUtils.trim(fullplayername.slice(0, pos));
        }

        public static function GetClanNameWithoutBrackets(fullplayername:String):String
        {
            if (fullplayername == null)
                return "";
            var pos:Number = fullplayername.indexOf("[");
            if (pos < 0)
                return "";
            var n:String = fullplayername.slice(pos + 1);
            return n.slice(0, n.indexOf("]"));
        }

        public static function GetClanNameWithBrackets(fullplayername:String):String
        {
            var clan:String = GetClanNameWithoutBrackets(fullplayername);
            return clan ? "[" + clan + "]" : "";
        }
    }
}
