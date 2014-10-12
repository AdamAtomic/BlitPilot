package
{
	import org.flixel.*;

	public class SpaceThing extends FlxSprite
	{
		public var speed:FlxPoint;

		public function SpaceThing(Graphic:Class,Rotations:int,Size:int,XSpeed:int,YSpeed:int):void
		{
			super();
			loadRotatedGraphic(Graphic,Rotations,-1,false,true);

			width = Size;
			height = Size;
			offset.x = (frameWidth - width)/2;
			offset.y = (frameHeight - height)/2;

			speed = new FlxPoint(XSpeed,YSpeed);
		}

		override public function update():void
		{
			if((velocity.x > 0) && (x > FlxG.width))
				kill();
			if((velocity.x < 0) && (x + width < 0))
				kill();
			if((velocity.y > 0) && (y > FlxG.height))
				kill();
			if((velocity.y < 0) && (y + height < 0))
				kill();
		}

		override public function reset(X:Number,Y:Number):void
		{
			super.reset(X,Y);

			var dir:uint = int(FlxG.random()*4);
			switch(dir)
			{
				case 0:
					x = -frameWidth;
					y = FlxG.random()*FlxG.height;
					velocity.x = speed.x/2 + FlxG.random()*speed.x;
					velocity.y = -10 + FlxG.random()*20;
					break;
				case 1:
					x = FlxG.width + 10;
					y = FlxG.random()*FlxG.height;
					velocity.x = -speed.x/2 - FlxG.random()*speed.x;
					velocity.y = -10 + FlxG.random()*20;
					break;
				case 2:
					x = FlxG.random()*FlxG.width;
					y = -frameHeight;
					velocity.x = -10 + FlxG.random()*20;
					velocity.y = speed.y/2 + FlxG.random()*speed.y;
					break;
				case 3:
					x = FlxG.random()*FlxG.width;
					y = FlxG.height + 10;
					velocity.x = -10 + FlxG.random()*20;
					velocity.y = -speed.y/2 - FlxG.random()*speed.y;
					break;
			}

			angle = FlxG.random()*360;
			angularVelocity = -360 + FlxG.random()*720;
		}
	}
}
