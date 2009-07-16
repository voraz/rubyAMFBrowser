package br.com.voraz.browser.app.controller
{
	import br.com.voraz.browser.app.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ApplicationCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerMediator(new ApplicationMediator(notification.getBody()));
		}
	}
}