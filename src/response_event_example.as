/**
 *
 * Copyright 2012(C) by Piotr Kucharski.
 * email: suspendmode@gmail.com
 * mobile: +48 791 630 277
 *
 * All rights reserved. Any use, copying, modification, distribution and selling of this software and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 *
 */
package
{
	import flash.display.Sprite;

	import robotlegs.async.AsyncExtension;
	import robotlegs.async.responer.api.IResponder;
	import robotlegs.async.responer.impl.Responder;
	import robotlegs.async.responer.impl.ResponseEvent;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;


	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class response_event_example extends Sprite
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private var context:IContext;

		public function response_event_example()
		{
			super();
			context=new Context();
			context.install(AsyncExtension);

			addEventListener("myEvent", onMyEvent);

			var responder:IResponder=new Responder(onResponderComplete, onResponderError, "my responder");

			var event:ResponseEvent=new ResponseEvent("myEvent", responder);

			dispatchEvent(event);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private function onResponderComplete(data:Object=null):void
		{
			trace("onResponderComplete", data);
		}

		private function onResponderError(info:Object=null):void
		{
			trace("onResponderError", info);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private function onMyEvent(event:ResponseEvent):void
		{
			var responder:IResponder=event.responder;
			responder.complete("complete");
			responder.error("error");
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
