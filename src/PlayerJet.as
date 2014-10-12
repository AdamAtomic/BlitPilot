package
{
	import org.flixel.*;

	public class PlayerJet extends FlxSprite
	{
		public function PlayerJet():void
		{
			super();
			loadGraphic(Assets.ImgAcid,true);
			addAnimation("blink",[8,0,0,1,2,3,4,5,6,7,8],15);
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
			velocity.x = -10 + FlxG.random()*20;
			velocity.y = -10 + FlxG.random()*20;
			play("blink",true);
			scale.x = scale.y = 1 + FlxG.random()*2;
		}
	}
}
