package preview
{

import flash.display.MovieClip;

import mx.containers.Canvas;

import preview.*;

public class HealthBarProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function HealthBarProxy(xvm:preview.Xvm)
    {
        super(xvm);
    }

    public function get curHealth():Number
    {
        return xvm.m_curHealth;
    }

    public function get maxHealth():Number
    {
        return xvm.m_maxHealth;
    }
}

}
