package xvm.hangar.components.WinChances
{
    import flash.display.Sprite;
    import flash.text.*;
    import net.wg.gui.lobby.battleloading.BattleLoading;
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;

    public class WinChances
    {
        private var page:BattleLoading;

        public function WinChances(page:BattleLoading)
        {
            if (Config.config.rating.showPlayersStatistics == false)
                return;
            if (Config.config.battleLoading.showChances == false)
                return;
            this.page = page;

            // Add stat loading handler
            Stat.loadBattleStat(this, onStatLoaded);
        }

        private var originalBattleText:String = null;
        private function onStatLoaded():void
        {
            if (originalBattleText == null)
            {
                originalBattleText = page.form.battleText.text;
                page.form.battleText.width += 100;
                page.form.battleText.x -= 50;
                page.form.battleText.height *= 2;
                page.form.battleText.styleSheet = Utils.createTextStyleSheet("chances", page.form.battleText.defaultTextFormat);
            }

            var chanceText:String = Chance.GetChanceText(Config.config.battleLoading.showChancesExp) || "";
            chanceText = '<span class="chances">' + chanceText + '</span>';
            page.form.battleText.htmlText = "<textformat leading='-3'>" + originalBattleText + "\n" + chanceText + "</textformat>";

            // TODO if (enableLog == true)
            // TODO     StatsLogger.saveStatistics("chance", Chance.lastChances);
        }
    }
}
