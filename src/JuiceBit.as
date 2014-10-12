package
{
	import org.flixel.*;

	public class JuiceBit extends FlxSprite
	{
		public function JuiceBit():void
		{
			super();
			loadGraphic(Assets.ImgJuiceBits,true);
			addAnimation("blink",[5,0,0,1,2,3,4,5],15);
			solid = false;
		}

		override public function update():void
		{
			if(finished)
				kill();
		}

		override public function reset(X:Number,Y:Number):void
		{
			super.reset(X,Y);
			velocity.x = -150 + FlxG.random()*300;
			velocity.y = -150 + FlxG.random()*300;
			play("blink",true);
			scale.x = scale.y = 1 + FlxG.random()*2;
		}
	}
}
