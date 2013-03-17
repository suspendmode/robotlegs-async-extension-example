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
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;


	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class responder_example extends Sprite
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private var context:IContext;

		public function responder_example()
		{
			super();
			context=new Context();
			context.install(AsyncExtension);

			var responder:IResponder=new Responder(onComplete, onError);
			responder.complete('complete');
			responder.error('error');

		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private function onComplete(data:Object=null):void
		{
			trace("onComplete", data);
		}

		private function onError(info:Object=null):void
		{
			trace("onError", info);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
