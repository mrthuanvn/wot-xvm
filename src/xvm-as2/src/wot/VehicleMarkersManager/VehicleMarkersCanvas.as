﻿/**
 * Proxy class for vehicle marker canvas
 * Used only for config preloading in the begin of the battle
 */
import com.xvm.Config;
import com.xvm.Utils;

class wot.VehicleMarkersManager.VehicleMarkersCanvas
{
    /////////////////////////////////////////////////////////////////

    public var wrapper:net.wargaming.ingame.VehicleMarkersCanvas;
    private var base:net.wargaming.ingame.VehicleMarkersCanvas;

    public function VehicleMarkersCanvas(wrapper:net.wargaming.ingame.VehicleMarkersCanvas, base:net.wargaming.ingame.VehicleMarkersCanvas)
    {
        this.wrapper = wrapper;
        this.base = base;
        VehicleMarkersCanvasCtor();
    }

    /////////////////////////////////////////////////////////////////

    /**
     * ctor()
     */
    private function VehicleMarkersCanvasCtor()
    {
        Utils.TraceXvmModule("VMM");

        // Check config
        if (Config.s_loaded != true)
            Config.LoadConfig();
    }
}
