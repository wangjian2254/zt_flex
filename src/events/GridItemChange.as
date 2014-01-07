package events
{
	import flash.events.Event;
	
	public class GridItemChange extends Event
	{
		public static var GridItemChange:String ="GridItemChange";
		public function GridItemChange(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}