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
	import robotlegs.async.command.api.ICommandExecutor;
	import robotlegs.async.responer.impl.Responder;
	import robotlegs.async.responer.impl.ResponseEvent;
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
	public class async_command_example extends Sprite
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private var context:IContext;

		private var executorResponder:Responder;

		private var responder:Responder;

		private var responseEvent:ResponseEvent;

		private var executor:ICommandExecutor;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function async_command_example()
		{
			super();
			context=new Context();
			context.logLevel=LogLevel.DEBUG;
			context.install(TraceLoggingExtension, VigilanceExtension, InjectableLoggerExtension, AsyncExtension);

			context.injector.map(MyAsyncCommand).toType(MyAsyncCommand);

			executorResponder=new Responder(onExecutorCallback, onExecutorCallback, "executor responder");
			executorResponder.log=context.getLogger(executorResponder);

			responder=new Responder(onResponderCallback, onResponderCallback, "event responder");
			executorResponder.log=context.getLogger(responder);

			responseEvent=new ResponseEvent("myEvent", responder);

			executor=context.injector.getInstance(ICommandExecutor);
			executor.executeCommand(MyAsyncCommand, responseEvent, executorResponder);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private function onExecutorCallback(data:Object=null):void
		{
			trace("onExecutorCallback:", data);
		}

		private function onResponderCallback(data:Object=null):void
		{
			trace("onResponderCallback:", data);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
import robotlegs.async.command.impl.AsyncCommand;

class MyAsyncCommand extends AsyncCommand
{
	override public function execute():void
	{
		trace("MyAsyncCommand->execute");
		complete();
	}
}
