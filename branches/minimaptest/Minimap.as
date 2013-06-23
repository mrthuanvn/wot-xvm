import com.xvm.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.model.mapSize.*;
import wot.Minimap.model.SyncModel;
import wot.Minimap.shapes.*;
import wot.Minimap.view.*;

/**
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.Minimap
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.ingame.Minimap;
    public var base:net.wargaming.ingame.Minimap;

    public function Minimap(wrapper:net.wargaming.ingame.Minimap, base:net.wargaming.ingame.Minimap)
    {
        this.wrapper = wrapper;
        this.base = base;
        MinimapProxy.setReferences(base, wrapper);
        
        wrapper.xvm_worker = this;

        Utils.TraceXvmModule("MM");

        MinimapCtor();
    }

    function onEntryInited()
    {
        return this.onEntryInitedImpl.apply(this, arguments);
    }

    function correctSizeIndex()
    {
        return this.correctSizeIndexImpl.apply(this, arguments);
    }

    function sizeUp()
    {
        return this.sizeUpImpl.apply(this, arguments);
    }
    
    function scaleMarkers()
    {
        return this.scaleMarkersImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    public function MinimapCtor()
    {
        GlobalEventDispatcher.addEventListener(MinimapEvent.MINIMAP_READY, this, onReady);
        GlobalEventDispatcher.addEventListener(MinimapEvent.PANEL_READY, this, onReady);

        checkLoading();
    }

    /**
     * icons Z indexes from Minimap.pyc:
     *  _BACK_ICONS_RANGE = (25, 49)
     *  _DEAD_VEHICLE_RANGE = (50, 99)
     *  _VEHICLE_RANGE = (101, 150)
     *  _FIXED_INDEXES = {'cameraNormal': 100,
     *  'self': 151,
     *  'cameraStrategic': 152,
     *  'cell': 153 }
     */
    public static var MAX_DEAD_ZINDEX:Number = 99;
    public static var LOST_UNITS_INDEX:Number = MAX_DEAD_ZINDEX;
    public static var SQUARE_1KM_INDEX:Number = MAX_DEAD_ZINDEX - 1;
    public static var EXTERNAL_CUSTOM_INDEX:Number = MAX_DEAD_ZINDEX - 1;
    public static var CAMERA_NORMAL_ZINDEX:Number = 100;
    public static var SELF_ZINDEX:Number = 151;
    
    /** Simplified minimap interface for communication with other Python or Flash mods */
    public var externalDeveloperInterface:ExternalDeveloperInterface;

    /** Used at MinimapEntry to get testUid */
    public var sync:SyncModel;

    /**
     * Defines real map side size in meters.
     * Common values are 1km, 600m
     */
    private var mapSizeModel:MapSizeModel;
    private var mapSizeLabel:MapSizeLabel;

    /**
     * Shape to icon attachments.
     * Shows game related distances and direction.
     */
    private var circles:Circles;
    private var square:Square;
    private var lines:Lines;

    private var zoom:Zoom;

    private var isMinimapReady:Boolean = false;
    private var isPanelReady:Boolean = false;
    private var loadComplete:Boolean = false;
    private var mapExtended:Boolean = false;
    
    function scaleMarkersImpl(factor:Number)
    {
        if (MapConfig.enabled)
        {
            Features.instance.scaleMarkers();
        }
        else
        {
            /** Original WG scaling behaviour */
            base.scaleMarkers(factor);
        }
    }

    function onEntryInitedImpl()
    {
        base.onEntryInited();

        if (mapExtended)
        {
            SyncModel.instance.updateIconUids();
            
            /**
             * Camera object reconstruction occurs sometimes and all its previous props are lost.
             * Check if alpha is set.
             */
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ON_ENTRY_INITED));
            Features.instance.setCameraAlpha();
        }
    }

    function correctSizeIndexImpl(sizeIndex:Number, stageHeight:Number):Number
    {
        var featureSizeIndex:Number = Features.instance.disableMapWindowSizeLimitation(sizeIndex);
        
        return featureSizeIndex;
    }

    /** Suitable for manual debug tracing by pushing "=" button */
    function sizeUpImpl()
    {
        base.sizeUp();
    }

    // -- Private

    private function checkLoading():Void
    {
        wrapper.icons.onEnterFrame = function()
        {
            if (this.MinimapEntry0)
            {
                delete this.onEnterFrame;
                GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.MINIMAP_READY));
            }
        }
    }

    private function onReady(event:MinimapEvent):Void
    {
        switch (event.type)
        {
            case MinimapEvent.MINIMAP_READY:
                isMinimapReady = true;
                break;
            case MinimapEvent.PANEL_READY:
                isPanelReady = true;
                break;
        }

        loadComplete = isMinimapReady && isPanelReady;

        if (loadComplete && !mapExtended)
        {
            externalDeveloperInterface = new ExternalDeveloperInterface();

            if (MapConfig.enabled)
            {
                startExtendedProcedure();
            }

            mapExtended = true;
        }
    }

    private function startExtendedProcedure():Void
    {
        SyncModel.instance.updateIconUids();
        
        Features.instance.applyMajorMods();

        /**
         * Defines real map size in meters.
         */
        mapSizeModel = new MapSizeModel();
        var cellSize:Number = mapSizeModel.getCellSide();
        var fullSize:Number = mapSizeModel.getFullSide();

        /** Map size dependent */
        if (cellSize)
        {
            /** Draw map size at map corner */
            if (MapConfig.mapSizeLabelEnabled)
            {
                mapSizeLabel = new MapSizeLabel(cellSize);
            }

            /**
             * Draw customized circles.
             * Outlines distance in meters.
             */
            if (MapConfig.circlesEnabled)
            {
                circles = new Circles(fullSize); /** Total map side distance in meters */
            }

            /**
             * Draw customized circles.
             * Outlines distance in meters.
             */
            if (MapConfig.squareEnabled)
            {
                square = new Square(fullSize); /** Total map side distance in meters */
            }

            /**
             * Draw customized lines.
             * Outlines vehicle direction, gun horizontal traverse angle
             * and possibly distance in meters.
             */
            if (MapConfig.linesEnabled)
            {
                lines = new Lines(fullSize); /** Total map side distance in meters  */
            }
        }
    }
}
