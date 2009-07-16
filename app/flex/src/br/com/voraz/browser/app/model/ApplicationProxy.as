package br.com.voraz.browser.app.model
{
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ApplicationProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "ApplicationProxy";
		
		public function ApplicationProxy(data:Object=null){
			super(NAME, data);
		}

		
	}
}