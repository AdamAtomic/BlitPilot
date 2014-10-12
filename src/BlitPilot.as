package
{
	import org.flixel.*;
	[SWF(width="960", height="720", backgroundColor="#000000")]

	public class BlitPilot extends FlxGame
	{
		public function BlitPilot()
		{
			FlxG.debug = true;
			super(320,240,PlayState,3,60,60);
		}
	}
}
