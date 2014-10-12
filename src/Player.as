package
{
	import org.flixel.*;

	public class Player extends FlxSprite
	{
		public var speed:Number;
		public var gibCount:int;

		public function Player():void
		{
			super(FlxG.width/2,FlxG.height/2);
			loadRotatedGraphic(Assets.ImgShip,180,-1,false,true);

			width = 8;
			height = 8;
			offset.x = (frameWidth - width)/2;
			offset.y = (frameHeight - height)/2;

			speed = 5;
			gibCount = 15;
		}

		override public function update():void
		{
			if(x < 0)
			{
				x = 0;
				velocity.x = -velocity.x * 0.5;
			}
			if(x + width > FlxG.width)
			{
				x = FlxG.width - width;
				velocity.x = -velocity.x * 0.5;
			}
			if(y < 0)
			{
				y = 0;
				velocity.y = -velocity.y * 0.5;
			}
			if(y + height > FlxG.height)
			{
				y = FlxG.height - height;
				velocity.y = -velocity.y * 0.5;
			}

			if(FlxG.keys.LEFT)
				velocity.x -= speed;
			if(FlxG.keys.RIGHT)
				velocity.x += speed;
			if(FlxG.keys.UP)
				velocity.y -= speed;
			if(FlxG.keys.DOWN)
				velocity.y += speed;

			angle = FlxU.getAngle(new FlxPoint(),velocity);
		}

		override public function kill():void
		{
			super.kill();

			var gib:FlxSprite;
			for(var i:int = 0; i < gibCount; i++)
			{
				gib = new FlxSprite(x,y).loadGraphic(Assets.ImgGib);
				gib.velocity.x = velocity.x*0.5 - 100 + FlxG.random()*200;
				gib.velocity.y = velocity.y - 100 + FlxG.random()*200;
				gib.angle = FlxG.random()*360;
				gib.angularVelocity = -720 + FlxG.random()*1440;
				(FlxG.state as PlayState).add(gib);
			}
		}
	}
}
