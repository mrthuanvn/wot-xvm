package 
{
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.globalization.*;
    import flash.media.*;
    import flash.net.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.text.ime.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import net.wg.gui.tutorial.*;
    
    public dynamic class TutorialBattleLoading extends net.wg.gui.tutorial.TutorialBattleLoading
    {
        public function TutorialBattleLoading()
        {
            super();
            this.__setProp_mapBG_main_mapBG_0();
            return;
        }

        internal function __setProp_mapBG_main_mapBG_0():*
        {
            try 
            {
                mapBG["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            mapBG.autoSize = false;
            mapBG.enableInitCallback = false;
            mapBG.maintainAspectRatio = false;
            mapBG.source = "";
            mapBG.sourceAlt = "";
            mapBG.visible = true;
            try 
            {
                mapBG["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }
    }
}