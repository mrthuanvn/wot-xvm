import net.wargaming.controls.UILoaderAlt;
import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;

class wot.VehicleMarkersManager.components.ContourIconProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function ContourIconProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function get initialized():Boolean
    {
        return xvm.wrapper.iconLoader != null && xvm.wrapper.iconLoader.initialized;
    }

    public function get iconLoader():UILoaderAlt
    {
        return xvm.wrapper.iconLoader;
    }

    public function get source():String
    {
        return xvm.m_source;
    }
}
