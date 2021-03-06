/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.techtree
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;
    import flash.utils.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.*;
    import xvm.techtree.*;

    public class TechTreeXvmView extends XvmViewBase
    {
        public function TechTreeXvmView(view:IView)
        {
            super(view);
        }

        public function get page():TechTreePage
        {
            return super.view as TechTreePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        // PRIVATE

        private function init():void
        {
            Dossier.loadAccountDossier(page.nationTree, page.nationTree.invalidateData);

            page.nationsBar.addEventListener(IndexEvent.INDEX_CHANGE, this.handleIndexChange);
            handleIndexChange();
        }

        private function handleIndexChange(e:IndexEvent = null) : void
        {
            page.nationTree.dataProvider.displaySettings.fromObject( {
                nodeRendererName:getQualifiedClassName(UI_NationTreeNodeSkinned),
                isLevelDisplayed:page.nationTree.dataProvider.displaySettings.isLevelDisplayed
            }, null);
            page.nationTree.invalidateData();
        }
    }
}
