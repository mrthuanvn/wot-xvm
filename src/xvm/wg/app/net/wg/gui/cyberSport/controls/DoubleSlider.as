package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.Slider;
   import scaleform.clik.controls.Button;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import scaleform.clik.events.SliderEvent;


   public class DoubleSlider extends Slider
   {
          
      public function DoubleSlider() {
         super();
      }

      public var leftThumb:Button;

      private var _leftValue:int = 0;

      private var snapToLeft:Boolean = false;

      private var snapToRight:Boolean = false;

      override protected function draw() : void {
         super.draw();
         this.updateLeftThumb();
      }

      override protected function onDispose() : void {
         super.onDispose();
         App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.doDragLeft,false);
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.endLeftDrag,false);
         this.leftThumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.beginDragLeft,false);
         this.leftThumb.removeEventListener(MouseEvent.MOUSE_UP,this.leftThumbOnMouseUpHandler);
         this.leftThumb.dispose();
         thumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag,false);
         thumb.removeEventListener(MouseEvent.MOUSE_UP,this.thumbOnMouseUpHandler);
         thumb.dispose();
         track.removeEventListener(MouseEvent.MOUSE_DOWN,this.trackPress,false);
         track.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
         track["left_progress_mask"].gotoAndStop(0);
         this.leftThumb.addEventListener(MouseEvent.MOUSE_DOWN,this.beginDragLeft,false,0,true);
         this.leftThumb.addEventListener(MouseEvent.MOUSE_UP,this.leftThumbOnMouseUpHandler);
         thumb.addEventListener(MouseEvent.MOUSE_UP,this.thumbOnMouseUpHandler);
      }

      override protected function beginDrag(param1:MouseEvent) : void {
         if(App.utils.commons.isLeftButton(param1))
         {
            this.snapToRight = true;
            super.beginDrag(param1);
         }
      }

      private function beginDragLeft(param1:MouseEvent) : void {
         var _loc3_:Point = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         if(value == this.leftValue)
         {
            _loc3_ = new Point(mouseX,mouseY);
            _loc3_ = this.localToGlobal(_loc3_);
            _loc4_ = thumb.hitTestPoint(_loc3_.x,_loc3_.y,true);
            _loc5_ = this.leftThumb.hitTestPoint(_loc3_.x,_loc3_.y,true);
            if((_loc4_) && (_loc5_))
            {
               this.beginDrag(param1);
               return;
            }
         }
         _thumbPressed = true;
         this.snapToLeft = true;
         var _loc2_:Point = globalToLocal(new Point(param1.stageX,param1.stageY));
         _dragOffset = {"x":_loc2_.x - this.leftThumb.x - this.leftThumb.width / 2};
         App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.doDragLeft,false,0,true);
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.endLeftDrag,false,0,true);
      }

      override protected function trackPress(param1:MouseEvent) : void {
         if(!App.utils.commons.isLeftButton(param1))
         {
            return;
         }
         _trackPressed = true;
         track.focused = _focused;
         var _loc2_:Point = globalToLocal(new Point(param1.stageX,param1.stageY));
         if(_loc2_.x < this.leftThumb.x)
         {
            this.moveLeftThumb(param1);
         }
         else
         {
            if(_loc2_.x > thumb.x)
            {
               this.moveRightThumb(param1);
            }
            else
            {
               if(_loc2_.x > this.leftThumb.x && _loc2_.x < thumb.x)
               {
                  this.updateBothThumbs(param1);
               }
            }
         }
      }

      private function updateBothThumbs(param1:MouseEvent) : void {
         var _loc2_:Number = _width - offsetLeft - offsetRight;
         var _loc3_:Number = lockValue((param1.localX * scaleX - offsetLeft) / _loc2_ * (_maximum - _minimum) + _minimum);
         if(_loc3_ > value && _loc3_ < this.leftValue)
         {
            return;
         }
         if(value == _loc3_ && this.leftValue < _loc3_)
         {
            this.thumbOnMouseUpHandler();
         }
         if(this.leftValue == _loc3_ && value > _loc3_)
         {
            this.leftThumbOnMouseUpHandler();
         }
         this.updateBothValues(_loc3_);
         _trackDragMouseIndex = 0;
         _dragOffset = {"x":0};
      }

      private function updateBothValues(param1:Number) : void {
         this.leftValue = this.value = param1;
         if(!liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value));
            dispatchEvent(new SliderEvent(SliderEvent.FIRST_VALUE_CHANGE,false,true,this._leftValue));
         }
      }

      public function get leftValue() : int {
         return this._leftValue;
      }

      public function set leftValue(param1:int) : void {
         this._leftValue = lockValue(param1);
         dispatchEvent(new SliderEvent(SliderEvent.FIRST_VALUE_CHANGE,false,true,this._leftValue));
         this.draw();
      }

      private function moveLeftThumb(param1:MouseEvent) : void {
         var _loc2_:Number = this.getMovingNewPosition(param1);
         if(this._leftValue == _loc2_ && _loc2_ > _value)
         {
            return;
         }
         if(this.leftValue > value && this.leftValue == _loc2_)
         {
            this.snapToLeft = true;
            this.leftThumbOnMouseUpHandler();
         }
         this.leftValue = _loc2_;
         if(!liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.FIRST_VALUE_CHANGE,false,true,_value));
         }
         _trackDragMouseIndex = 0;
         _dragOffset = {"x":0};
      }

      private function moveRightThumb(param1:MouseEvent) : void {
         var _loc2_:Number = this.getMovingNewPosition(param1);
         if(value == _loc2_ && _loc2_ < this._leftValue)
         {
            return;
         }
         if(this.leftValue < value && value == _loc2_)
         {
            this.snapToRight = true;
            this.thumbOnMouseUpHandler();
         }
         value = _loc2_;
         if(!liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value));
         }
         _trackDragMouseIndex = 0;
         _dragOffset = {"x":0};
      }

      private function getMovingNewPosition(param1:MouseEvent) : Number {
         var _loc2_:Number = _width - offsetLeft - offsetRight;
         return lockValue((param1.localX * scaleX - offsetLeft) / _loc2_ * (_maximum - _minimum) + _minimum);
      }

      protected function doDragLeft(param1:MouseEvent) : void {
         this.snapToLeft = false;
         var _loc2_:Number = this.getNewValue(param1);
         if(this._leftValue == _loc2_ || _loc2_ > _value)
         {
            return;
         }
         this._leftValue = _loc2_;
         this.updateLeftThumb();
         if(liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.FIRST_VALUE_CHANGE,false,true,this._leftValue));
         }
      }

      override protected function doDrag(param1:MouseEvent) : void {
         this.snapToRight = false;
         var _loc2_:Number = this.getNewValue(param1);
         if(value == _loc2_ || _loc2_ < this._leftValue)
         {
            return;
         }
         _value = _loc2_;
         this.updateThumb();
         if(liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value));
         }
      }

      private function getNewValue(param1:MouseEvent) : Number {
         var _loc2_:Number = track.width - offsetLeft - offsetRight;
         var _loc3_:Point = globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc4_:Number = _loc3_.x - _dragOffset.x;
         return lockValue((_loc4_ - offsetLeft) / _loc2_ * (_maximum - _minimum) + _minimum);
      }

      protected function updateLeftThumb() : void {
         var _loc2_:* = NaN;
         var _loc1_:Number = track.width - offsetLeft - offsetRight;
         this.leftThumb.x = (this._leftValue - _minimum) / (_maximum - _minimum) * _loc1_ - this.leftThumb.width / 2 + offsetLeft ^ 0;
         if(!enabled)
         {
            track["left_progress_mask"].gotoAndStop(0);
            return;
         }
         if(!_undefined)
         {
            _loc2_ = (this._leftValue - _minimum) / (_maximum - _minimum);
            track["left_progress_mask"].gotoAndStop(Math.round(_loc2_ * track["left_progress_mask"].totalFrames));
         }
         else
         {
            track["left_progress_mask"].gotoAndStop(0);
         }
      }

      override protected function updateThumb() : void {
         var _loc2_:* = NaN;
         var _loc1_:Number = track.width - offsetLeft - offsetRight;
         thumb.x = (_value - _minimum) / (_maximum - _minimum) * _loc1_ - thumb.width / 2 + offsetLeft ^ 0;
         if(!enabled)
         {
            track["progress_mask"].gotoAndStop(0);
            return;
         }
         if(!_undefined)
         {
            _loc2_ = (position - _minimum) / (_maximum - _minimum);
            track["progress_mask"].gotoAndStop(Math.round(_loc2_ * track["progress_mask"].totalFrames));
         }
         else
         {
            track["progress_mask"].gotoAndStop(0);
         }
      }

      override protected function scrollWheel(param1:Number) : void {
          
      }

      protected function endLeftDrag(param1:MouseEvent) : void {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.doDragLeft,false);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.endLeftDrag,false);
         if(!liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.FIRST_VALUE_CHANGE,false,true,this._leftValue));
         }
         _trackDragMouseIndex = undefined;
         _thumbPressed = false;
         _trackPressed = false;
      }

      private function leftThumbOnMouseUpHandler(param1:MouseEvent=null) : void {
         if(this.snapToLeft)
         {
            this.updateBothValues(this.leftValue);
            this.snapToLeft = false;
         }
      }

      private function thumbOnMouseUpHandler(param1:MouseEvent=null) : void {
         if(this.snapToRight)
         {
            this.updateBothValues(value);
            this.snapToRight = false;
         }
      }
   }

}