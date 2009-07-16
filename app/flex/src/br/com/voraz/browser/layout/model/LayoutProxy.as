package br.com.voraz.browser.layout.model
{
	import br.com.voraz.browser.layout.model.conection.Conection;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class LayoutProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "LayoutProxy";
		
		public static const ON_SHOW:String = NAME+"onShow";
		public static const ON_CALL:String = NAME+"onCall";

		public function LayoutProxy(data:Object=null)
		{
			super(NAME, data);
		}

		public function call(controller:String, method:String):void
		{
			new Conection().call(controller, method, onCall, faultEvent, null);
		}
		
		public function show():void
		{
			new Conection().call("Rubyamf", "controllers", onShow, faultEvent, null);
		}

		private function onCall(result:ResultEvent):void
		{
			facade.sendNotification(ON_CALL, result);	
		}
		
		private function onShow(result:ResultEvent):void
		{
			facade.sendNotification(ON_SHOW, result.result);	
		}
		
		private function faultEvent(fault:FaultEvent):void
		{
			
		}
		
	}
}