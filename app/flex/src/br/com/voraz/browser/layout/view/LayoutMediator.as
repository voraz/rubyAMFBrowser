package br.com.voraz.browser.layout.view
{
	import br.com.voraz.browser.layout.model.LayoutProxy;
	import br.com.voraz.browser.layout.view.components.LayoutView;
	
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class LayoutMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayoutMediator";
		private var proxy:LayoutProxy = new LayoutProxy();

		public function LayoutMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			facade.registerMediator(this);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					LayoutProxy.ON_SHOW,
					LayoutProxy.ON_CALL
					];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LayoutProxy.ON_CALL:
					onCallController(notification.getBody() as ResultEvent);
					break;
				case LayoutProxy.ON_SHOW:
					onShow(notification.getBody() as Array);
					break;
			}
		}
		
		public function callController(controller:String, method:String):void
		{
			proxy.call(controller, method);	
		}
		
		public function show():void
		{
			proxy.show();
		}
		
		private function onCallController(result:ResultEvent):void
		{
			classView.setResult(result.result);
		}
		
		private function onShow(controllers:Array):void
		{
			classView.setFields(controllers);
		}
		
		private function get classView():LayoutView
		{
			return viewComponent as LayoutView;
		}
		
		override public function onRegister():void
		{
			facade.registerProxy(proxy);
		}
		
	}
}