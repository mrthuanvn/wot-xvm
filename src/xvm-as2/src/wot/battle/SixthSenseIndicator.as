﻿/**
 * @author sirmax
 */
import com.greensock.easing.Linear;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.xvm.Defines;
import com.xvm.IconLoader;
import net.wargaming.controls.UILoaderAlt;

class wot.battle.SixthSenseIndicator
{
    var icon:UILoaderAlt;

    public function SixthSenseIndicator()
    {
        var il:IconLoader = new IconLoader(_root.sixthSenseIndicator, completeLoadSixthSenseIcon);
        icon = (UILoaderAlt)(_root.sixthSenseIndicator.attachMovie("UILoaderAlt", "icon", 0));
        il.init(icon, [ Defines.SIXTH_SENSE_IMG, "" ], false);
        icon.source = il.currentIcon;

        // override _root.sixthSenseIndicator.gotoAndPlay()
        _root.sixthSenseIndicator.gotoAndPlay2 = _root.sixthSenseIndicator.gotoAndPlay;
        _root.sixthSenseIndicator.gotoAndPlay = sixthSenseIndicator_gotoAndPlay;

        icon["onLoadInit"] = icon_onLoadInit;
    }

    function icon_onLoadInit(mc:MovieClip)
    {
        icon.setSize(mc._width, mc._height);
    }

    public function completeLoadSixthSenseIcon(event)
    {
        //Logger.add("completeLoadSixthSenseIcon");

        var icon = this.icon;
        icon.visible = false;
        _global.setTimeout(function()
        {
            icon._x = 97 - icon.content._width / 2;
            icon._y = 30;
            icon.content._alpha = 0;
            icon.visible = true;
        }, 1);

        // DEBUG
        //var a = "fade";
        //_global.setInterval(function() { a = a == "fade" ? "active" : "fade"; _root.sixthSenseIndicator.gotoAndPlay(a) }, 3000);
    }

    public function sixthSenseIndicator_gotoAndPlay(frame)
    {
        //Logger.add("sixthSenseIndicator_gotoAndPlay: " + frame);

        if (frame == "active")
            net.wargaming.managers.SoundManager.playSound("sixthsense", "normal", "");

        if (icon.source == "")
        {
            _root.sixthSenseIndicator.gotoAndPlay2(frame);
            return;
        }

        switch (frame)
        {
            case "active":
                var timeline = new TimelineLite();
                timeline.insert(TweenLite.to(icon.content, 0.2, { _alpha:100, ease:Linear.easeNone } ), 0);
                timeline.append(TweenLite.from(icon.content, 0.2, { tint:"0xFFFFFF", ease: Linear.easeNone } ), 0);
                break;
            case "inactive":
 		TweenLite.to(icon.content, 0.2, {_alpha:70});
                break;
            case "fade":
 		TweenLite.to(icon.content, 0.5, {_alpha:0});
                break;
        }
    }

}
