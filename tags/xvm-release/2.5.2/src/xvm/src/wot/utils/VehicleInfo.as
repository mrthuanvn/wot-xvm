/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Utils;
import wot.utils.VehicleInfoData;

class wot.utils.VehicleInfo
{
    // icon = ../maps/icons/vehicle/contour/usa-M24_Chaffee.tga
    public static function getName(str: String): String
    {
        // str is icon path?
        if (Utils.endsWith(".png", str))
            str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
        str = str.split("-").join("_");
        str = Utils.trim(str);
        return str;
    }

    public static function getVehicleId(str: String): String
    {
        if (Utils.endsWith(".png", str))
        {
            str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
            str = str.slice(str.indexOf("-") + 1);
            str = Utils.trim(str);
            return str.toUpperCase();
        }
        return null;
    }

    public static function getInfo(iconSource: String): Object
    {
        return VehicleInfoData.data[getName(iconSource)] || null;
    }

    public static function getVehicleNamesData():Object
    {
        var result:Object = {};
        for (var vname:String in VehicleInfoData.data)
        {
            result[vname] = VehicleInfoData.data[vname].name;
        }
        return result;
    }

    public static function mapVehicleName(iconSource:String, originalName:String):String
    {
        try
        {
            return Config.s_config.vehicleNames[getName(iconSource)] || originalName;
        }
        catch (ex:Error)
        {
            return originalName;
        }
    }
}