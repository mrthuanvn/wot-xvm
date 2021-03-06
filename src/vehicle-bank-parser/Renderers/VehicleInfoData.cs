﻿using System;
using System.Collections.Generic;
using System.Globalization;

namespace VehicleBankParser.Renderers
{
    class VehicleInfoData : AbstractRenderer
    {
        Dictionary<string, int[]>[] mmTable;

        public VehicleInfoData()
        {
            OUTPUT_FILE = "src\\xvm\\xvm\\com\\xvm\\vehinfo\\VehicleInfoData.as";
            mmTable = buildMMTable();
        }

        protected override String getHeader()
        {
            return
@"/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.vehinfo
{
    import flash.utils.Dictionary;

    public class VehicleInfoData
    {
        private static var _data:Dictionary = null;

        public static function get data():Dictionary
        {
            if (_data == null)
                _data = _initData();
            return _data;
        }

        private static function _initData():Dictionary
        {
            var d:Dictionary = new Dictionary();
";
        }

        protected override String getFooter()
        {
            return @"
            // DO NOT REMOVE
            d['unknown'] =                           { tiers: [ 0, 0 ],   name: null, short: '?' };
            return d;
        }
    }
}";
        }

        protected override void writeLines(List<Vehicle> vehList)
        {
            Dictionary<string, Vehicle> speacialVeh = new Dictionary<string, Vehicle>();
            Dictionary<string, int[]> specialMM = getSpeacialMMTable();

            var level = 0;
            foreach (Vehicle veh in vehList)
            {
                if (veh.level != level)
                {
                    level = veh.level;
                    file.WriteLine("\n            // level " + level);
                }

                String vKey = veh.nation.ToLower() + "_" + veh.name.Replace("-", "_");
                if (specialMM.ContainsKey(vKey))
                {
                    speacialVeh.Add(vKey, veh);
                    continue;
                }
                int[] mm = mmTable[veh.level - 1][veh.getType()];
                file.WriteLine("            " + parseVehicle(veh, vKey, mm) + ";");
            }

            if (speacialVeh.Count > 0)
            {
                file.WriteLine("\n            // non-standard");
                foreach (KeyValuePair<string, Vehicle> pair in speacialVeh)
                {
                    file.WriteLine("            " + parseVehicle(pair.Value, pair.Key, specialMM[pair.Key]) + ";");
                }
            }
        }

        private String parseVehicle(Vehicle veh, String vKey, int[] mm)
        {
            //germany_PzVIB_Tiger_II_training:{ tiers: [ 8, 10 ],  name: null, short: "" },
            return (String.Format("{0} {{ tiers: [ {1}, {2} ], name: null, short: \"\" }}",
                String.Format("d[\"{0}\"] = ", vKey).PadRight(40),
                 mm[0], //min MM tier
                 mm[1]  //maxn MM tier
            ));
        }

        private Dictionary<string, int[]>[] buildMMTable()
        {
            int maxLevel = 10;
            // tier = [ type = [min, max], ,, ]
            Dictionary<string, int[]>[] mmTiers = new Dictionary<string, int[]>[maxLevel];

            string[] types = new string[5] { Vehicle.TYPE_LT, Vehicle.TYPE_MT, Vehicle.TYPE_HT, Vehicle.TYPE_TD, Vehicle.TYPE_SPG };

            for (int level = 1; level <= maxLevel; level++)
            {
                // type = [min, max]
                mmTiers[level - 1] = new Dictionary<string, int[]>();

                foreach (String typ in types)
                {
                    int[] battleTiers;

                    if (level == 4 && typ == Vehicle.TYPE_HT)
                        // T4 HT max+1
                        battleTiers = new int[2] { 4, 5 };
                    else if (level >= 4 && typ == Vehicle.TYPE_LT)
                        // LT: =T4 max+4  & >T4  min+1 max+4
                        battleTiers = new int[2] { (level == 4 ? level : level + 1), level + 4 };
                    else
                        // default: <T3 max+1 & >T3 max+2
                        battleTiers = new int[2] { level, (level < 3 ? level + 1 : level + 2) };

                    mmTiers[level - 1].Add(typ, battleTiers);
                }
            }

            return mmTiers;
        }

