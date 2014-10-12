package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public var bgJunks:FlxGroup;
		public var bgTimer:Number;
		public var bgTimerDelay:Number;

		public var juiceBits:FlxGroup;

		public var powerups:FlxGroup;
		public var powerTimer:Number;
		public var powerTimerDelay:Number;
		public var juiceCount:int;

		public var asteroids:FlxGroup;
		public var timer:Number;
		public var timerDelay:Number;

		public var playerJets:FlxGroup;
		public var jetsTimer:Number;
		public var jetsTimerDelay:Number;

		public var player:Player;

		public var score:int;
		public var scoreDisplay:FlxText;
		public var lastScoreDisplay:FlxText;

		override public function create():void
		{
			addBackground(Assets.ImgNebulas,50,40);
			addBackground(Assets.ImgStars,200,3);

			bgJunks = new FlxGroup();
			add(bgJunks);
			bgTimer = 0;
			bgTimerDelay = 20;

			juiceBits = new FlxGroup();
			add(juiceBits);

			powerups = new FlxGroup();
			add(powerups);
			powerTimer = 0;
			powerTimerDelay = 240;
			juiceCount = 20;

			asteroids = new FlxGroup();
			add(asteroids);
			timer = 0;
			timerDelay = 45;

			playerJets = new FlxGroup();
			add(playerJets);
			jetsTimer = 0;
			jetsTimerDelay = 2;

			player = new Player();
			add(player);
			score = 0;

			scoreDisplay = new FlxText(FlxG.width/2-50,0,100);
			scoreDisplay.alignment = "center";
			scoreDisplay.size = 16;
			add(scoreDisplay);

			lastScoreDisplay = new FlxText(FlxG.width-50,0,50);
			lastScoreDisplay.alignment = "right";
			add(lastScoreDisplay);
			if(FlxG.score > 0)
				lastScoreDisplay.text = FlxG.score.toString();
		}

		public function addBackground(Graphic:Class,Quantity:int,Size:int):void
		{
			var i:int;
			for(i = 0; i < Quantity; i++)
			{
				var bg:FlxSprite = new FlxSprite(FlxG.random()*FlxG.width, FlxG.random()*FlxG.height);
				bg.loadGraphic(Graphic,true,false,Size,Size);
				bg.randomFrame();
				bg.solid = false;
				add(bg);
			}
		}

		override public function update():void
		{
			spawnThings();

			super.update();

			FlxG.overlap(asteroids,player,onCrash);
			FlxG.overlap(powerups,player,onPickup);
		}

		public function spawnThings():void
		{
			bgTimer--;
			if(bgTimer <= 0)
			{
				(bgJunks.recycle(BGJunk) as BGJunk).reset(0,0);
				bgTimer = bgTimerDelay;
			}

			powerTimer--;
			if(powerTimer <= 0)
			{
				(powerups.recycle(Powerup) as Powerup).reset(0,0);
				powerTimer = powerTimerDelay;
			}

			timer--;
			if(timer <= 0)
			{
				(asteroids.recycle(Asteroid) as Asteroid).reset(0,0);
				timer = timerDelay;
			}

			if(player.exists)
			{
				jetsTimer--;
				if(jetsTimer <= 0)
				{
					(playerJets.recycle(PlayerJet) as PlayerJet).reset(player.x,player.y);
					jetsTimer = jetsTimerDelay;
				}
			}
		}

		public function onCrash(Object1:FlxSprite,Object2:FlxSprite):void
		{
			FlxG.shake();
			FlxG.flash(0xffffffff,1.5,FlxG.resetState);
			player.kill();
			if(score > FlxG.score)
				FlxG.score = score;
		}

		public function onPickup(Object1:FlxSprite,Object2:FlxSprite):void
		{
			var px:int = 0;
			var py:int = 0;
			if(Object1 is Powerup)
			{
				Object1.kill();
				px = Object1.x;
				py = Object1.y;
			}
			if(Object2 is Powerup)
			{
				Object2.kill();
				px = Object2.x;
				py = Object2.y;
			}
			score++;
			scoreDisplay.text = score.toString();

			for(var i:int = 0; i < juiceCount; i++)
				(juiceBits.recycle(JuiceBit) as JuiceBit).reset(px,py);
		}
	}
}
