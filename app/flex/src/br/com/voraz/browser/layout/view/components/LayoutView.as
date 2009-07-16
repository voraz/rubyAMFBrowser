package br.com.voraz.browser.layout.view.components
{
	import br.com.voraz.browser.app.ApplicationFacade;
	import br.com.voraz.browser.layout.view.LayoutMediator;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;

	public class LayoutView extends LayoutView_base
	{
		private var mediator:LayoutMediator;
		[Bindable]
		private var dataObject:Object;
				
		public function LayoutView()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, started);
		}
		
		private function started(e:FlexEvent):void
		{
			mediator = new LayoutMediator(this);
			//ApplicationFacade.getInstance().sendNotification(ApplicationFacade.FIND_CONTROLLERS_LAYOUT);
			mediator.show();
		}
		
		//exibe os controllers
		public function setFields(controllers:Array):void
		{
			treeControllers.addEventListener(ListEvent.ITEM_CLICK, showMethods);
			treeControllers.dataProvider = controllers;
		}
		
		public function setResult(result:*):void
		{
			this.provider = new ArrayCollection();
			
			var params:Array = new Array();
			for(var param:String in result[0])
			{
				params.push(param);
			}
            
			for(var j:int=0; j<result.length; j++)
			{
				dataObject = new Object();
				dataObject.label = j.toString();
				
				var st:String = new String();
				var methods:Array = new Array();
				for(var i:int=params.length-1; i<params.length; i--)
				{
					 st += params[i]+": "+result[j][params[i]]+"\n";
				}
				dataObject.children = st;
				this.provider.addItemAt(dataObject, 0);
			}
		}
		
		//exibe os metodos de cada controller
		private function showMethods(e:ListEvent):void
		{
			treeMethods.dataProvider = e.itemRenderer.data.methods;
			buttonCall.addEventListener(MouseEvent.CLICK, callController);
		}
		
		private function callController(e:MouseEvent):void
		{
			var controller:String = treeControllers.selectedItem.name;
			var method:String = treeMethods.selectedItem as String;
			
			mediator.callController(controller, method);
		}
		
	}
}