        private static Dictionary<string, int[]> getSpeacialMMTable()
        {
            return new Dictionary<string, int[]>()
            {
                // level 2
                {"usa_T2_lt", new int[2]{ 2, 4 }},
                {"germany_PzI", new int[2]{ 2, 2 }},

                // level 3
                {"ussr_M3_Stuart_LL", new int[2]{ 3, 4 }},
                {"ussr_BT_SV", new int[2]{ 3, 4 }},
                {"germany_PzII_J", new int[2]{ 3, 4 }},
                {"ussr_T_127", new int[2]{ 3, 4 }},

                // level 4
                {"ussr_Valentine_LL", new int[2]{ 4, 4 }},
                {"germany_B_1bis_captured", new int[2]{ 4, 4 }},
                {"ussr_A_32", new int[2]{ 4, 5 }},
                {"france_AMX40", new int[2]{ 4, 6 }},
                {"uk_GB04_Valentine", new int[2]{ 4, 6 }},
                {"uk_GB60_Covenanter", new int[2]{ 4, 6 }},
                {"ussr_T80", new int[2]{ 4, 6 }},

                // level 5
                {"germany_PzIV_Hydro", new int[2]{ 5, 6 }},
                {"ussr_Churchill_LL", new int[2]{ 5, 6 }},
                {"ussr_SU_85I", new int[2]{ 5, 6}},
                {"ussr_Matilda_II_LL", new int[2]{ 5, 6 }},
                {"usa_T14", new int[2]{ 5, 6 }},
                {"ussr_KV_220", new int[2]{ 5, 6 }},
                {"ussr_KV_220_action", new int[2]{ 5, 6 }},
                {"usa_M4A2E4", new int[2]{ 5, 6 }},
                {"uk_GB51_Excelsior", new int[2]{ 5, 6 }},
                {"uk_GB68_Matilda_Black_Prince", new int[2]{ 5, 6 }},
                {"uk_GB20_Crusader", new int[2]{ 5, 7 }},
                {"usa_M24_Chaffee", new int[2]{ 7, 12 }},

                // level 6
                {"germany_PzV_PzIV", new int[2]{ 6, 7 }},
                {"germany_PzV_PzIV_ausf_Alfa", new int[2]{ 6, 7 }},
                {"uk_GB63_TOG_II", new int[2]{ 6, 7 }},

                // level 7
                {"germany_Panther_M10", new int[2]{ 7, 8 }},
                {"ussr_T44_85", new int[2]{ 7, 8 }},
                {"ussr_T44_122", new int[2]{ 7, 8 }},
                {"germany_E_25",  new int[2]{ 7, 8 }},

                // level 8
                {"ussr_KV_5", new int[2]{ 8, 9 }},
                {"ussr_Object252", new int[2]{ 8, 9 }},
                {"france_FCM_50t", new int[2]{ 8, 9 }},
                {"usa_T26_E4_SuperPershing", new int[2]{ 8, 9 }},
                {"china_Ch23_112", new int[2]{ 8, 9 }},
                {"china_Ch14_T34_3", new int[2]{ 8, 9 }},
                {"china_Ch01_Type59", new int[2]{ 8, 9 }},
                {"china_Ch01_Type59_Gold", new int[2]{ 8, 9 }},
                {"germany_JagdTiger_SdKfz_185", new int[2]{ 8, 9 }}
            };

            //([A-z_0-9]+):\s+{ tiers: \[ ([0-9]{1,2}), ([0-9]{1,2})[\s,\]:A-z0-9"]+
        }

    }
}
