package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class NotificationInvitesButtonMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function NotificationInvitesButtonMeta()
        {
            super();
            return;
        }

        public function handleClickS():void
        {
            App.utils.asserter.assertNotNull(this.handleClick, "handleClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.handleClick();
            return;
        }

        public var handleClick:Function=null;
    }
}
