﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using VehicleBankParser.Properties;

static class Export
{
    /**
     * Make actionscript 2 code file with predefined array of obtained name\hp\turret data.
     */
    public static void generateAS2code(List<Vehicle> vehList)
    {
        StreamWriter file = new StreamWriter(Settings.Default.EXPORT_FILEPATH, false, Encoding.UTF8);

        //StreamWriter file = new StreamWriter(EXPORT_FILEPATH);

        writeHeader(file);
        writeLines(file, vehList);
        writeFooter(file);

        file.Close();
    }

    public static void generateJSON(List<Vehicle> vehList)
    {
      string s = "{";
      foreach (Vehicle veh in vehList)
        s += "\n  " + veh.ToJsonString() + ",";
      s += "\n  \"observer\": { \"level\": 0, \"name\": \"Observer\" }," +
           "\n  \"unknown\": { \"level\": 0, \"name\": \"UNKNOWN\" }\n}\n";
      File.WriteAllText(Settings.Default.EXPORT_FILEPATH_JSON, s);
    }

    private static void writeHeader(StreamWriter file)
    {
        file.WriteLine(
@"/**
* This file is automatically generated by VehicleBankParser program.
* Data extracted from WoT version 0.8.0
*/

class com.xvm.VehicleInfoData2
{
    /**
    * Vehicles in list has two turret modules.
    * Format:
    * vehicel name, stock max hp, turret status
    * Turret status: 2 - unable to mount top gun to stock turret, 1 - able
    */

    public static var data:Object = {
        //vname: { level, type, hpstock, hptop, turret, premium, nation, name }");
    }

    private static void writeLines(StreamWriter file, List<Vehicle> vehList)
    {
        var level = 0;
        foreach (Vehicle veh in vehList)
        {
            if (veh.level != level)
            {
                level = veh.level;
                file.WriteLine("\n        // level " + level);
            }
            file.WriteLine("        " + veh.ToAS2tring() + ",");
        }
    }

    private static void writeFooter(StreamWriter file)
    {
file.WriteLine(@"
        // unknown (FogOfWar)
        unknown: { level: 0, name: ""UNKNOWN"" }
    }
}
    ");
    }
}
