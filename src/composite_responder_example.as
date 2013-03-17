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
	import robotlegs.async.responer.api.ICompositeResponder;
	import robotlegs.async.responer.impl.Responder;
	import robotlegs.bender.extensions.enhancedLogging.InjectableLoggerExtension;
	import robotlegs.bender.extensions.enhancedLogging.TraceLoggingExtension;
	import robotlegs.bender.extensions.vigilance.VigilanceExtension;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;


	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class composite_responder_example extends Sprite
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private var context:IContext;

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
		public function composite_responder_example()
		{
			super();
			context=new Context();
            context.logLevel=LogLevel.DEBUG;
            context.install(TraceLoggingExtension, VigilanceExtension, InjectableLoggerExtension, AsyncExtension);
            
			var responderA:Responder=new Responder(onResponderAComplete, onResponderAError);
            responderA.log = context.getLogger(responderA);
			responderA.complete('responderA complete');
			responderA.error('responderA error');

			var responderB:Responder=new Responder(onResponderBComplete, onResponderBError);
            responderB.log = context.getLogger(responderB);
			responderB.complete('responderB complete');
			responderB.error('responderB error');

			var compositeResponder:ICompositeResponder=context.injector.getInstance(ICompositeResponder);
			compositeResponder.addResponder(responderA);
			compositeResponder.addResponder(responderB);
			compositeResponder.complete('composite complete');
			compositeResponder.error('composite error');
		}

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
		private function onResponderAComplete(data:Object=null):void
		{
				trace("onResponderAComplete", data);
		}
        
        private function onResponderAError(info:Object=null):void
        {
            trace("onResponderAError", info);
        }
        
        private function onResponderBComplete(data:Object=null):void
        {
            trace("onResponderBComplete", data);
        }
        
        private function onResponderBError(info:Object=null):void
        {
            trace("onResponderBError", info);
        }

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
