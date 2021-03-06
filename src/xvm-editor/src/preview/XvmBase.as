package preview
{

import com.xvm.*;

import flash.filters.DropShadowFilter;
import flash.text.StyleSheet;
import flash.text.TextField;

import preview.*;
import preview.damage.*;

import utils.*;

public class XvmBase
{
    // Private static members
    private static var s_showExInfo:Boolean = false; // Saved "Extended Info State" for markers that appeared when Alt pressed.
    private static var s_blowedUp:Object = {}; // List of members that was ammoracked.

    public var m_entityName:String;
    public var m_playerFullName:String;
    public var m_curHealth:int;
    public var m_maxHealth:int;
    public var m_source:String;
    public var m_vname:String;
    public var m_level:int;
    public var m_speaking:Boolean;
    public var m_entityType:String; // TODO: is the same as proxy.m_team?

    public var m_showExInfo: Boolean;
    public var m_isDead: Boolean;
    public var m_vclass:String;

    // Vehicle State
    public var vehicleState: VehicleState;

    // UI Components
    public var clanIconComponent:ClanIconComponent;
    public var contourIconComponent: ContourIconComponent;
    public var damageTextComponent: DamageTextComponent;
    public var healthBarComponent: HealthBarComponent;
    public var levelIconComponent: LevelIconComponent;
    public var vehicleTypeComponent: VehicleTypeComponent;

    // Parent proxy instance (assigned from proxy)
    protected var _proxy:Marker;
    public function get proxy():Marker { return _proxy; }

    public function get isBlowedUp():Boolean { return s_blowedUp[m_playerFullName] != undefined; }

    /**
     * Text formatting functions
     */

    public function formatStaticText(format:String):String
    {
        var formatArr:Array;

        formatArr = format.split("{{nick}}");
        if (formatArr.length > 1)
            format = formatArr.join(m_playerFullName);
        formatArr = format.split("{{name}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetPlayerName(m_playerFullName));
        formatArr = format.split("{{clan}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetClanNameWithBrackets(m_playerFullName));
        formatArr = format.split("{{clannb}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetClanName(m_playerFullName));
        formatArr = format.split("{{squad}}");
        if (formatArr.length > 1)
            format = formatArr.join("1");
        formatArr = format.split("{{vehicle}}");
        if (formatArr.length > 1)
            format = formatArr.join(m_vname);
        formatArr = format.split("{{vehiclename}}");
        if (formatArr.length > 1)
            format = formatArr.join(m_source);
        formatArr = format.split("{{vtype}}");
        if (formatArr.length > 1)
            format = formatArr.join(Config.config.texts.vtype[Utils.vehicleClassToVehicleType(m_vclass)]);
        formatArr = format.split("{{level}}");
        if (formatArr.length > 1)
            format = formatArr.join(String(m_level));
        formatArr = format.split("{{rlevel}}");
        if (formatArr.length > 1)
            format = formatArr.join(XvmHelper.rlevel[m_level - 1]);
        formatArr = format.split("{{turret}}");
        if (formatArr.length > 1)
            format = formatArr.join(Config.config.turretMarkers.highVulnerability);

        format = StatFormat.FormatText(format, m_isDead);
        format = Utils.trim(format);

        return format;
    }

    public function formatDynamicText(format:String, curHealth:Number, delta:Number = 0, damageType:String = null):String
    {
        /* Substitutes macroses with values
         *
         * Possible format values with simple config:
         * incoming format -> outcoming format
         * {{hp}} / {{hp-max}} -> 725 / 850
         * Patton -> Patton
         * -{{dmg}} -> -368
         * {{dmg}} -> 622
         *
         * Called by
         * XVMShowDamage(curHealth, delta)
         * XVMUpdateUI(curHealth) with textField aspect
         */

        // skip strings without macroses
        if (format.indexOf("{{") == -1)
            return format;

        var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
        var dmgRatio: Number = delta ? Math.ceil(delta / m_maxHealth * 100) : 0;
        var formatArr:Array;

        // Text
        formatArr = format.split("{{hp}}");
        if (formatArr.length > 1)
            format = formatArr.join(String(curHealth));
        formatArr = format.split("{{hp-ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(String(hpRatio));
        formatArr = format.split("{{hp-max}}");
        if (formatArr.length > 1)
            format = formatArr.join(String(m_maxHealth));
        formatArr = format.split("{{dmg}}");
        if (formatArr.length > 1)
            format = formatArr.join(delta ? String(delta) : "");
        formatArr = format.split("{{dmg-ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(delta ? String(dmgRatio) : "");
        formatArr = format.split("{{dmg-kind}}");
        if (formatArr.length > 1)
            format = formatArr.join(delta ? damageType : "");

        // Colors
        formatArr = format.split("{{c:hp}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, curHealth));
        formatArr = format.split("{{c:hp-ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio));
        formatArr = format.split("{{c:hp_ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio));
        formatArr = format.split("{{c:dmg-kind}}");
        if (formatArr.length > 1)
            format = formatArr.join(delta ? Utils.GetDmgKindValue(damageType) : "")
        formatArr = format.split("{{c:dmg_kind}}");
        if (formatArr.length > 1)
            format = formatArr.join(delta ? Utils.GetDmgKindValue(damageType) : "")
        formatArr = format.split("{{c:system}}");
        if (formatArr.length > 1)
            format = formatArr.join(ColorsManager.getSystemColor(m_entityName, m_isDead, isBlowedUp));
        formatArr = format.split("{{c:vtype}}");
        if (formatArr.length > 1)
        {
            if (vehicleTypeComponent != null)
            {
                format = formatArr.join(Utils.GetVTypeColorValue(
                    Utils.vehicleClassToVehicleType(m_vclass)));
            }
        }

        format = Utils.trim(format);

        return format;
    }

    public function formatStaticColorText(format:String):String
    {
        if (!format || !isNaN(parseInt(format)))
            return format;

        format = StatFormat.FormatText(format, m_isDead).split("#").join("0x");

        return format;
    }

    public function formatDynamicColor(format:String, curHealth:Number, damageType:String = null):Number
    {
        var systemColor:Number =  ColorsManager.getSystemColor(m_entityName, m_isDead, isBlowedUp);

        if (!format)
            return systemColor;

        if (!isNaN(parseInt(format)))
            return Number(format);

        var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
        var formatArr:Array = format.split("{{c:hp}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, curHealth, "0x"));
        formatArr = format.split("{{c:hp-ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"));
        formatArr = format.split("{{c:hp_ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"));
        formatArr = format.split("{{c:dmg-kind}}");
        if (formatArr.length > 1)
            format = formatArr.join(damageType ? Utils.GetDmgKindValue(damageType, "0x") : "");
        formatArr = format.split("{{c:dmg_kind}}");
        if (formatArr.length > 1)
            format = formatArr.join(damageType ? Utils.GetDmgKindValue(damageType, "0x") : "");
        formatArr = format.split("{{c:system}}");
        if (formatArr.length > 1)
            format = formatArr.join(systemColor);
        formatArr = format.split("{{c:vtype}}");
        if (formatArr.length > 1)
        {
            if (vehicleTypeComponent != null)
            {
                format = formatArr.join(Utils.GetVTypeColorValue(
                    Utils.vehicleClassToVehicleType(m_vclass)));
            }
        }
        return !isNaN(parseInt(format)) ? Number(format) : systemColor;

        return systemColor;
    }

    public function formatDynamicAlpha(format:String, curHealth:Number):Number
    {
        if (!format)
            return 100;

        if (!isNaN(parseInt(format)))
            return Number(format);

        var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
        var formatArr:Array = format.split("{{a:hp}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, curHealth).toString());
        formatArr = format.split("{{a:hp-ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hpRatio).toString());
        formatArr = format.split("{{a:hp_ratio}}");
        if (formatArr.length > 1)
            format = formatArr.join(Utils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hpRatio).toString());

        var n:Number = !isNaN(parseInt(format)) ? Number(format) : 100;
        return (n <= 0) ? 1 : (n > 100) ? 100 : n;

        return 100;
    }

    /**
     * Components extension: MovieClip.onEnterFrame translation
     * TODO: Check performance & implementation
     */
    private function onEnterFrame():void
    {
        if (contourIconComponent != null && contourIconComponent.onEnterFrame != null)
            contourIconComponent.onEnterFrame();
    }

    /**
     * Create new TextField based on config
     */
    public function createTextField(cfg:Object):TextField
    {
        var textField: TextField = new TextField();
        //textField.width = 140;
        textField.height = 100;

		textField.selectable = false;

        textField.multiline = true;
        textField.wordWrap = false;

		textField.autoSize = cfg.font && cfg.font.align ? cfg.font.align : "center";

		textField.embedFonts = !cfg.font || !cfg.font.name || cfg.font.name == "$FieldFont";

        var style:StyleSheet = new StyleSheet();
        style.parseCSS(XvmHelper.createCSS(cfg.font,
            formatDynamicColor(formatStaticColorText(cfg.color), m_curHealth), "xvm_markerText"));
        textField.styleSheet = style;

//            Logger.add(XvmHelper.createCSS(cfg.font, formatDynamicColor(formatStaticColorText(cfg.color), m_curHealth), "xvm_markerText"));

        // TODO: replace shadow with TweenLite Shadow/Bevel (performance issue)
        if (cfg.shadow)
        {
            var sh_color:Number = formatDynamicColor(formatStaticColorText(cfg.shadow.color), m_curHealth);
            var sh_alpha:Number = formatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
            var filter:DropShadowFilter = Utils.createShadowFilter(cfg.shadow.distance,
                cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength);
            if (filter != null)
                textField.filters = [ filter ];
        }

        textField.alpha = formatDynamicAlpha(cfg.alpha, m_curHealth);
        textField.x = cfg.x - (textField.width / 2.0);
        textField.y = cfg.y - (/*textField._height*/ 31 / 2.0); // FIXIT: 31 is used for compatibility
        textField.visible = cfg.visible;

        return textField;
    }
}

}