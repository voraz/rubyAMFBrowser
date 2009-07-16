package br.com.voraz.browser.layout.model.conection
{
	import mx.controls.Alert;
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class Conection
	{

		public static var endPointUrl:String = "../rubyamf_gateway";
        public static var channelName:String = "rubyamf";
		
		public function Conection()
		{
		}
		
        public function call(servico:String, metodo:String, callBack:Function, conexaoFalsa:Function=null, VO:Object=null) : void 
        {  
             // recuperando uma instância do RemoteObject pré-configurada  
             var connection:RemoteObject = instanceRemoteObject();  
   
             // Faz a busca do serviço solicitado  
             connection.source = servico;  
   
             // Mostra o cursor ocupado  
             connection.showBusyCursor = true;  
   
             // Mostra erros, se ocorrerem  
             if(conexaoFalsa==null)
             {
             	connection.addEventListener(FaultEvent.FAULT, onConnectionFault);
             }  else{
             	connection.addEventListener(FaultEvent.FAULT, conexaoFalsa);
             }
   
             // executa o método da classe de serviço  
             var op:Operation = connection.getOperation(metodo) as Operation; 
             op.addEventListener(ResultEvent.RESULT, callBack);  
   
             // quando houver a necessidade de enviar um objeto para o  servidor  
             if(VO==null){
             	op.send()
             }else{
             	op.send(VO);
             }
         }

         public function onConnectionFault(event:FaultEvent) : void 
         {  
             Alert.show(event.fault.getStackTrace(),"FALHA DE CONEXÃO!");  
         } 
         
         private function instanceRemoteObject():RemoteObject 
         { 
             // Cria um ChannelSet.  
             var cs:ChannelSet = new ChannelSet();  
   
             // Cria um Channel.  
             var customChannel:Channel = new AMFChannel(channelName, endPointUrl);  
   
             // Adiciona o Channel ao ChannelSet.  
             cs.addChannel(customChannel);  
   
             // instância o objeto  
             var connection:RemoteObject = new RemoteObject(channelName);  
   
             // Assign the ChannelSet to a RemoteObject instance.  
             connection.channelSet = cs;   
             
             // retorna a instância do RemoteObject  
             return connection;  
         }  
		
	}
}